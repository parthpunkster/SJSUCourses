> import Data.List

Experiment with foldl, foldr, and foldl'

First, implement your own version of the foldl function,
defined as myFoldl

> myFoldl :: (a -> b -> a) -> a -> [b] -> a
> myFoldl f acc [] = acc
> myFoldl f acc (x:xs) = myFoldl f (f acc x) xs 


Next, define a function to reverse a list using foldl.

> myReverse :: [a] -> [a]
> myReverse lst = foldl (\acc x -> x : acc) [] lst   


Now define your own version of foldr, named myFoldr

> myFoldr :: (a -> b -> b) -> b -> [a] -> b
> myFoldr f acc [] = acc
> myFoldr f acc (x:xs) = f x (myFoldr f acc xs)



Now try using foldl (the library version, not yours) to sum up the numbers of a large list.
Why is it so slow?

> sum' xs = foldl (+) 0 xs 

Instead of foldl, try using foldl'.

> sum1 xs = foldl' (+) 0 xs

Why is it faster?
(Read http://www.haskell.org/haskellwiki/Foldr_Foldl_Foldl%27 for some hints)
Ans: foldl' is faster because it computes the value, and doesnt behave lazily while calculation

For an extra challenge, try to implement foldl in terms of foldr.
See http://www.haskell.org/haskellwiki/Foldl_as_foldr for details.
Ans: I tried implementing it, and also read the link but was not able to figure out the exact usage of seq.



Next, using the map function, convert every item in a list to its absolute value

> listAbs :: [Integer] -> [Integer]
> listAbs xs = map abs xs

Finally, write a function that takes a list of Integers and returns the sum of
their absolute values.

> sumAbs :: [Integer] -> Integer
> sumAbs xs = sum (listAbs xs)

