%David Meichel, 18.02.2019

%program calculated quotient q and remainder r for two polynomials a and b
%modulo a prime p using the classic algorithm for polynomial division

%we devide a by b (def a >= deg b)
a = [1 1 1 0 1]; %polynomial coefficients ordered by descending power
b = [1 0 1];
%modulo p
p = 2;

main_division(a, b, p);


function[eta, r] = main_division(a, b, p)
    n = length(a);
    m = length(b);
    mu = get_inverse(b(1), p);
    r = a;
    for j = 1:n-m+1
        i = (n-m+1)-j+1;
        fprintf("Iteration %i\n", i-1);
        if(length(r) == m + i - 1)
            eta = r(1) * mu;
            eta = mod(eta, p);
            fprintf("eta: %i\n",eta);
            r = subtract(r, eta*([b zeros(1,i-1)]));
            r = remove_leading_zeros(r);
            r = mod(r, p);
            r
        else
            eta = 0;
            fprintf("eta: %i\n",eta);
            r
        end
    end
end
        
function result = remove_leading_zeros(w)
    index = find(w ~= 0, 1, 'first');
    result = w(index : end);
end

%computes inverse of n mod p
function[inverse] = get_inverse(n, p)
   inverse = 0;
   for i = 0:p-1
       if(mod(i*n, p) == 1)
           inverse = i;
           return
       end
   end
end

%computes f - g
function result = subtract(f, g)
    f_order = length(f);
    g_order = length(g);
    if f_order > g_order
        max_order = size(f);
    else
         max_order = size(g);
    end
    new_f = padarray(f,max_order-size(f),0,'pre');
    new_g = padarray(g,max_order-size(g),0,'pre');
    result = new_f - new_g;
end