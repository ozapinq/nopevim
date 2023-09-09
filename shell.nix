{ pkgs ? import <nixpkgs> { } }:

let nopevim = import ./default.nix { inherit pkgs; };

in pkgs.mkShell {
  packages = [ nopevim ];
  buildInputs = [ nopevim.buildInputs ];
}
