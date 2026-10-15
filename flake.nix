{
  description = "Personal overlay for nixpkgs";

  inputs = {
    nixpkgs = {
      type  = "github";
      owner = "NixOS";
      repo  = "nixpkgs";
      ref   = "release-26.05";
    };

    parts = {
      type  = "github";
      owner = "hercules-ci";
      repo  = "flake-parts";
    };
  };

  outputs = inputs @ { self, parts, ... }: (
    parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        ./modules/nixpkgs.nix
        ./modules/lib.nix
        ./pkgs/overlay.nix
      ];
    }
  );
}
