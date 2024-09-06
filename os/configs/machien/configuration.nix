{ inputs, pkgs, ... }:

{
  imports = with inputs.self.nixosModules; [
    default
    fish
  ];
  
  networking.hostName = "machien";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
}

