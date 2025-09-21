{
  flake.modules.nixos.base = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
    };

    programs.nano.enable = true;
  };
}
