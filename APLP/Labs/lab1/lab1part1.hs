maxNum :: [Integer] -> Integer
maxNum [x] = x
maxNum (x:xs) = if (x > restOfXs)
                    then x
                else restOfXs
                where restOfXs = maxNum xs
maxNum _ = error "Not implemented"
