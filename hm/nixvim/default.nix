{ pkgs, ... }:
# see https://nix-community.github.io/nixvim/ for a list of options you can set
{
  imports = [
    ./options.nix
  ];

  extraPackages = with pkgs; [
    fennel
  ];

  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };

  plugins.treesitter = {
    enable = true;
    settings.highlight.enable = true;
  };
}
