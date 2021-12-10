# Answers to questions in lab10 

## Question 10.8.1 *
What is the kind of the following types:
* data Stuff = Stuff : *
* data Option a = None | Some a : *->*
* data Result err ok = Err err | Ok ok : *->*->*
* data Tree a = Nil | Node (Tree a) a (Tree a) : *->*
* data Map k v = Map [(k, v)] : *->*->*

## Question 10.8.2
Does Elm have semigroups or monoids? If yes what are they called?

## Exercise 10.9.1
Given the following data definition: data Op = Add | Sub | Mul | Div , implement Show
such that the corresponding mathematical operator is shown for each instance (i.e. + for
Add , − for Sub , etc).

```haskell
data Op = Add | Sub | Mul | Div

instance Show Op where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"
```

## Exercise 10.9.2
Implement the YesNo type class for the Maybe type.

```haskell
class YesNo a where
    yesno :: a -> Bool

instance YesNo Maybe where
    yesno (Just _) = False
    yesno _ = True
```

## Exercise 10.9.3 
Implement the Container type class for a binary tree data type, which is defined as:
data Tree a = Nil | Node (Tree a) a (Tree a) .

```haskell
data Tree a = Nil | Node (Tree a) a (Tree a)

class Container c where
  hasElem :: (Eq a) => c a -> a -> Bool
  nrElems :: c a -> Int

instance Container Tree where
  hasElem Nil e = False
  hasElem (Node z y x) e = e == y || hasElem z e || hasElem x e
  
  nrElems Nil = 0
  nrElems (Node z y x) = 1 + nrElems z + nrElems x
```