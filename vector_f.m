
%This function recives the handle function f and returns the scalar field
%\int f\phi_i

function [ff]=vector_f(f,n_v,n_t,elem_vertices, vertex_coordinates);

ff = zeros(n_v, 1);
ff = double(ff);



for el = 1 : n_t
    v_elem = elem_vertices( el, : );
    v1 = vertex_coordinates( v_elem(1), :)' ; 
    v2 = vertex_coordinates( v_elem(2), :)' ;
    v3 = vertex_coordinates( v_elem(3), :)' ;
    bary_el=((v1+v2+v3)/3)';
    matriz= [v2-v1 v3-v1];
    
 
    %local step
    ff_el =f(bary_el(1), bary_el(2))*1/6*abs(det(matriz)); 
    ff_el = double(ff_el);
    %Accumulation of the local steps
    ff( v_elem ) = ff( v_elem ) + ff_el;
end
end