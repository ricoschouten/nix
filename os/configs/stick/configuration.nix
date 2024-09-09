{ inputs, pkgs, ... }:

{
  imports = with inputs.self.nixosModules; [
    default
    fish
  ];
  
  networking.hostName = "stick";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

