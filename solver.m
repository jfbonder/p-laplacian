%This is the main file. As an imput it recives the data of the
%triangulation, the exponent p as a handle function, the Dirichlet data g
%also as a handle function and finally the right-hand-size f as a handle
%function. It gives the computed solution u as a scalar field.

function [u,relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);
%The first step is to set up the matrices needed in the computations
tic
%Compute the number of vertices and of triangles
tam=size(elem_vertices);
n_t=tam(1); %triangles

vertex=size(vertex_coordinates);
n_v=vertex(1);%vertices


%Now we transform the handle function f into a vector field as 
%\int f\phi_i.
[ff]=vector_f(f, n_v,n_t, elem_vertices, vertex_coordinates);


%We transform the exponent handle function p into a vector pp that is 
%constant in each triangle
[pp]=exponent_el(p,n_t, elem_vertices, vertex_coordinates);



%Compute the area of each triangle
[area_el]=area(n_t,elem_vertices, vertex_coordinates);

%Compute the stiffness matrix A
[AA]=stifness(elem_vertices, vertex_coordinates, area_el);

%End of the preparation stage.
toc


tic
%Now we compute the iteration to find the solution u.

%First we inicialize the vector fields lambda and eta.
lambda = 0.15*rand(n_t,2);
eta = 0.15*rand(n_t,2);


%Inicialization of the solution u.
u = ones(n_v,1);
u_old = ones(n_v,1);


%Compute the divergence of eta-lambda
g_divergence=divergence(eta-lambda,area_el, n_v,n_t,elem_vertices,vertex_coordinates);
b = ff+g_divergence;


%Impose the Dirichlet data
for i = 1:length(dirichlet)
    diri = dirichlet(i);
    AA(diri,:) = zeros(1, n_v);
    AA(diri,diri) = 1;
    coordinates=vertex_coordinates(diri, :);
    b(diri)=g(coordinates(1),coordinates(2));
end

% Solve for u
u = ( AA\ b);


%Start of the iteration
%Keeping track of the number of iterations.
iterations = 1;
relative_error=zeros(1,199);
while (norm(u-u_old)/norm(u_old))> 1e-5 ;
    %&& iterations<200;
    iterations
    
    relative_error(iterations)=norm(u-u_old)/norm(u_old);
    
    u_old = u;
    grad_u = gradient_u(u,n_t,elem_vertices, vertex_coordinates);
    for i=1:n_t
        norm_eta = bisection(pp(i),norm(lambda(i,:)+grad_u(i,:)));
        eta(i,:) = (lambda(i,:)+grad_u(i,:))/(1+norm_eta^(pp(i)-2));
    end
    lambda = lambda + grad_u - eta;
    g_divergence=divergence(eta-lambda,area_el,n_v,n_t, elem_vertices,vertex_coordinates);
    b = ff+g_divergence;
    
    % Imponemos ahora las condicione=es de borde , ponemos dato de borde = sol
    for i = 1:length(dirichlet)
        diri = dirichlet(i);
        coordinates=vertex_coordinates(diri, :);
        b(diri)=g(coordinates(1),coordinates(2));
    end
    
    % Solve of u after updatin b:
    u = ( AA\ b);

    iterations = iterations + 1;
end

toc
end