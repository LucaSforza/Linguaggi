val succ = (fn w => (
    fn x => fn y => w x (x y)
));

val succ = (fn w => (
    fn x => fn y => x ( w x y)
));

val eval = (fn x => x (fn y => y + 1) 0);
val zero = (fn x => fn y => y);
val tre = (fn x => fn y => x (x (x y)));
val quart = (fn x => fn y => x ( x (x (x y))));

eval tre;
eval (succ tre);
eval (succ (succ tre));
eval (succ (succ zero));

val plus = (fn u => fn v => (fn x => fn y => u x ( v x y)));

eval (plus tre quart);

val times = (fn u => fn v => v (fn z => plus z u) zero); (* modo brutto di farlo*)

(* adesso creiamo times senza plus*)
val times = (fn u => fn v => (
    fn x => fn y => u (v x) y (* la funzione che fa v volte x e se la ripeti u volte partendo da y ottieni la moltiplicazione*)
));

(* esercizio fare times usando plus*)
val times = (fn u => fn v =>  u (plus v) zero);

eval (times tre quart);