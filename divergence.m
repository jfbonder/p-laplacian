 %This function recives a vector field g, the area of each triangle and 
 %the data of the triangulation. Then it computes the divergence of g as
 % \int g\nabla \phi
 %for each base element \phi returning a scalar field.

 function g_divergence=divergence(g,area_el,n_v,n_t, elem_vertices,vertex_coordinates);
 
 g_divergence=zeros(n_v, 1);
 
 aux=[-1 1 0 ; -1 0 1];
 
 for el = 1 : n_t
     v_elem = elem_vertices( el, : );
     v1 = vertex_coordinates( v_elem(1), :); 
     v2 = vertex_coordinates( v_elem(2), :);
     v3 = vertex_coordinates( v_elem(3), :);
     g_div_el=(g(el,:)*inv([v2-v1 ; v3-v1])*aux)*area_el(el);
     g_divergence( v_elem ) = g_divergence( v_elem ) + g_div_el';
 end
 end