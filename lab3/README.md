# Answers to questions in the lab document

## Question 3.1.1

What Java concept is the equivalent to type variables? What about C++?

### In Java - generics. In C++ - templates.

## Question 3.1.2

Can we constrain type variables in Java or C++? If yes how?

We can surely do that by means of polymorphism. We just have to implement in different ways an interfaces 
in different classes.

###

## Question 3.2.1

How is equality handled for float types? Try to evaluate in the REPL: (0/0) and then
(0/0) == (0/0) . Does this cause a problem for reference equality?

### (0/0) returns NaN and (0/0) == (0/0) returns false because Elm uses structural equality.
### I searched in Elm core documentation and found out that elm uses IEEE 754 standard for float computations.
### Then I researched on IEEE 754 wiki page and found out how Nan works and why (0/0) == (0/0) returns false.
### It turns out that NaN retains some debug information which is unique for each NaN in it's bits so two 
### different NaN values compared will return that they are not equal.

## Question 3.3.1

What is known as the “billion dollar mistake” in Computer Science?

### The invention of null references by Tony Hoare.

## Question 3.3.2

Can we know at compile time if any given pointer is null or not in C?
Are C++ references different?

### We can't. Otherwise we would not check if dinamical memory allocation succeded after being performed on a pointer. Only hardcoded pointers can be check for being or not null at compile time.

## Question 3.3.3

Do you know any language that has the solution to the nullability problem built-in as
language feature?

### Optional in Java Streams.

## Question 3.3.4

Discuss at least 2 advantages and disadvantages of each approach. In which cases would
you use one over the other?

The string error handling approach is useful when you don't want to handle the error any further,
but only to saved/display it somewhere where a real person can see and interpret it.

The Enum style error handling is better when you want to identify which error has risen in a shorter
and easier way that string handling.

## Exercise 3.4.1
Write a function len that returns that length of a list (i.e., the number of elements in
it).
```elm
len list = 
  let
    lenHelper list count = 
      case list of
        [] -> count
        x::xs -> lenHelper xs (count + 1)
    in lenHelper list 0
```

## Question 3.4.1

What is the time complexity of the following operations on a singly linked list:
1. Insert at the list beginning (head)
2. Insert at the list end (tail)
3. Get the ith element

### Response: 1 - constant; 2 - linear; 3 - linear;

## Exercise 3.4.2

Find two values for b , b1 and b2 such that b2 = b1 + 1 and countFromTo 1 b overflows for
b2, but it doesn’t for b1.

### Response: works for 4437 but not for 4438

## Question 3.4.2

What is the algorithmic complexity of the appendTail function?

### Response: It is linear.

# 3.5 Practice Problems

## Exercise 3.5.1

Write a function with the signature safeDiv : Int -> Int -> Maybe Int that returns
Nothing when we try to divide by 0 and the result wrapped in Just otherwise.

```elm
safeDiv : Int -> Int -> Maybe Int
safeDiv first second = 
  case second of
    0 -> Nothing
    _ -> Just (first // second)
```

## Exercise 3.5.2

Rewrite the len function defined above in a tail-recursive style, with the name lenTail.

My implemetation is already tail recursive.
```elm
len : List a -> Int
len list = 
  let
    lenHelper list1 count = 
      case list1 of
        [] -> count
        x::xs -> lenHelper xs (count + 1)
    in lenHelper list 0
```

## Exercise 3.5.3

Implement a function last that returns the last element of a list.

```elm
last : List a -> Maybe a
last l = 
  case l of
    [] -> Nothing
    x::[] -> Just x
    x::xs -> last xs
```

## Exercise 3.5.4

Write a function indexList i l which returns the i th element of the list l .

```elm
tail l = 
    case l of
      [] -> []
      x::xs -> xs

indexList : Int -> List a -> Maybe a
indexList i l = 
  let
    indexListHelper : Int -> List a -> Int -> Maybe a
    indexListHelper ii ll current = 
      if current == ii then
        List.head ll
      else
        indexListHelper ii (tail ll) (current + 1)
  in indexListHelper i l 0
```

## Exercise 3.5.5

Write a function fibs start end , which takes a two numbers, start and end and returns
a list of the Fibonacci numbers such that:
    **fibs(start, end) = {fib(i)|i ∈ N, start ≤ i < end}**

```elm
fibs : Int -> Int -> List Int
fibs start end =
    let
      reverse l = 
        let
          reverseHelper ll aux = 
            case ll of
              [] -> aux
              x::xs -> reverseHelper xs (x::aux)
        in reverseHelper l []
      fibo n1 n2 first second index l = 
        if index >= n2 then
          l 
        else if index >= n1 then 
          fibo n1 n2 second (first + second) (index + 1) (second::l)
        else
          fibo n1 n2 second (first + second) (index + 1) l
    in reverse (fibo start end 0 1 0 [])
```

## Exercise 3.5.6

Modify the fibs function to return a list of tuples, where the first element in each tuple
denotes the index of the Fibonacci number and the second the Fibonacci number itself.

```elm
fibs : Int -> Int -> List (Int, Int)
fibs start end =
    let
      reverse l = 
        let
          reverseHelper ll aux = 
            case ll of
              [] -> aux
              x::xs -> reverseHelper xs (x::aux)
        in reverseHelper l []
      fibo n1 n2 first second index l = 
        if index >= n2 then
          l 
        else if index >= n1 then 
          fibo n1 n2 second (first + second) (index + 1) ((index, second)::l)
        else
          fibo n1 n2 second (first + second) (index + 1) l
    in reverse (fibo start end 0 1 0 [])
```

## Exercise 3.5.7 and 3.5.8

You can find the solutions in Lab3.elm staring with **line 76**. Please note that you have to import
both **Shape** and **Lab3** in the **elm repl** in order for the code to work properly.