{-
  Name: Parth Jayantilal Jain
  Class: CS 252
  Assigment: HW1
  Date: 09/05/17
  Description: This Program takes two big numbers and performs major tasks like addition,          subtraction,multiplication, powerof.
-}

module BigNum (
  BigNum,
  bigAdd,
  bigSubtract,
  bigMultiply,
  bigEq,
  bigDec,
  bigPowerOf,
  prettyPrint,
  stringToBigNum,
) where

type Block = Int -- An Int from 0-999

type BigNum = [Block]

maxblock = 1000

bigAdd :: BigNum -> BigNum -> BigNum
bigAdd x y = bigAdd' x y 0

bigAdd' :: BigNum -> BigNum -> Block -> BigNum
bigAdd' [] [] 0 = []
bigAdd' [] [] c = [c]
bigAdd' (y:ys) [] c = ((0 + y + c) `mod` 1000) : bigAdd' ys [] ((y + c) `quot` 1000)
bigAdd' [] (y:ys) c = ((0 + y + c) `mod` 1000) : bigAdd' [] ys ((y + c) `quot` 1000)
bigAdd' (x:xs) (y:ys) c = ((x + y + c) `mod` 1000) : bigAdd' xs ys ((x + y + c) `quot` 1000)

bigSubtract :: BigNum -> BigNum -> BigNum
bigSubtract x y =
  if length x < length y
    then error "Negative numbers not supported"
    else reverse $ stripLeadingZeroes $ reverse result
      where result = bigSubtract' x y 0

stripLeadingZeroes :: BigNum -> BigNum
stripLeadingZeroes (0:[]) = [0]
stripLeadingZeroes (0:xs) = stripLeadingZeroes xs
stripLeadingZeroes xs = xs

-- Negative numbers are not supported, so you may throw an error in these cases
bigSubtract' :: BigNum -> BigNum -> Block -> BigNum
bigSubtract' [] [] 1 = error "Result is Negative"
bigSubtract' [] [] 0 = []
bigSubtract' (x:xs) [] c = (x - c) : bigSubtract' xs [] 0
bigSubtract' (x:xs) (y:ys) c | ((x - y -c) < 0) = (1000 + (x - y) - c) : bigSubtract' xs ys 1
                             | otherwise = (x -y -c) : bigSubtract' xs ys 0

bigEq :: BigNum -> BigNum -> Bool
bigEq x y | (x == y) = True 
          | otherwise = False

bigDec :: BigNum -> BigNum
bigDec x = bigSubtract x [1]

bigMultiply :: BigNum -> BigNum -> BigNum
bigMultiply x [0] = [0] 
bigMultiply x y = bigAdd x (bigMultiply x (bigDec y))

bigPowerOf :: BigNum -> BigNum -> BigNum
bigPowerOf x [0] = [1]
bigPowerOf x y = bigMultiply x (bigPowerOf x (bigDec y))

prettyPrint :: BigNum -> String
prettyPrint [] = ""
prettyPrint xs = show first ++ prettyPrint' rest
  where (first:rest) = reverse xs

prettyPrint' :: BigNum -> String
prettyPrint' [] = ""
prettyPrint' (x:xs) = prettyPrintBlock x ++ prettyPrint' xs

prettyPrintBlock :: Int -> String
prettyPrintBlock x | x < 10     = ",00" ++ show x
                   | x < 100    = ",0" ++ show x
                   | otherwise  = "," ++ show x

stringToBigNum :: String -> BigNum
stringToBigNum "0" = [0]
stringToBigNum s = stringToBigNum' $ reverse s

stringToBigNum' :: String -> BigNum
stringToBigNum' [] = []
stringToBigNum' s | length s <= 3 = read (reverse s) : []
stringToBigNum' (a:b:c:rest) = block : stringToBigNum' rest
  where block = read $ c:b:a:[]


