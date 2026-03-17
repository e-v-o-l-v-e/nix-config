{ config, lib, ... }: let
  cfg = config.server; 
in {
  services.lasuite-docs.domain
}
