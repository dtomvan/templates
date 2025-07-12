# templates

Opinionated nix flake templates. I plan to use this personally to onboard
people I know on nix/home-manager or to write a quick and dirty config from
scratch e.g. in a VM.

The template names speak for themselves.

This is probably not for you, I'd redirect you to [the official templates](https://github.com/nixos/templates) instead.

## Usage with NixOS

To replace the official templates with this one, you can set the following NixOS options:
```nix
nix.registry.templates = {
  from = {
    type = "indirect";
    id = "templates";
  };
  to = {
    owner = "dtomvan";
    repo = "templates";
    type = "github";
  };
};
```
