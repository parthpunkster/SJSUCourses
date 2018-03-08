fizzbuzz 0 = ""
fizzbuzz n = if (n < 0)
then ""
else if(n `mod` 15 == 0)
then fizzbuzz (n-1) ++ " fizzbuzz"
else if (n `mod` 5 == 0)
then fizzbuzz (n-1) ++ " buzz"
else if (n `mod` 3 == 0)
then fizzbuzz (n-1) ++ " fizz"
else fizzbuzz (n-1) ++ " " ++ show n
