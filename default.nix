{ mkDerivation, base, hspec, hspec-megaparsec, megaparsec
, optparse-applicative, parser-combinators, prettyprinter
, prettyprinter-ansi-terminal, stdenv, tasty, tasty-hspec
, tasty-hunit, text
}:
mkDerivation {
  pname = "strudel";
  version = "0.0.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base megaparsec parser-combinators prettyprinter
    prettyprinter-ansi-terminal text
  ];
  executableHaskellDepends = [
    base megaparsec optparse-applicative parser-combinators
    prettyprinter prettyprinter-ansi-terminal text
  ];
  testHaskellDepends = [
    base hspec hspec-megaparsec megaparsec parser-combinators
    prettyprinter prettyprinter-ansi-terminal tasty tasty-hspec
    tasty-hunit text
  ];
  homepage = "https://github.com/jkopanski/strudel#readme";
  description = "Strudel programming language";
  license = stdenv.lib.licenses.bsd3;
}
