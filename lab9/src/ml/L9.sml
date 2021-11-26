
type 'a thunk = unit -> 'a;
datatype 'a seq = NIL | CONS of 'a * ('a seq) thunk;

fun headq CONS (a, _) = a;
fun tailq CONS (_, xs) = xs ();
fun consq x xs = CONS (x, fn () => xs);

fun takeq 0 _ = []
  | takeq n (CONS (x, xs)) =
    x :: takeq (n-1) (xs ());

fun countq start = CONS (start, fn () => (countq (start + 1)));

takeq 10 (countq 0);

