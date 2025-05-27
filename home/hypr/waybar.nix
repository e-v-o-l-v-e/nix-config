{hostname, ...}: {
  programs.waybar = {
    enable = hostname == "waylander";
  };

  # stylix.targets.waybar.extraCss = ''
  #     window#waybar, tooltip {
  #         padding: 0;
  #         margin: 0;
  #         border-radius: 0px;
  #     }
  #   '';
}
