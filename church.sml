(* numeri di Church *)

val zero = fn f => fn x => x;
val uno = fn f => fn x => f x;
val due = fn f => fn x => f (f x);
val tre = fn f => fn x => f (f (f x));

(* dato un naturale, si ottiene il corrispondente numero
di Church applicando la seguente funzione di codifica *)

fun codifica 0 = (fn y => (fn x => x))
   | codifica n = (fn y => (fn x => (y (codifica (n-1) y x))));

(* la decodifica (dato un Church restituisce il naturale) e`: *)

fun eval f = f (fn x => x+1) 0;

eval (codifica 5);

(* successore *)

fun succ z = (fn x => fn y => x (z x y));

(* somma *)

fun somma n m f x = (n f (m f x));

(* predecessore alla Kleene, cioe` usando le coppie *)

fun Kpred z = (let val doublesucc = (fn (u,v) => (succ u, u)) in
		(let val (x,y) = (z doublesucc (zero, zero)) in y end) end);

(* predecessore senza coppie *)

fun pred z x y = z (fn g => fn h => h (g x)) (fn w => y) (fn w => w);

(* sottrazione *)

fun minus x y = y pred x;
eval (minus due uno);

(* ma...
eval (minus due due);
produce errore!!! *)

(* moltiplicazione *)

fun times1 m n = m (somma n) zero; (* oppure *)
fun times2 m n f = m (n f);

(* fattoriale - stessa idea del predecessore di Kleene *)

fun fact n = let val step = (fn (x,y) => (succ x, times2 (succ x) y)) in
	(let val (a,b) = (n step (zero, uno)) in b end) end;

(* elevamento a potenza *)

fun power1 m n = n (times1 m) uno; (* oppure *)
fun power2 m n f = n m f;

eval (times1 tre due);
eval (times2 tre due);
eval (power1 tre due);
eval (power2 tre due);

(* auto-elevamento a potenza *)

fun selfpow1 n = power1 n n;
eval (selfpow1 tre);


(* auto-elevamento a potenza usando power2:

fun selfpow2 n = power2 n n;

ATTENZIONE: questa definizione produce errore:

 Error: operator and operand don't agree [circularity]
  operator domain: 'Z -> 'Y -> 'X
  operand:         'Z
  in expression:
    (power2 n) n
*)

