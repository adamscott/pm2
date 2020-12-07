{
  description = "pm2";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    let
      inherit (nixpkgs.lib) attrValues;
      inherit (flake-utils.lib) eachDefaultSystem mkApp;
    in
    eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };

          node2Nix = import ./default.nix {
            inherit pkgs;
          };

          pm2 = mkApp { drv = node2Nix.package; name = "pm2"; };
          pm2-dev = mkApp { drv = node2Nix.package; name = "pm2-dev"; };
          pm2-docker = mkApp { drv = node2Nix.package; name = "pm2-docker"; };
          pm2-runtime = mkApp { drv = node2Nix.package; name = "pm2-runtime"; };
        in {
          devShell = node2Nix.shell;
          defaultPackage = node2Nix.package;
          apps = {
            inherit
              pm2
              pm2-dev
              pm2-docker
              pm2-runtime;
          };
          defaultApp = pm2;
        }
      );
}
