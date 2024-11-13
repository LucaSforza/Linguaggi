(* datatype per costruire algebre induttive *)

(* sistema per aumentare il sistema dei tipi *)

(*type MyType = int*int;

fn x: MyType => 77;

datatype MyInt = zero | succ of MyInt;

val uno = succ zero;
val due = succ uno;
val tre = succ due;

fun plus zero m = m 
  | plus (succ n) m = succ (plus n m);

fun times zero m = zero | 
  times (succ n) m = plus (times n m) m;

fun Eval zero = 0 |
    Eval (succ n) = (Eval n) + 1;*)

(* TODO: vedersi gli abs type *)

(* Interprete per Exp *)

(* creiamo eval: Exp -> int *)


datatype 'a List = empty | cons of 'a* 'a List;

type Env = (string*int) List;

datatype Exp = K of int | Plus of Exp*Exp | Var of string 
    | Let of string*Exp*Exp;

fun eval (K n) = n |
    eval (Var s) = 5 |
    eval (Plus (n, m)) = (eval n) + (eval m) |
    eval (Let (s, n, m)) = 7;

eval (Plus ((Var "x"),K 9));

(*TODO: completare*)
