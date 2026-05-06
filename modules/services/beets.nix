{
  flake.modules.nixos.beets =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.server;

      musicDir = cfg.musicPath;
      musicUnmappedDir = cfg.musicUnmappedPath;
      logFile = "${cfg.logPath}/beets/import.log";

      chown-music = pkgs.writeShellApplication {
        name = "chown-music";
        runtimeInputs = [ pkgs.coreutils ];
        text = ''
          chown ${cfg.serverUserName}:${cfg.serverGroupName} "$@"
        '';
      };

      post-script = pkgs.writeShellApplication {
        name = "beets-post-script";
        runtimeInputs = with pkgs; [ fd ];
        text = ''
          fd "." ${musicDir} --changed-within "25min" -x sudo ${chown-music}/bin/chown-music {}
        '';
      };

      beets-config = pkgs.writeText "beets-config.yaml" ''
        directory: ${musicDir}
        library: /ssd/temp/library.db

        import:
          move: yes
          none_rec_action: ask
          copy: no
          write: yes
          autotag: yes
          log: ${logFile}
          quiet_fallback: skip
          incremental: yes
          incremental_skip_later: yes
          resume: yes
          duplicate_action: ask

        item_fields:
          multi_artist_separator: '; '

        match:
          strong_rec_thresh: 0.20

        plugins: embedart scrub lastgenre info musicbrainz lyrics substitute hook

        substitute:
          '^(Bigflo & Oli)$': '\1'
          '^(Dimitri Vegas & Like Mike)$': '\1'
          '^(for KING & COUNTRY)$': '\1'
          '^(Macklemore & Ryan Lewis)$': '\1'
          '^(Nick Cave & the Bad Seeds)$': '\1'
          '^(Polo & Pan)$': '\1'
          '^(Caballero & JeanJass)$': '\1'
          '^(.+)(,| & | feat | × ).*': '\1'
          '‐': '-'

        paths:
          default: %substitute{$albumartist}/$album%aunique{} $year/$track - $title
          singleton: Non-Album/$artist - $title
          comp: Compilations/$album%aunique{}_$year/$track - $title

        musicbrainz:
          host: musicbrainz.org
          https: no
          ratelimit: 1
          ratelimit_interval: 1.0
          extra_tags: []
          genres: no
          external_ids:
            discogs: no
            bandcamp: no
            spotify: no
            deezer: no
            beatport: no
            tidal: no
          data_source_mismatch_penalty: 0.5
          search_limit: 5

        ftintitle:
          auto: no

        fetchart:
          auto: yes
          maxwidth: 1200
          sources: itunes amazon albumart fanarttv coverart *

        embedart:
          auto: yes

        scrub:
          auto: yes

        lastgenre:
          auto: yes
          canonical: yes
          source: album
          force: yes
          count: 3
          fallback: '''
          separator: "; "

        lyrics:
          auto: no
          dist_thresh: 0.11
          fallback: null
          force: no
          print: no
          sources: [lrclib, google, genius, tekstowo]
          synced: yes

        replace:
          '[\\/]': _
          '^\.': _
          '[\x00-\x1f]': _
          '[:*?"<>|]': '''
          '\s+$': '''
          ' feat.?': ';'
          '‐': '-'

        hook:
          hooks:
            - event: cli_exit
              command: ${post-script}/bin/beets-post-script
      '';

      beet-import = pkgs.writeShellApplication {
        name = "beet-import";
        runtimeInputs = with pkgs; [
          beets
          coreutils
        ];
        text = ''
          echo "" >> ${logFile}
          date >> ${logFile}

          chown -R ${cfg.serverUserName}:${cfg.serverGroupName} ${musicUnmappedDir}
          chmod -R g+rwx ${musicUnmappedDir}

          BEETSDIR=${cfg.configPath}/beets beet import ${musicUnmappedDir} -q

          echo import finished >> ${logFile}

          find ${musicUnmappedDir} -type f \( \
            -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
            -o -iname '*.lrc' -o -iname '*.log' -o -iname '*.nfo' \
            \) -delete
          find ${musicUnmappedDir} -mindepth 1 -type d -empty -delete
        '';
      };
    in
    {
      options.beets.importPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        default = beet-import;
        description = "beet-import derivation, exposed for use in other modules (e.g. olivetin path)";
      };

      config = {
        security.sudo.extraRules = [
          {
            users = [ cfg.serverUserName ];
            commands = [
              {
                command = "${chown-music}/bin/chown-music";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];

        systemd.tmpfiles.rules = [
          "L+ ${cfg.configPath}/beets/config.yaml - - - - ${beets-config}"
        ];
        environment.sessionVariables.BEETSDIR = "${cfg.configPath}/beets";

        environment.systemPackages = [
          pkgs.beets
          beet-import
          chown-music
          post-script
        ];
      };
    };
}
