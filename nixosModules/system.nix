{
  config,
  lib,
  inputs,
  modulesPath,
  ...
}:

let
  inherit (config) boot;
  inherit (lib) mkIf mkDefault;
  inherit (inputs) disko nixos-facter-modules;
in
{
  imports = [
    disko.nixosModules.disko
    nixos-facter-modules.nixosModules.facter
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub = mkIf boot.loader.grub.enable {
    efiSupport = mkDefault true;
    efiInstallAsRemovable = mkDefault true;
  };

  disko.devices = {
    disk.disk1 = {
      device = mkDefault "/dev/disk/by-diskseq/1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };

          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };

    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        root = {
          size = "100%FREE";
          content = {
            type = "filesystem";
            # format = "ext4";
            format = "btrfs";
            mountpoint = "/";
            mountOptions = [
              # "defaults"
              "compress=zstd"
              "noatime"
            ];

            extraArgs = [ "-f" ]; # Override existing partition
          };
        };

      };
    };
  };
}
