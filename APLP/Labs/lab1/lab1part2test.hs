fizzbuzz :: Int -> String
fizzbuzz n = unwords [ if x `mod` 15 == 0 then "fizzbuzz " else if x `mod` 3 == 0 then "fizz " else if x `mod` 5 == 0 then "buzz " else show x ++ " " | x <- [1..n]]
