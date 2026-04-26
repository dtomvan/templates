{
  flake.modules.nixos.base = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.networkmanager.enable = true;
    programs.nano.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;
  };

  flake.modules.homeManager.base = {
    programs.neovim.enable = true;
  };
}
