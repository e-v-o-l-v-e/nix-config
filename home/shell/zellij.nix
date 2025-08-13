{ config, ... }: {
  programs.zellij = {
    enableFishIntegration = false;
    attachExistingSession = false;
    exitShellOnExit = false;
  };
}
