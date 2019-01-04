module Strudel.Parser where

-- base
import Control.Applicative ( Alternative, (<|>), (*>), some )
import Control.Monad       ( MonadPlus )
import Data.Void           ( Void )

-- megaparsec
import           Text.Megaparsec            ( MonadParsec, Parsec )
import qualified Text.Megaparsec.Char       as Char
import qualified Text.Megaparsec.Char.Lexer as Lexer

-- parser-combinators
import Control.Applicative.Combinators ( between )

-- text
import           Data.Text ( Text )
import qualified Data.Text as T

-- strudel
import Strudel.Syntax

newtype Parser a = Parser { unParser :: Parsec Void Text a }
  deriving ( Functor
           , Applicative
           , Monad
           , Alternative
           , MonadPlus
           , MonadParsec Void Text
           )

atom :: Parser Value
atom = tick *> (Atom . T.pack <$> some (Char.letterChar <|> Char.char '-'))

lexeme :: Parser a -> Parser a
lexeme = Lexer.lexeme space

tick :: Parser ()
tick = symbol "'" *> pure ()

symbol :: Text -> Parser Text
symbol = Lexer.symbol space

parens :: Parser a -> Parser a
parens = between (symbol "(") (symbol ")")

space :: Parser ()
space = Lexer.space Char.space1 lineComment blockComment

lineComment :: Parser ()
lineComment = Lexer.skipLineComment ";"

blockComment :: Parser ()
blockComment = Lexer.skipBlockComment "#|" "|#"
