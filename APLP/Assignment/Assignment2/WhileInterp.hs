{-
  Name: Parth Jayantilal Jain
  Class: CS 252
  Assigment: HW2
  Date: 28th Semptember,2017
  Description: Semantics of various operator is programmed
-}


module WhileInterp (
  Expression(..),
  Binop(..),
  Value(..),
  testProgram,
  run
) where

import Data.Map (Map)
import qualified Data.Map as Map

-- We represent variables as strings.
type Variable = String

-- The store is an associative map from variables to values.
-- (The store roughly corresponds with the heap in a language like Java).
type Store = Map Variable Value

data Expression =
    Var Variable                            -- x
  | Val Value                               -- v
  | Assign Variable Expression              -- x := e
  | Sequence Expression Expression          -- e1; e2
  | Op Binop Expression Expression
  | If Expression Expression Expression     -- if e1 then e2 else e3
  | While Expression Expression             -- while (e1) e2 
  | AND Expression Expression               -- and e1 e2
  | OR Expression Expression                -- or e1 e2
  | NOT Expression                          -- not e1
  deriving (Show)

data Binop =
    Plus     -- +  :: Int  -> Int  -> Int
  | Minus    -- -  :: Int  -> Int  -> Int
  | Times    -- *  :: Int  -> Int  -> Int
  | Divide   -- /  :: Int  -> Int  -> Int
  | Gt       -- >  :: Int -> Int -> Bool
  | Ge       -- >= :: Int -> Int -> Bool
  | Lt       -- <  :: Int -> Int -> Bool
  | Le       -- <= :: Int -> Int -> Bool
  deriving (Show)

data Value =
    IntVal Int
  | BoolVal Bool
  deriving (Show,Eq)


-- This function will be useful for defining binary operations.
-- The first case is done for you.
-- Be sure to explicitly check for a divide by 0 and throw an error.
applyOp :: Binop -> Value -> Value -> Value
applyOp Plus (IntVal i) (IntVal j) = IntVal $ i + j
applyOp Minus (IntVal i) (IntVal j) = IntVal $ i - j
applyOp Times (IntVal i) (IntVal j) = IntVal $ i * j
applyOp Divide (IntVal i) (IntVal j)
                                    | j == 0 = error "You cannot divide by zero"
                                    | otherwise = IntVal $ quot i j  
applyOp Gt (IntVal i) (IntVal j)
                                | i > j = BoolVal True
                                | otherwise = BoolVal False
applyOp Ge (IntVal i) (IntVal j)
                                | i >= j = BoolVal True
                                | otherwise = BoolVal False
applyOp Lt (IntVal i) (IntVal j)
                                | i < j = BoolVal True
                                | otherwise = BoolVal False
applyOp Le (IntVal i) (IntVal j)
                                | i <= j = BoolVal True
                                |otherwise = BoolVal False


-- Implement this function according to the specified semantics
evaluate :: Expression -> Store -> (Value, Store)
evaluate (Var x) s = case (Map.lookup x s) of
                    (Just v) -> (v,s)
                    _ -> error "Not in Store" 

evaluate (Op o e1 e2) s =
  let (v1,s1) = evaluate e1 s
      (v2,s') = evaluate e2 s1
  in (applyOp o v1 v2, s')
evaluate (Val v) s = (v,s)
evaluate (If e1 e2 e3) s = case (evaluate e1 s) of
                           ((BoolVal True),s) -> evaluate e2 s
                           ((BoolVal False),s) -> evaluate e3 s                      
evaluate (Assign x e) s =  case e of
                          (Val v) -> (v,Map.insert x v s)
                          _ -> evaluate (Assign x (Val y)) s1 where (y,s1) = evaluate e s
evaluate (Sequence e1 e2) s = case e1 of
                              Val v -> evaluate e2 s
                              _  -> evaluate (Sequence (Val y) e2) s1 where (y,s1) = evaluate e1 s  
evaluate (While e1 e2) s = case (evaluate e1 s) of
                           ((BoolVal True),s) -> evaluate (Sequence e2 (While e1 e2)) s
                           _ -> (BoolVal False,s)
evaluate (AND e1 e2) s = case (evaluate e1 s) of
                         ((BoolVal True),s) -> evaluate e2 s
                         ((BoolVal False),s) -> ((BoolVal False),s)
                         _ -> error "cannot apply operator AND"
evaluate (OR e1 e2) s = case (evaluate e1 s) of
                        ((BoolVal True),s) -> ((BoolVal True),s)
                        ((BoolVal False),s) -> evaluate e2 s
                        _ -> error "cannot apply operator OR"
evaluate (NOT e) s = case (evaluate e s) of
                     ((BoolVal True),s) -> ((BoolVal False),s)
                     ((BoolVal False),s) -> ((BoolVal True),s)
                     _ -> error "cannot apply operator Not"

-- Evaluates a program with an initially empty state
run :: Expression -> (Value, Store)
run prog = evaluate prog Map.empty

-- The same as run, but only returns the Store
testProgram :: Expression -> Store
testProgram prog = snd $ run prog


