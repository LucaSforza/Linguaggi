(*dobbiamo testare se SML è eager oppure lazy
per quanto riguarda il let eager oppure lazy è equivalente*)

(*però possiamo provare a scrivere un programma che non termina
lo possiamo fare ricorsivamente, ma come definiamo in SML
funzioni ricorsive?*)

val due = fn x => fn y => x (x y);
val eval = fn x (*numero di church*) =>
    x (fn z => z + 1) 0;

eval due;

(*supponiamo di avere un programma che non termina
e lo metto nel let se è lazy termina, se non è lazy
non termina*)

val succ = (fn x => x + 1);
(*un altro modo per fare la stessa cosa*)
fun succ x = x + 1;
fun fatt 0 = 1
    | fatt n = n*fatt (n-1)
(*con fun posso fare la ricorsione*)

fun boh x = boh x;
(*let val x = boh 7 in 9 end;*) (*questo programma se fosse
lazy non andrebbe in loop*)
(*va in loop perché è eager*)

let val x = 3 in
    let val y = (fn z => x) in
        let val x = 7 in y 42 end 
    end 
end;
(*questa espressione da come risultato 3 che quindi 
dimostra che SML è statico*)

(*datatype BoolList = empty
    | cons of bool * BoolList;
(*ha due costruttori, empty e cons*)

cons (false, cons (true, empty));*)

(*fun push

fun pop

fun allTrue empty = false
    | allTrue x = TODO: completare*)

(*nel linguaggio fun come scopriamo se è eager oppure
lazy?*)
(*scriviamo il programma omega*)

(*(fn x => (x x)) (fn x => (x x)) 7; se
facessimo l'albero di derivazione di questo programma
sarebbe infinito, dunque questo termine si chiama'omega'*)
(fn x: ((int->int) -> int) => x (fn z: int => z));

(*booleani di church*)

val True  = (fn t => fn f => t);
val False = (fn t => fn f => f);


val Beval = (fn z (*booleano di church*) =>
    z true false);

val Not = (fn z (*booleano di church*) =>
    (fn t => fn f => z f t));

Beval True;
Beval (Not True);

val And = (fn z => fn w =>
    (z w False)); (*Soluzione di Stefano*)

Beval (And False False); (*false*)
Beval (And False True); (*false*)
Beval (And True False); (*false*)
Beval (And True True); (*true*)

val And = (fn z => fn w =>
    (z w False)); (*Soluzione di Stefano*)

val And = (fn z => fn w =>
    (fn t => fn f => z (w t f) f)); (*Soluzione di Ionut*)
Beval (And False False); (*false*)
Beval (And False True); (*false*)
Beval (And True False); (*false*)
Beval (And True True); (*true*)

val Or = (fn z => fn w => 
    (fn t => fn f => z t (w t f)));

Beval (Or False False); (*false*)
Beval (Or False True); (*false*)
Beval (Or True False); (*false*)
Beval (Or True True); (*true*)

fun succ x = x + 1;
fun c a = (Or False False) a (succ a);

c 5;
