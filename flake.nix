{
  description = "NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-lima.url = "github:nixos-lima/nixos-lima/";
  };
  
  outputs = inputs@{ nixpkgs, ... }:
  {
    nixosConfigurations.lima = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = { inherit inputs secrets; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
