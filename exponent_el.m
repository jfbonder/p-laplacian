%This function recives the exponent p as a handle function
% and returns a vector pp that gives a constant exponent for each
%triangle. This is done by computing the value of p at the 
%barycenter of each triangle

function [pp]=exponent_el(p,n_t, elem_vertices, vertex_coordinates)
pp = zeros(n_t,1);
for el = 1 : n_t
    v_elem = elem_vertices( el, : );%esto  los tres nodos
    coord1=vertex_coordinates(v_elem(1), :);
    coord2=vertex_coordinates(v_elem(2), :);
    coord3=vertex_coordinates(v_elem(3), :);
    bary_el=(coord1+coord2+coord3)/3;
    pp(el)= p(bary_el(1),bary_el(2));
end
end