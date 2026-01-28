{
  flake.modules.nixos.base = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.networkmanager.enable = true;
    programs.nano.enable = true;
  };

  flake.modules.homeManager.base = {
    programs.neovim.enable = true;
  };
}
