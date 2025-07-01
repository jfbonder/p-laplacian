%This function recives the triangulation data and computes the area 
%of every element returning a vector of n_tx1

function [area_el]=area(n_t,elem_vertices, vertex_coordinates);
area_el=zeros(n_t,1);
for el=1:n_t
    v_elem = elem_vertices( el, : );
    v1 = vertex_coordinates( v_elem(1), :); % es fila
    v2 = vertex_coordinates( v_elem(2), :);
    v3 = vertex_coordinates( v_elem(3), :);
    matriz= [v2-v1 ; v3-v1];
    area_el(el)=0.5*abs(det(matriz));
end
end