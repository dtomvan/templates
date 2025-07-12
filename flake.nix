{
  outputs =
    { self }:
    {
      templates = {
        hm = {
          path = ./hm;
          description = "For starting a nice home-manager config integrated with nixvim";
          welcomeText = ''
            First steps:
              1. git init; git add **/*.nix; git commit -m 'initial commit'
              2. open `flake.nix` and edit the lines with "CHANGE ME"
              3. nix run .#activate
              4. (optional) uncomment the nixvim stuff in flake.nix and home.nix to start configuring neovim

            How do I rebuild my config?
              -- I've opted to not include the official `home-manager` script, and rather use `nix-community/nh`.
              `nh home switch` should do the job.
          '';
        };

        dev = {
          path = ./dev;
          description = "devshell for any language or environment";
          welcomeText = ''
            First steps:
              1. git init; git add flake.nix; git commit -m 'initial commit'
              2. (if you use direnv) ln -s .envrc.recommended .envrc && direnv allow
              3. (if you don't use direnv) nix develop

          '';
        };
      };

      defaultTemplate = self.templates.dev;
    };
}
