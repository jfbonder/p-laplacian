%This functions recives a scalar field u and the data for the 
%triangulation and computes the vector field \nabla u that is constant
%in each triangle

function grad_u = gradient_u(u,n_t, elem_vertices, vertex_coordinates);
u=u(:);

grad_u=zeros(n_t,2);

for el = 1 : n_t
     v_elem = elem_vertices( el, : );
     G=[vertex_coordinates(v_elem(1),:) 1; vertex_coordinates(v_elem(2),:) 1; vertex_coordinates(v_elem(3),:) 1];               
     
     Dif=G\u(v_elem);
     
     grad_u(el,:)=[Dif(1) Dif(2)];                
end