{
  description = "home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.jordan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

      # Adapted from
      # https://github.com/nix-community/home-manager/issues/2848#issuecomment-1134302739
      apps.${system}.update = {
        type = "app";
        program = (pkgs.writeScript "update-home" ''
          set -euo pipefail
          old_profile=$(nix profile list | grep home-manager-path | head -n1 | awk '{print $4}')
          echo $old_profile
          nix profile remove $old_profile
          ${self.homeConfigurations.jordan.activationPackage}/activate || (echo "restoring old profile"; nix profile install $old_profile)
        '').outPath;
      };
    };
}
