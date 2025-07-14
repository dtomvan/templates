{
  outputs =
    { self }:
    let
      devShellGreet = ''
        # First steps
        1. git init; git add flake.nix; git commit -m 'initial commit'
        2. (if you use direnv) ln -s .envrc.recommended .envrc && direnv allow
        3. (if you don't use direnv) nix develop
      '';
    in
    {
      templates = {
        hm = {
          path = ./hm;
          description = "For starting a nice home-manager config integrated with nixvim";
          welcomeText = ''
            # First steps
            1. git init; git add \*\*/\*.nix; git commit -m 'initial commit'
            2. open `flake.nix` and edit the lines with "CHANGE ME"
            3. nix run .#activate
            4. (optional) uncomment the nixvim stuff in flake.nix and home.nix to start configuring neovim

            ## How do I rebuild my config?
            I've opted to not include the official `home-manager` script, and rather use `nix-community/nh`.

            `nh home switch` should do the job.
          '';
        };

        devenv = {
          path = ./devenv;
          description = "devshell through devenv";
          welcomeText =
            devShellGreet
            + ''

              WARNING: You will probably have to compile some rust for this to work because devenv isn't cached in nixpkgs
            '';
        };

        dev = {
          path = ./dev;
          description = "devshell without devenv";
          welcomeText = devShellGreet;
        };
      };

      defaultTemplate = self.templates.dev;
    };
}
