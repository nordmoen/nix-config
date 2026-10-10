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
      mkHome =
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
            isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
          };

          modules = [
            inputs.nixvim.homeModules.nixvim
            ./home/default.nix
            ./home/hosts/${host}.nix
          ];
        };
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt);

      homeConfigurations = {
        "jorgen@x1-carbon" = mkHome {
          host = "x1-carbon";
          system = "x86_64-linux";
          username = "jorgen";
        };

      };
    };
}
