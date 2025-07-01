%This function receives the exponent p and a right-hand-side z 
%and solves the equation y^(p-1)+y = z by the bisection method

function c = bisection(p,z)
if p==2
    c = 1;
else
    f = @(y) y^(p-1)+y-z;
    a = 0;
    b = z;
    if z >1e-10
        while (b-a)>1e-10
            c = (a+b)/2;
            if f(c) < 0
                a = c;
            elseif f(c)>0
                b = c;
            else
                break
            end
        end
    else
        c=0;
        
    end
    
end
end