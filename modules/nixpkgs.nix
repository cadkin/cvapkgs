{ self, inputs, ... }:

{
  perSystem = { pkgs, system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };

      overlays = [
        self.overlays.default
      ];
    };

    legacyPackages = pkgs;
  };
}
