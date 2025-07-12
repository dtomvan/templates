{
  username,
  dotfilesDir,
  pkgs,
  lib,
  config,
  ...
}:
# see `man home-configuration.nix` after installing HM for a list of options
{
  home.packages = with pkgs; [
    nh
    nix-output-monitor
    # uncomment to add your nixvim config to your home-manager config
    # inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim
  ];

  # useful for systems that aren't NixOS, because it's a very quick handler and
  # it has a lot of packages at its expense
  programs.command-not-found = {
    enable = true;
    dbPath = "${pkgs.path}/programs.sqlite";
  };

  # useful for devshells with nix. learn more at https://direnv.net/
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # let HM manage your shell, useful for all the kinds of integrations they got
  programs.bash = {
    enable = true;
    bashrcExtra = # bash
      ''
        # if you had any previous configurations, they can go here
      '';
  };

  home = {
    # please set these to the correct username/paths
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables.NH_HOME_FLAKE = dotfilesDir;

    shell.enableShellIntegration = true;

    stateVersion = "25.05";
  };
}
