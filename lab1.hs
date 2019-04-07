absValue :: Int -> Int

absValue n
	| n < 0 = n * (-1)
	| otherwise = n
-----------------------------------------------
power :: Int -> Int -> Int

power x p
	| p == 0 = 1
	| otherwise = x * power x (p-1)
------------------------------------------------
isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n = comprova 2
	where 
		comprova :: Int -> Bool
		comprova c
			|c * c > n = True
			|mod n c == 0 = False
			|otherwise = comprova (c+1)
---------------------------------------
slowFib :: Int -> Int
slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib (n-1) + slowFib (n-2)
----------------------------------------
quickFib :: Int -> Int
quickFib n = fst (fib n)

fib :: Int -> (Int, Int)
fib 0 = (0, 0)
fib 1 = (1, 0)
fib n = (a+b, a)
	where (a, b) = fib (n-1)

--LLISTES
myLength :: [Int] -> Int
myLength[] = 0
myLength (x:xs) = 1 + myLength xs

----------------------------------------
myMaximum :: [Int] -> Int

myMaximum [n] = n

myMaximum (x:xs) 
	|x > max = x
	|otherwise = max
	where max = myMaximum xs
-------------------------------------------
average :: [Int] -> Float 

average [n] = fromIntegral n
average (x:xs) =  (fromIntegral v) / (fromIntegral u + 1)
	where u =  myLength xs
	      v = (sumals xs) + x

sumals :: [Int] -> Int 
sumals [n] = n
sumals (x:xs) = x + sumals xs
-----------------------------
buildPalindrome :: [Int] -> [Int]
--buildPalindrome [] = []
buildPalindrome l = palindromaux l l

palindromaux :: [Int] -> [Int] -> [Int]
palindromaux [] l = l 
palindromaux (x:xs) ln = palindromaux xs (x:ln) 
--buildPalindrome (x:xs) = (reverse xs ++ [x]) ++ (x:xs)
-----------------opcio molt mes simple
palind :: [Int] -> [Int]
--
palind l = reverse l ++ l
-----------------------------------------------
--remove :: [Int] -> [Int] -> [Int]
--remove x y = [a| a <- x , not (a  `elem` y)]  
------------------------------------------------
flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs) = x ++ flatten xs
------------------------------------------------
oddsNevens :: [Int] -> ([Int],[Int])

oddsNevens l = odNeaux l [] []

odNeaux :: [Int] -> [Int] -> [Int] -> ([Int], [Int])
odNeaux [] y z = (y,z)
odNeaux (x:xs) y z 
	|mod x 2 /= 0 = odNeaux xs (y++[x]) z
	|otherwise = odNeaux xs y (z++[x])
------------------------------------------------
primeDivisors :: Int -> [Int]
primeDivisors 0 = []
primeDivisors 1 = []
primeDivisors n = priDiaux 2 []
	where 
	priDiaux :: Int -> [Int] -> [Int]
	priDiaux m l
		|m > n = l
		|(isPrime m) && (mod n m) == 0 = (m:priDiaux (m+1) l)
		|otherwise = priDiaux (m+1) l
				
-----------------------------------ORDENACIO
insert :: [Int] -> Int -> [Int]
insert [] n = [n]
insert (x:xs) n 
	|n <= x = n:([x]++xs)
	|otherwise = x:insert xs n
isort :: [Int] -> [Int]
isort[] = []
isort (x:xs) = insert (isort xs) x
------------------------------------
remove :: [Int] -> Int -> [Int]
remove [] n = []
remove (x:xs) n 
	|x == n = xs
	|otherwise = x:(remove xs n)
ssort :: [Int] -> [Int]
ssort [] = []
ssort l = u : ssort(remove l u)
	where u = minimum l
-----------------------------------
merge :: [Int] -> [Int] -> [Int]
merge li la = mergeaux li la

mergeaux :: [Int] -> [Int] -> [Int]
mergeaux [] [] = []
mergeaux [] (y:ys ) = (y:(mergeaux [] ys))
mergeaux (x:xs ) [] = (x:(mergeaux xs []))
mergeaux (x:xs) (y:ys)
	|(x <= y)  = (x:(mergeaux xs (y:ys)))
	|otherwise = (y:(mergeaux (x:xs) ys))

--vamo :: Int -> [Int]
--vamo n = take (div n 2) [1,2,3,5]
msort :: [Int] -> [Int]
msort [] = []
msort [n] = [n]
msort l = merge (msort x) (msort y)
	where (x,y) = splitAt (div (length l) 2) l
----------------------------------
--qsort :: [Int] -> [Int]
--qsort [b] = [b]



--qsort (w:ws) = qsort (qsort_aux xs x)++[w]++(qsort_aux ys y) 
--	where (x:xs,y:ys) = splitAt (div (length (w:ws)) 2) (w:ws)
qsort :: [Int] -> [Int]
qsort [] = []
qsort [n] = [n]
qsort (x:xs) = qsort(qsort_auxesq xs x) ++ [x] ++ qsort(qsort_auxdre xs x) 

qsort_auxesq :: [Int] -> Int -> [Int]
qsort_auxesq [] x = []
qsort_auxesq (x:xs)  n
	|x <= n = x:qsort_auxesq xs n
	|otherwise = qsort_auxesq xs n
	
qsort_auxdre :: [Int] -> Int -> [Int]
qsort_auxdre [] x = []
qsort_auxdre (x:xs)  n
	|x > n = x:qsort_auxdre xs n
	|otherwise = qsort_auxdre xs n

genQsort :: Ord a => [a] -> [a]
genQsort [] = []
genQsort (x:xs) = genQsort (filter (<= x) xs) ++ [x] ++ genQsort (filter (> x) xs)


	

