{ inputs, ... }:

let
  inherit (inputs.self) nixosModules;
in
{
  system = "x86_64-linux";
  modules = [
    nixosModules.system
    nixosModules.default
    {
      networking.hostName = "vps";
      user.name = "rico";

      facter.reportPath = ./facter.json;
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILex7jX9WjluE9nIucBjwb3oRR90F+aJUBY/lcANCbjm"
      ];

      home.stateVersion = "24.11";
      system.stateVersion = "24.11";
    }
  ];
}
