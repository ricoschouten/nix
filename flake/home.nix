{ inputs, ... }:

{
  withOverlays = with inputs; [
    (final: prev: {
      zjstatus = zjstatus.packages.${prev.system}.default;
    })
  ];

  nixDirAliases = {
    homeModule           = [ "home" ];
    homeModules          = [ "home/modules" ];
    homeConfigurations   = [ "home/configs" ];
  };
}
