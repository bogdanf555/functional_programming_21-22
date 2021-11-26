# Answers for Lab9

## Question 9.1.1

What is the bottom type in Elm? **Never**

## Question 9.1.2

How would you define exceptions? What languages that you know have exceptions?
When should you use exceptions?

**Response:** Exceptions are a concept that help signalize the presence of unwanted/erroneous behavior in your code.
Language that I know with exception support: Java, C++, Python, JavaScript;
You can define new custom exception to signalize the unwanted behavior of the concept that you implement
in your class.

## Exercise 9.4.1

What will be printed by the **:sprint l** after running the following commands:

**Response:**
```haskell
Prelude> l = [1,3..] :: [Int]
Prelude> take 3 (filter (\x -> mod (x - 1) 2 == 0) l)  
[1,3,5]
```

## Exercise 9.4.2

What will be printed by the **:sprint l** after running the following commands:

```haskell
Prelude> l = [1,10..] :: [Int]
Prelude> take 3 (filter (\x -> mod x 10 == 0) l)
[10,100,190]
```

## Exercise 9.5.1

For each function above, try to predict its output and then run it to see if you were
correct.

```haskell
-- twos generates an infinite list of 2 (element)
*Circular> take 5 twos
[2,2,2,2,2]
-- rep does the same thing but by appending an element passed as parameter
*Circular> take 5 (rep 2)
[2,2,2,2,2]
-- fibs generates the fibonacii numbers but starting with zero
*Circular> take 5 (fibs) 
[0,1,1,2,3]
-- count generates a list of counting numbers starting with 1
*Circular> take 5 (count)
[1,2,3,4,5]
-- powsOf2 generate the powers of two starting from 2
*Circular> take 5 (powsOf2)
[2,4,8,16,32]
--oneList generates a list of lists (first list having one 1, second list having two 1's and so on)
*Circular> take 5 (oneList)
[[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]
-- primes generates a list of prime numbers starting from two
*Circular> take 5 (primes) 
[2,3,5,7,11]
```

## Exercise 9.5.2

Trace the **fibs , powsOf2 and primes** functions for the first 3 elements.

**Response:** 
```haskell
-- fibs
1. 0:1:(zipWith (+) fibs (tail fibs))
2. 0:1:(zipWith (+) 0:1:(zipWith (+) fibs (tail fibs)) (tail 0:1:(zipWith (+) fibs (tail fibs))))
3. 0:1:(zipWith (+) 0:1:(zipWith (+) 0:1:(zipWith (+) fibs (tail fibs)) (tail 0:1:(zipWith (+) fibs (tail fibs)))) (tail 0:1:(zipWith (+) 0:1:(zipWith (+) fibs (tail fibs)) (tail 0:1:(zipWith (+) fibs (tail fibs))))))
Result: [0,1,1,2,3]
-- for powsOf2
1. 2:(map (*2) powsOf2)
2. 2:(map (*2) (2:(map (*2) powsOf2)))
3. 2:(map (*2) (2:(map (*2) 2:2)))
Result: 2,4,8
--primes
1.sieve [2] where 
  sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]
2.sieve [2,3] where 
  sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]
3.sieve [2,3,4] where 
  sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]
Result: [2,3]
```

## Question 9.7.1
Of the following functions, which are guaranteed to always terminate, even on infinite
lists?
1. sort
2. take
3. min (find the minimum value)
4. elem (check if a value is in the list)
5. head
6. filter

**Response:** take, elem and head

## Exercise 9.8.1
Write a function called cycl :: [a] -> [a] that takes list as parameter and repeats the
list infinitely.

```haskell
cycl :: [a] -> [a]
cycl l = l++(cycl l)
```

## Exercise 9.8.2

Write a function called series :: [[Int]] that generates the following list:
[[1], [2, 1], [3, 2, 1], ...]

```haskell
series :: [[Integer]]
series = [[1]] ++ (map (\x -> (1 + head x):x) series)
```