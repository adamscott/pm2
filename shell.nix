{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "pm2-shell";

  buildInputs = with pkgs; [
    nodejs-14_x
    bashInteractive
  ];

  shellHook = ''

  '';
}
