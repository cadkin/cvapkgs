{ self, ... }:

{
  flake.overlays = rec {
    cvapkgs = self.lib.mkOverlay {
      baseDir = ./.;
    };

    default = cvapkgs;
  };
}
