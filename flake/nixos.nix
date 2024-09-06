{
  nixDirAliases = {
    nixosModule          = [ "os" ];
    nixosModules         = [ "os/modules" ];
    nixosConfigurations  = [ "os/configs" ];
  };
}

