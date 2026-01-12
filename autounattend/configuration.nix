{ pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  users.users.alice = {
    isNormalUser = true;
    initialPassword = "me";
    extraGroups = [ "wheel" ];
  };

  networking.hostName = "nixos";
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.nh.flake = lib.mkForce "/etc/nixos/";
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "26.05";
}
