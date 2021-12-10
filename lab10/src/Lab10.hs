data Op = Add | Sub | Mul | Div

instance Show Op where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"

class YesNo a where
  yesno :: a -> Bool

instance YesNo (Maybe a) where
  yesno (Just _) = False
  yesno _ = True

data Tree a = Nil | Node (Tree a) a (Tree a)

class Container c where
  hasElem :: (Eq a) => c a -> a -> Bool
  nrElems :: c a -> Int

instance Container Tree where
  hasElem Nil e = False
  hasElem (Node z y x) e = e == y || hasElem z e || hasElem x e

  nrElems Nil = 0
  nrElems (Node z y x) = 1 + nrElems z + nrElems x