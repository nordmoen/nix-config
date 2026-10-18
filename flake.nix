{
  description = "Nordmoens Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # avoid a second nixpkgs
    };

    # Do NOT set inputs.nixpkgs.follows on nixvim — it's tested against
    # its own nixpkgs revision, and `follows` opts out of those guarantees.
    nixvim.url = "github:nix-community/nixvim";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );

      # ---- Factory: one call = one home configuration ------------------
      mkLinux =
        {
          host,
          system,
          username,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          # Values available to every module as normal arguments.
          extraSpecialArgs = {
            inherit
              inputs
              host
              username
              system
              ;
            isDarwin = false;
          };

          modules = [
            inputs.nixvim.homeModules.nixvim
            ./home/default.nix
          ];
        };

      # ---- Tooling shared by the devShell and the checks ----
      devTools =
        pkgs: with pkgs; [
          nixfmt # same formatter as `nix fmt`
          statix # nix linter (antipatterns)
          deadnix # unused/dead code finder
          nil # Nix LSP for editors (or `nixd`)
          nix-output-monitor # readable build output (`nom`)
          prek
        ];

      # ---- Reusable check: lint the whole tree ----
      lintCheck =
        pkgs:
        pkgs.runCommandLocal "check-nix-lint"
          {
            nativeBuildInputs = with pkgs; [
              statix
              deadnix
            ];
          }
          ''
            cd ${./.}
            echo "== statix =="
            statix check .
            echo "== deadnix =="
            deadnix --fail .
            touch $out
          '';

      # ---- Reusable check: formatting is canonical ----
      formatCheck =
        pkgs:
        pkgs.runCommandLocal "check-nix-format"
          {
            nativeBuildInputs = [ pkgs.nixfmt ];
          }
          ''
            cd ${./.}
            nixfmt --check $(find . -name '*.nix')
            touch $out
          '';
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt);

      homeConfigurations = {
        "jorgen@x1-carbon" = mkLinux {
          host = "x1-carbon";
          system = "x86_64-linux";
          username = "jorgen";
        };

      };

      # ---- `nix develop` ----
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = devTools pkgs;

          shellHook = ''
            # Wire the repo's prek hooks into .git/hooks on entry.
            if [ -d .git ] && [ ! -f .git/hooks/pre-commit ]; then
              prek install >/dev/null 2>&1 || true
            fi
            echo "nix-config dev shell — try: nix flake check | nix fmt | prek run -a"
          '';
        };
      });

      # ---- `nix flake check` ----
      checks = forAllSystems (
        pkgs:
        {
          lint = lintCheck pkgs;
          formatting = formatCheck pkgs;
        }
        // nixpkgs.lib.optionalAttrs (pkgs.stdenv.hostPlatform.system == "x86_64-linux") {
          # Actually build the home configuration for this host.
          "jorgen@x1-carbon" = self.homeConfigurations."jorgen@x1-carbon".activationPackage;
        }
      );
    };
}
