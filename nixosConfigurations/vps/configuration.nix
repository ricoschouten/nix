# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  modulesPath,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;

    device = "/dev/vda";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILex7jX9WjluE9nIucBjwb3oRR90F+aJUBY/lcANCbjm"
    ];
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
