
module Circular where

twos :: [Integer]
twos = 2:twos

rep :: t -> [t]
rep e = e:(rep e)

fibs :: [Integer]
fibs = 0:1:(zipWith (+) fibs (tail fibs))

count :: [Integer]
count = 1:(map (+1) count)

powsOf2 :: [Integer]
powsOf2 = 2:(map (*2) powsOf2)

oneList :: [[Integer]]
oneList = [1]:(map (1:) oneList)

primes :: [Integer]
primes = sieve [2..] where 
  sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]

