{ inputs, pkgs, ... }:

{
  imports = with inputs.self.nixosModules; [
    default
    fish
    vm
  ];
  
  networking.hostName = "machien";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  vm.enable = true;
}

