(*Lezione sui numeri di church*)

val eval = (fn x => x (fn n => n + 1) 0);
val zero = (fn f => fn x => x);
val tre = (fn f => fn x => f (f (f x)));
val quart = (fn f => fn x => f (f (f (f x))));

val succ = (fn z =>
    (fn f => fn x => f ((z f) x)));

eval tre;
eval (succ tre);
eval (succ (succ tre));
eval (succ (succ zero));

val plus = (fn u => fn v => (
    fn f => fn x => u f ( v f x)) (*soluzione del prof*)
);
val somma = (fn z => fn w => (fn f => fn x => w f (z f x))
    (*(fn f => fn x => w (z f) x)*));
eval (per tre quart);

val times = (fn u => fn v =>
    v (fn z => rty z u) zero); (* modo brutto di farlo*)

(* adesso creiamo times senza plus*)
val times = (fn u => fn v => (
    fn x => fn y => u (v x) y (* la funzione che fa v volte x e se la ripeti u volte partendo da y ottieni la moltiplicazione*)
));

(* esercizio fare times usando plus*)
val times = (fn u => fn v =>  u (plus v) zero);

eval (times tre quart);