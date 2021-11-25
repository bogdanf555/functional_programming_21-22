
val name = "John";

datatype 'a tree = NIL | NODE of 'a tree * 'a * 'a tree;

[] = nil;

fun maybeGreet name =
  case name of
    SOME name => "Hello " ^ name
  | NONE => "Hello, stranger";

maybeGreet NONE;

fun isEven n =
  if n = 0 then 
    true
  else
    isOdd (n-1) and
isOdd n =
  if n = 0 then
    false
  else
    isEven (n-1);

maybeGreet (SOME name);

1+1;

val rec factRec = 
  fn 0 => 1 
  | n => n * factRec (n-1);

fun fact n =
  if n = 0 then
    1
  else
    n * (fact (n-1));

fact 12;

fun fib 0 = 0
  | fib 1 = 1
  | fib n = fib (n-1) + fib (n-2);

fun fibTail n =
  let
  	fun helper f1 f2 0 = f1
      | helper f1 f2 n = helper f2 (f1+f2) (n-1);
  in
  	helper 0 1 n
  end;

local
  fun helper f1 f2 0 = f1
    | helper f1 f2 n = helper f2 (f1 + f2) (n-1);
in
  fun fibTailLocal n = helper 0 1 n;
end;

fibTail 43;
fibTailLocal 43;

Int.maxInt;

fun countFromTo (lo: int) (hi: int) : int list = List.tabulate ((hi - lo + 1), fn x => x + lo);

countFromTo 1 10;
countFromTo 10 20;

fun contains elem l = List.exists (fn x => x = elem) l;

String.explode "Hello";

fun inc (x:int):int = x +1;
val inc': int -> int = fn x => x + 1;

fun double a = 
  let 
    val d = 2 * a 
  in
    d
  end;

1::2::3::[];

[1] @ [2];

(1, #"a");

fun cmp x y = x < y;

datatype user = user of string * string * int;

user;

