{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-diskseq/1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          name = "ESP";
          type = "EF00";
          start = "1M";
          end = "128M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };

          priority = 1;
        };

        root = {
          size = "100%";
          content = {
            type = "btrfs";
            mountpoint = "/";
            mountOptions = [
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
