
use "utils.sml";

type Env = (string*int) List;

fun top empty = raise EmptyList "the list is empty" |
    top (cons (i,_)) = i;

(*TODO: mettere dentro la stringa il nome non trovato*) 
fun search empty needle = raise EmptyList "unbound variable" |
    search (cons ((i,content), haystack)) needle = 
        if i = needle then content
        else search haystack needle;

datatype Exp = K of int | Plus of Exp*Exp | Var of string 
    | Let of string*Exp*Exp;

fun eval env (K n) = n |
    eval env (Var s) = search env s | (* deve leggere dall'env e recuperare il valore, altrimenti dare errore*)
    eval env (Plus (n, m)) = (eval env n) + (eval env m) |
    eval env (Let (s, m, n)) =
        let
            val newEnv = cons ((s, eval env m), env);
        in
            eval newEnv n
        end; (* creare la variabile s, assegnargli m ed eseguire n *)

val myEnv: Env = empty;
eval myEnv (Let ("x",K 2,(Plus ((Var "x"),K 9))));
