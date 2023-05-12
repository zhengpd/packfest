# Packfest

A tool to install/upgrade packages quickly. Packfest name comes from phrase
"packages manifest".

## Installation

```sh
brew install go-task

git clone <packfest-repo> packfest
cd packfest && task install
```

## Usage

```sh
cp example-packfest.yaml ~/.config/packfest.yaml

# edit packfest.yaml and then install all packages with
packfest install
```

Package sources of `packfest.yaml`:

- `packages.brew_formulae`: packages installed with `brew install`
- `packages.nixpkgs`: packages installed with `nix profile install`
- `packages.rubygems`: packages installed with `gem install`
- `packages.brew_casks`: TODO, packages installed with `brew install --cask`
