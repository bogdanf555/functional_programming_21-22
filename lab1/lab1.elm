{-
    QUESTIONS:

    1.3.1 Can you name a language which has a REPL? 
            --- Response: Python
    1.9.1 Consider the expression fact 5 - 1. What result do you expect to get? 
            --- Response: 119
    1.9.2 Find two values for b, b1 and b2 such that b2 = b1 + 1 and slowAdd overflows for b2, but it doesn’t for b1.
            --- Response: b1 = 4997, b2 = 4998
    1.9.3 Evaluate the following expressions in the REPL: (fib 40), (fib 45) and (fib 50). How long does each take?
            --- Response: fib 40 takes about 1 sec; fib 45 takes about 18 sec; fib 50 takes about 3 min 50 sec;
    1.9.4 Evaluate the following expressions in the REPL: (fibTail 50), (fibTail 100) and (fibTail 1000). How long does each take?
            --- Response: all fibTail calls take less than 1 sec; 
-}

-- exercise 1.10.1
gcd a b = if a == b then a else if a > b then gcd (a - b) b else gcd a (b - a)

gcd 60 12
gcd 70 12
gcd 70 25
gcd 70 50

-- exercise 1.10.2

ack n m = if n == 0 then m + 1 else if m == 0 then ack (n - 1) 1 else ack (n - 1) (ack n (m - 1))

ack 1 1
ack 2 3
ack 3 3
ack 4 1
ack 3 10

-- exercise 1.10.3

sudan n x y = if n == 0 then x + y else if n > 0 && y == 0 then x else sudan (n - 1) (sudan n x (y - 1)) (y + (sudan n x (y - 1)))

sudan 1 1 1
sudan 1 2 1
sudan 1 2 2
sudan 2 1 1
sudan 2 2 2