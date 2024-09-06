{ inputs, ... }:

{
  imports = with inputs.self.darwinModules; [
    default
  ];
}
