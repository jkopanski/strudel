{ compiler ? "ghc863" }:

let
  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          "${compiler}" = pkgs.haskell.packages."${compiler}".override {
            overrides = haskellPackagesNew: haskellPackagesOld: rec {
              strudel = pkgs.haskell.lib.dontHaddock
                (
                  haskellPackagesNew.callPackage ./default.nix { }
                );
            };
          };
        };
      };
    };
  };

  pkgs = import <unstable> { inherit config; };

in
  { strudel = pkgs.haskell.packages.${compiler}.strudel;
  }
