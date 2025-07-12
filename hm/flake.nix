{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # uncomment for extra-hardcore neovim customization
    # also uncomment anything labeled `(nixvim)`
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    let
      # TODO: CHANGE ME
      username = "jdoe";
      dotfilesDir = "/home/jdoe/dotfiles"; # so that nh can find your dotfiles semi-automatically
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.home-manager.flakeModules.default

        # (nixvim)
        # inputs.nixvim.flakeModules.auto
        # inputs.nixvim.flakeModules.nixvimConfigurations
        # inputs.nixvim.flakeModules.nixvimModules
      ];

      perSystem =
        { pkgs, ... }:
        {
          apps.activate = {
            type = "app";
            meta.description = "Activate the initial home-manager configuration";
            program = pkgs.lib.getExe (
              pkgs.writeShellApplication {
                name = "activate-home-manager";
                runtimeInputs = [ pkgs.nh ];
                text = ''
                  export NH_HOME_FLAKE="${dotfilesDir}"

                  nh home switch --ask
                '';
              }
            );
          };

          # format your dotfiles. See
          # https://github.com/numtide/treefmt-nix?tab=readme-ov-file#supported-programs
          # for a list of options
          treefmt = {
            programs.nixfmt.enable = true;
          };

          # (nixvim)
          # nixvimConfigurations.nixvim = inputs.nixvim.lib.evalNixvim {
          #   inherit system;
          #   modules = [ self.nixvimModules.default ];
          # };
        };

      # (nixvim)
      # nixvim.packages.enable = true;

      flake =
        let
          system = "x86_64-linux";
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit inputs username dotfilesDir;
            };

            modules = [
              ./home.nix
            ];
          };

          # (nixvim)
          # nixvimModules.default = ./nixvim;
        };
    };
}
