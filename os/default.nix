{
  users.users = {
    "dev" = {   
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 80 443 ];
  };
  
  programs.git = {
    enable = true;
  };
  
  programs.nh = {
    enable = true;
    flake = /etc/nixos;
  };
    
  programs.mosh = {
    enable = true;
    openFirewall = true;
  };
  
  services.openssh = {
    enable = true;
    openFirewall = true;
    allowSFTP = true;
  };
   
  time.timeZone = "Europe/Amsterdam";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "24.11";
}

