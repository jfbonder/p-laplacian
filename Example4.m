%This is Example 4 of the article. 
%This problem is called the p-torsion Problem.
%The equation is -\Delta_{p(x,y)} u = 1
%The exponent is p(x,y) = contant
%The boundary data is g(x,y) = 0.
%In this problem, for a rectangular domain,
%an exact solutions is not avaiable. 

clear all
close all

%We solve in the square [-1,1]x[-1,1]
a=-1;
b=1;

c=-1;
d=1;

%we partition the square into nxm
n=50;
m=50;

%Define the handle right-hand-side
f=@(x,y)1;


%Define the handle exponent, in this case p(x,y) is constant
p=@(x,y)4;

%Define the handle boundary data
g= @(x,y)0;

%Compute the triangulation data of the domain
gen_mesh_rectangle(n,m,a,b,c,d);
load elem_vertices.txt
load vertex_coordinates.txt
load dirichlet.txt


%Invoke the solver
[u, relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);

%%

%This step is done to plot the solution

figure;
trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u);
title('Computed solution');



%%

%This is a cycle that computes the solution to the p-torsion problem for 
%different values of p between 1.2 and 2

for exps= 1.2:0.2:2;
    
    p=@(x,y)exps;
    [u,relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);
    
    %grafico
    
    figure;
    trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u);
    title(['Computed solution con p= ',num2str(exps)]);
    axis([-1 1 -1 1 0 0.3])
    pause(2)
    
    
end

%%

%Same cycle but for exponents between p=2 and 10.
for exps= 2:2:10;
    p=@(x,y)exps;
    [u,relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);
    
    
    %grafico
    
    figure;
    trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u);
    title(['Computed solution con p= ',num2str(exps)]);
    axis([-1 1 -1 1 0 1])
    pause(2)
    
    
end

%%
%Again, same cycle but for exponents between p=10 and 100.
for exps= 10:10:100;
    p=@(x,y)exps;
    [u,relative_error]=solver(f,g,p,dirichlet,vertex_coordinates,elem_vertices);
    
    %grafico
    
    figure;
    trimesh(elem_vertices,vertex_coordinates (:,1),vertex_coordinates (:,2),u);
    title(['Computed solution con p= ',num2str(exps)]);
    axis([-1 1 -1 1 0 1])
    pause(2)
    
end