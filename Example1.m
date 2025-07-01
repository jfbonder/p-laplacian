%This is Example 1 of the article
%We are solving -\Delta_{p(x,y)} u = 0
%The exponent is p = 20 (constant)
%The boundary data is g(x,y) = (x^2 + y^2)^((p(x,y)-2)/(2*p(x,y)-2));(which is
%an exact solution to the equation in this case).

clear all
close all

%We solve in the square [0,1]x[0,1]
a=0;
b=1;

c=0;
d=1;


%we partition the square into nxm
n=50;
m=50;

%Define the handle right-hand-side
f=@(x,y)0;

%Define the handle exponent
p=@(x,y)20;


%Define the handle boundary data
g= @(x,y)(x.^2 + y.^2).^((p(x,y)-2)/(2*p(x,y)-2));

%Compute the triangulation data of the domain
gen_mesh_rectangle(n,m,a,b,c,d);
load elem_vertices.txt
load vertex_coordinates.txt
load dirichlet.txt

%Invoke the solver
[u,relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);

%%

%This step is done to plot the solution

figure;
trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u);
title('Computed solution');
%%

%We plot the exact solution

vertex=size(vertex_coordinates);
n_v=vertex(1);%vertices

u_exact=zeros(n_v,1);
for k=1:n_v
    coord=vertex_coordinates(k,:);
    u_exact(k) = g(coord(1),coord(2));
end

figure;
trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u_exact);
title('Exact solution');

%% 
%Normas 
%norma L inf

norma_inf=max(max(abs(u- u_exact)))