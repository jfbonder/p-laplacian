%This function recives the triangulation data and computes the stiffness
%matrix.
function [AA]=stifness(elem_vertices, vertex_coordinates, area_el);

AA_el=zeros(3,3);
n_v=size(vertex_coordinates);
n_t=size(elem_vertices);
AA = sparse(n_v(1), n_v(1));


aux=[-1 1 0 ; -1 0 1];
 
 for el = 1 : n_t(1)
     v_elem = elem_vertices( el, : );

     v1 = vertex_coordinates( v_elem(1), :); 
     v2 = vertex_coordinates( v_elem(2), :);
     v3 = vertex_coordinates( v_elem(3), :);
     for i=1:3 %fila 
         for j=1:3 %col
     AA_el(i,j)=[inv([v2-v1 ; v3-v1])*aux(:,i)]'*[inv([v2-v1 ; v3-v1])*aux(:,j)]*area_el(el);
         end
     end
     
          AA( v_elem, v_elem ) = AA( v_elem, v_elem ) + AA_el; %matriz global (vamos sumando el aporte de cada elemento)
    
          %This is just to calm anxiety
          el
 end
 