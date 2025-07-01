%This is Example 2 of the article
%We are solving -\Delta_{p(x,y)} u = 1
%The exponent is p(x,y) is constant, p(x,y)=1.1
%The boundary data is g(x,y) = c_p*(1-(x^2 + y^2)^(p/(2*p-2)));
%where c_p=((p-1)/p)*2^(-1/(p-1))
%(which is a exact solution to the equation in this case).
%In this case, since c_p is a very small constant, it is better to use
%the homogeneity of the p-laplacian and solve
%-\Delta_p u = f
%with f=c_p^{-(p-1)}


clear all
close all

%We solve in the square [-sqrt(2)/2,sqrt(2)/2]x[-sqrt(2)/2,sqrt(2)/2]


a=-sqrt(2)/2;
b=sqrt(2)/2;

c=-sqrt(2)/2;
d=sqrt(2)/2;


%we partition the square into nxm
n=50;
m=50;

%Define the handle exponent
p=@(x,y)1.1;


%Define the handle right-hand-side
%f=@(x,y)c_p^{(p-1)};

f=@(x,y)2*((p(x,y)/(p(x,y)-1))^(p(x,y)-1));


%Define the handle boundary data
g=@(x,y)(1-(x.^2 + y.^2).^(p(x,y)/(2*p(x,y)-2)));

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
title('Computed solution');axis([-1 1 -1 1 0 1.2])


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
title('Exact solution');axis([-1 1 -1 1 0 1.2])


%% %Normas 
%norma L inf

norma_inf=max(max(abs(u- u_exact)))





