{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkDefault;
  inherit (inputs.nixos-shell) nixosModules;
in
{
  imports = [ nixosModules.nixos-shell ];

  config = {
    virtualisation = mkDefault {
      cores = 2;
      memorySize = 1024;
      diskSize = 50 * 1024;
      qemu.options = [
        "-bios"
        "${pkgs.OVMF.fd}/FV/OVMF.fd"
      ];
    };
  };
}
