{ inputs, ... }:

let 
  mkOverlay = { nixpkgs }: (
    { baseDir, customOverlayArgs ? {}}:

    let
      byNameOverlayPath = baseDir + /by-name;
      customOverlayPath = baseDir + /custom.nix;

      mkOverlayByName   = import (nixpkgs + /pkgs/top-level/by-name-overlay.nix) byNameOverlayPath;
      mkOverlayByCustom = import customOverlayPath customOverlayArgs;
    in (
      finalPkgs: prevPkgs: (
        nixpkgs.lib.optionalAttrs (builtins.pathExists byNameOverlayPath) (
          mkOverlayByName finalPkgs prevPkgs
        ) // nixpkgs.lib.optionalAttrs (builtins.pathExists customOverlayPath) (
          mkOverlayByCustom finalPkgs prevPkgs
        )
      )
    )
  );
in {
  flake.lib = {
    mkOverlay = mkOverlay { inherit (inputs) nixpkgs; };
  };
}
