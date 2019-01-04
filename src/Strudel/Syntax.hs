module Strudel.Syntax where

import Data.Text ( Text )

type Id = Text

data Value
  = Atom Id
  | Lambda [Id] Expr

data Ty
  = TyAtom
  | Pair Ty Ty

-- ^ in Struel (Pie) everything is an expression
data Expr
  = ExTy Ty
  | ExVal Value
  | ExClaim Id Expr
  | ExDef Id Expr
  | ExApp Id Expr
