--1
--Feu una funció eql :: [Int] -> [Int] -> Bool que indiqui si dues llistes d’enters són iguals.
eql :: [Int] -> [Int] -> Bool

eql l1 l2
	|length l1 /= length l2 = False
	|otherwise = all (==True) l
		where l = zipWith (==) l1 l2
--Feu una funció prod :: [Int] -> Int que calculi el producte dels elements d’una llista d’enters.
prod :: [Int] -> Int
prod l = foldl (*) 1 l --prod (x:xs) = foldl (*) x xs  I ADEMES HAURIEM DE TENIR EN COMPTE LA LLISTA D'UN ELEMENT O ALGO
--Feu una funció prodOfEvens :: [Int] -> Int que multiplica tots el nombres parells d’una llista d’enters.
prodOfEvens :: [Int] -> Int
prodOfEvens = prod . filter even --prodOfEvens l = (prod . filter even) l O SINO prodOfEvens l =  foldl (*) 1 (filter even l)
--Feu una funció powersOf2 :: [Int] que generi la llista de totes les potències de 2.
powersOf2 :: [Int]
powersOf2 = iterate (*2) 1
--Feu una funció scalarProduct :: [Float] -> [Float] -> Float que calculi el producte escalar de dues llistes de reals de la mateixa mida.
scalarProduct :: [Float] -> [Float] -> Float
scalarProduct l1 l2 = foldl (+) 0 (zipWith (*) l1 l2)
--2
--Feu una funció flatten :: [[Int]] -> [Int] que aplana una llista de llistes d’enters en una llista d’enters.
flatten :: [[Int]] -> [Int]
flatten ll = foldl (++) [] ll
--Feu una funció myLength :: String -> Int que retorna la llargada d’una cadena de caràcters.
myLength :: String -> Int
myLength [] = 0
myLength l = foldl (\x loquesea -> x+1) 0 l


--Feu una funció myReverse :: [Int] -> [Int] que inverteix els elements d’una llista d’enters.
myReverse :: [Int] -> [Int]
myReverse l = foldl (flip (:)) [] l
--Feu una funció countIn :: [[Int]] -> Int -> [Int] que, donada una llista de llistes d’elements ℓ i un element x ens torna la llista que indica quants cops apareix x en cada llista de ℓ.
countIn :: [[Int]] -> Int -> [Int] 
countIn ll x = map (length . (filter (== x))) ll
--Feu una funció firstWord :: String -> String que, donat un string amb blancs i caràcacters alfabètics), en retorna la primera paraula.
firstWord :: String -> String
firstWord s = (takeWhile (/= ' ') . dropWhile(== ' ') )s
--3
--Feu una funció myMap :: (a -> b) -> [a] -> [b] que emuli el map usant llistes per comprensió.
--myMap :: (a -> b) -> [a] -> [b]
--myMap f l = [f x | x <- l]
--Feu una funció myFilter :: (a -> Bool) -> [a] -> [a] que emuli el filter usant llistes per comprensió.
--myFilter :: (a -> Bool) -> [a] -> [a]
--myFilter p l = [x | x <- l, p x]
--Feu una funció myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c] que que emuli el zipWith usant llistes per comprensió i zip.
--myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
--myZipWith f l1 l2 = [f x y| (x,y) <- zip l1 l2]
--Feu una funció thingify :: [Int] -> [Int] -> [(Int, Int)] que, donades dues llistes d’enters, genera la llista que aparella els elements si l’element de la segona llista divideix al de la primera.
thingify :: [Int] -> [Int] -> [(Int, Int)]
thingify l1 l2 = [(x,y) | x <- l1, y <- l2, x `mod` y == 0]
--Feu una funció factors :: Int -> [Int] que, donat un natural no nul, genera la llista ordenada amb els seus factors (no necessàriament primers).
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]
--4
--myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f a [] = a
myFoldl f a (b:bs) = (myFoldl f (f a b) bs)
--myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f x [] = x
myFoldr f x (y:ys) = f y (myFoldr f x ys)
--myIterate :: (a -> a) -> a -> [a]
myIterate :: (a -> a) -> a -> [a]
myIterate f a = a:(myIterate f (f a))  
--myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil b f a
	|not (b a) = myUntil b f (f a)
	|otherwise = a
--myMap :: (a -> b) -> [a] -> [b]
myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f l = foldr (\x xs -> ((f x):xs)) [] l
--myFilter :: (a -> Bool) -> [a] -> [a] 
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f l = foldr (\x xs -> if (f x) then x:xs else xs) [] l
--myAll :: (a -> Bool) -> [a] -> Bool
myAll :: (a -> Bool) -> [a] -> Bool
myAll f l = and (map f l) -- foldl (&&) True (map f l) Aixi no es feia, ja que era menys eficient pero: DIFERENCIA ENTRE AND I &&-> && ES LA LLOGICA I AND RETORNA EL RESULTAT DE FER && A TOTS ELS ELEMENTS
--myAny :: (a -> Bool) -> [a] -> Bool
myAny :: (a -> Bool) -> [a] -> Bool
myAny f l = or (map f l)
--myZip :: [a] -> [b] -> [(a, b)]
myZip :: [a] -> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y): myZip xs ys 
--myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f l1 l2 = myFoldr (\x xs -> (f (fst x) (snd x)):xs) [] (zip l1 l2)  

--Feu una funció countIf :: (Int -> Bool) -> [Int] -> Int que, donat un predicat sobre els enters i una llista d’enters, retorna el nombre d’elements de la llista que satisfan el predicat.
--Nota: Aquesta funció d’ordre superior existeix en llenguatges de tractament de fulls de càlcul com ara EXCEL.
countIf :: (Int -> Bool) -> [Int] -> Int
countIf f l = length ( filter f l)
--Feu una funció pam :: [Int] -> [Int -> Int] -> [[Int]] que, donada una llista d’enters i una llista de funcions d’enters a enters, retorna la llista de llistes resultant d’aplicar cada una de les funcions de la segona llista als elements de la primera llista.
pam :: [Int] -> [Int -> Int] -> [[Int]]
pam l [] = []
pam l lf = [(map x l)|x <- lf]
--pam l (f:fs) = [(map f l)] ++ pam l fs

--Feu una funció pam2 :: [Int] -> [Int -> Int] -> [[Int]] que, donada una llista d’enters i una llista de funcions d’enters a enters, 
--retorna la llista de llistes on cada llista és el resultat d’aplicar successivament les funcions de la segona llista a cada element de la primera llista.
--Nota: Qualsevol semblança amb La parte contratante de la primera parte será considerada como la parte contratante de la primera parte és pura casualitat.
pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 [] _ = []
--pam2 (x:xs) l = [pam2aux x l] ++ pam2 xs l
pam2 l lf = [pam2aux x lf|x <- l]

pam2aux :: Int -> [(Int -> Int)] -> [Int]
pam2aux x [] = []
pam2aux x lf = [f x| f <- lf]
--Feu una funció filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int que fa el plegat dels elements que satisfan la propietat donada.
filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int 
filterFoldl p f x xs = foldl f x (filter p xs) 
--Feu una funció insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int] que donada una relació entre enters, una llista i un element, ens retorna la llista amb l’element inserit segons la relació.
insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] x = [x]
insert p (l:ls) x 
	|p x l = x:(l:ls)
	|otherwise = l:(insert p ls x)
--Utilitzant la funció insert, feu una funció insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int] que ordeni la llista per inserció segons la relació donada.
insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort p [] = []
insertionSort p l = foldl (insert p) [] l 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





--Generar la seqüència dels uns [1,1,1,1,1,1,1,1,…].
ones :: [Integer]
ones = repeat 1
--Generar la seqüència dels naturals [0,1,2,3,4,5,6,7…].
nats :: [Integer]
nats = iterate (+1) 0
--Generar la seqüència dels enters [0,1,−1,2,−2,3,−3,4…].
ints :: [Integer]
ints = iterate (integer) 0
	where 
		 integer :: Integer -> Integer
		 integer x
			|x > 0 = (-x)
			|otherwise = (-x) + 1
--Generar la seqüència dels nombres triangulars: 0,1,3,6,10,15,21,28,…].
triangulars :: [Integer]
triangulars = triangle 0
	where
		triangle :: Integer -> [Integer]
		triangle x = div (x*(x+1)) 2:(triangle (x+1))
--Generar la seqüència dels nombres factorials: [1,1,2,6,24,120,720,5040,…].
factorials :: [Integer]
factorials = facts 0
     where
          facts :: Integer -> [Integer]
          facts x = factorial x : facts (x + 1)
               where
                    factorial :: Integer -> Integer
                    factorial 0 = 1
                    factorial x = x * factorial (x - 1)

--Generar la seqüència dels nombres de Fibonacci: [0,1,1,2,3,5,8,13,…].
fibs :: [Integer]
fibs = fibonaccis 0 1
	where 
		fibonaccis :: Integer -> Integer -> [Integer]
		fibonaccis a b = a:(fibonaccis b (a+b))
--Generar la seqüència dels nombres primers: [2,3,5,7,11,13,17,19,…].
isPrimeRec :: Integer -> Integer -> Bool
isPrimeRec x d
    | d == 1 = True
    | mod x d == 0 = False
	| otherwise = isPrimeRec x (d - 1)

isPrime :: Integer -> Bool
isPrime x
    | x == 0 = False
    | x == 1 = False
    | otherwise = isPrimeRec x (floor (sqrt (fromIntegral x)))

primes :: [Integer]
primes  = primers 2
	where
		primers :: Integer -> [Integer]
		primers x
			|isPrime x = x:primers (x+1)
			|otherwise = primers (x+1)
	
--Generar la seqüència ordenada dels nombres de Hamming: [1,2,3,4,5,6,8,9,…]. Els nombres de Hamming són aquells que només tenen 2, 3 i 5 com a divisors primers.
isHamming :: Integer -> Bool
isHamming x
	|((mod x 2) == 0) || ((mod x 3) == 0) || ((mod x 5) == 0) = True
	|otherwise = False
hammings :: [Integer]
hammings = ham 1
	where 
		ham :: Integer -> [Integer]
		ham 1 = 1:(ham (2))
		ham x
			|isHamming x = x:(ham (x+1))
			|otherwise = (ham (x+1))
		
--Generar la seqüència mira i digues: [1,11,21,1211,111221,312211,13112221,1113213211,…].
--Generar la seqüència de les files del triangle de Tartaglia (també anomenat triangle de Pascal): [[1],[1,1],[1,2,1],[1,3,3,1],…]. 
