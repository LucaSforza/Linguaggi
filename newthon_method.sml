fun rec_newthon_method (g: real) (x: real) (p: real) = 
    if Real.abs(g*g - x) >= p 
        then rec_newthon_method ((g + x/g)/2.0) x p 
    else g;

fun my_sqrt x:real = rec_newthon_method 1.0 x 0.000001;