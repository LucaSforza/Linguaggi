val funz = (fn x => fn y => y x);

funz 2 (fn z => z + 1);
funz 37 (fn x => x);
funz (fn x => x + 1) (fn x => x) 3;