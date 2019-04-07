data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

--SI HI HA UNA LLISTA BUIDA NO ENTRA SI LA LLISTA DE LA FUNCIO ESTA DEFINIDA COM (a:as)

--Feu una funció size :: Tree a -> Int que, donat un arbre, retorni la seva talla, és a dir, el nombre de nodes que conté.
size :: Tree a -> Int
size Empty = 0 
size (Node pare fill1 fill2) = 1 + (size (fill1) + size (fill2))
--Feu una funció height :: Tree a -> Int que, donat un arbre, retorni la seva alçada, assumint que els arbres buits tenen alçada zero.
height :: Tree a -> Int
height Empty = 0
height (Node pare fill1 fill2) = 1 + max (height fill1) (height fill2)
--Feu una funció equal :: Eq a => Tree a -> Tree a -> Bool que, donat dos arbres, indiqui si són el mateix.
equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node p1 f11 f12) (Node p2 f21 f22) = (p1 == p2) && (equal f11 f21) && (equal f12 f22)
--Feu una funció isomorphic :: Eq a => Tree a -> Tree a -> Bool que, donat un arbres, indiqui si són el isomorfs, és a dir, si es pot obtenir l’un de l’altre tot girant algun dels seus fills.
isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic Empty _ = False
isomorphic _ Empty = False
isomorphic (Node p1 f11 f12) (Node p2 f21 f22) =  p1 == p2 && ((equal f11 f21) || (equal f11 f22)) && ((equal f12 f21) || (equal f12 f22))
--Feu una funció preOrder :: Tree a -> [a] que, donat un arbre, retorni el seu recorregut en pre-ordre.
preOrder :: Tree a -> [a] 
preOrder Empty = []
preOrder (Node p f1 f2) = [p] ++ ((preOrder f1) ++ (preOrder f2))
--Feu una funció postOrder :: Tree a -> [a] que, donat un arbre, retorni el seu recorregut en post-ordre.
postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node p f1 f2) =((postOrder f1) ++ (postOrder f2)) ++ [p]
--Feu una funció inOrder :: Tree a -> [a] que, donat un arbre, retorni el seu recorregut en in-ordre.
inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node p f1 f2) = inOrder f1 ++ [p] ++ inOrder f2
--Feu una funció breadthFirst :: Tree a -> [a] que, donat un arbre, retorni el seu recorregut per nivells.
breadthFirst :: Tree a -> [a]
breadthFirst Empty = []
breadthFirst a = agafa(creaLl [a])

creaLl :: [Tree a] -> [Tree a]
creaLl [] = []
creaLl [Empty] = []
creaLl (x:xs) =  [x] ++ creaLl xs2
	where xs2 = xs ++ (comprova f1) ++ (comprova f2)
		where (Node p f1 f2) = x

comprova :: Tree a -> [Tree a]
comprova Empty = []
comprova t = [t] 

agafa :: [Tree a] -> [a]
agafa [] = []
agafa [Empty] = []
agafa (x:xs) = [b] ++ agafa xs
	where (Node b f1 f2) = x

--Feu una funció build :: Eq a => [a] -> [a] -> Tree a que, donat el recorregut en pre-ordre d’un arbre i el recorregut en in-ordre del mateix arbre, retorni l’arbre original. Assumiu que l’arbre no té elements repetits.
--Feu una funció overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a que, donats dos arbres, retorni la seva superposició utilitzant una funció. Superposar dos arbres amb una funció consisteix en posar els dos arbres l’un damunt de l’altre i combinar els nodes doble resultants amb la funció donada o deixant els nodes simples tal qual.

--Implementeu cues genèriques utilitzant la definició de dades i les operacions següents:
data Queue a = Queue [a] [a]
    deriving (Show)
 
create :: Queue a
create = Queue [] []
 
push :: a -> Queue a -> Queue a
push x (Queue a b) = Queue a (x:b)

pop :: Queue a -> Queue a
pop (Queue [] []) = Queue [] []
pop (Queue [] y) = (Queue (tail x) [])
	where x = reverse y
pop (Queue (a:as) b) = (Queue as b)

top :: Queue a -> a
top (Queue [] b) = head $ reverse b
top (Queue a b) = head a

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty q = False

--Definiu la igualtat de cues de manera que dues cues siguin iguals si i només si tenen els mateixos elements en el mateix ordre de sortida. Per a fer- ho, indiqueu que les cues són una instàcia de la classe Eq on (==) és l’operació d’igualtat que heu de definir:
instance Eq a => Eq (Queue a) where
	(Queue [] []) == (Queue [] []) = True
	q1 == q2
		|(empty q1) || (empty q2) = False
		|otherwise = if (top q1) == (top q2)
				then ((pop q1) == (pop q2))
			    else False
 
