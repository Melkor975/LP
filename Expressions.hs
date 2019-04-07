data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

--Per exemple, Add (Val 3) (Div (Val 4) (Val 2)) representa 3 + 4 / 2, que s’avalua a 5.
--1. Avaluació sense errors (20 punts)

--Utilitzant el tipus Expr, definiu una operació eval1 :: Expr -> Int que, donada una expressió, en retorni la seva avaluació. Podeu suposar que mai hi haurà divisions per zero.
eval1 :: Expr -> Int
eval1 (Val a) = a
eval1 (Add e1 e2) = (eval1 e1) + (eval1 e2)
eval1 (Sub e1 e2) = (eval1 e1) - (eval1 e2)
eval1 (Mul e1 e2) = (eval1 e1) * (eval1 e2)
eval1 (Div e1 e2) = div (eval1 e1) (eval1 e2) 

--2. Avaluació amb indicació d’error (30 punts)

--Utilitzant el tipus Expr, definiu una operació eval2 :: Expr -> Maybe Int que, donada una expressió, en retorni la seva avaluació com un valor Just. En el cas que es produeixi una divisió per zero
--el resultat ha de ser Nothing. Segurament voleu usar la notació do sobre la mònada Maybe a.
eval2 :: Expr -> Maybe Int
eval2 (Val a) = Just a
eval2 (Add e1 e2) = do
	x <- (eval2 e1)
	y <- (eval2 e2)
	Just (x+y)
		
eval2 (Sub e1 e2) = do
	x <- (eval2 e1)
	y <- (eval2 e2)
	Just (x-y)
		
eval2 (Mul e1 e2) = do
	x <- (eval2 e1)
	y <- (eval2 e2)
	Just (x*y)
		
eval2 (Div e1 e2)=do
	x <- (eval2 e1)
	y <- (eval2 e2)
	if y == 0 then Nothing
	else Just(div x y)

--3. Avaluació amb text d’error (30 punts)

--Utilitzant el tipus Expr, definiu una operació eval3 :: Expr -> Either String Int que, donada una expressió, en retorni la seva avaluació com un valor Right.
-- En el cas que es produeixi una divisió per zero, el resultat ha de ser Left "div0"--per indicar l’error en qüestió. Segurament voleu usar la notació do sobre la mònada Either a b.

eval3 :: Expr -> Either String Int
eval3 (Val a) = do
	Right a
eval3 (Add e1 e2) = do
	x <- (eval3 e1)
	y <- (eval3 e2)
	Right (x+y)
eval3 (Sub e1 e2) = do
	x <- (eval3 e1)
	y <- (eval3 e2)
	Right (x-y)
eval3 (Mul e1 e2) = do
	x <- (eval3 e1)
	y <- (eval3 e2)
	Right (x*y)
eval3 (Div e1 e2) = do
	x <- (eval3 e1)
	y <- (eval3 e2)
	if y == 0 then Left "div0"
	else Right (div x y)
