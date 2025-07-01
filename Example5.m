%This is Example 5 of the article
%We are solving -\Delta_{p(x,y)} u = 1
%The exponent is p(x,y)is variable and discontinuous.
%it is taken to be 1.2 for x<=0 and 4 for x>0.
%This is the p(x,y)-torsion problem whith variable exponent.
%The boundary data is g(x,y) = 0. 
%Again, an exact solution is not available.

clear all
close all

%We solve in the square [-2,2]x[-1,1]
a=-2;
b=2;

c=-1;
d=1;

%we partition the square into nxm
n=50;
m=50;

%Define the handle right-hand-side
f=@(x,y)1;

%Define the handle exponent as a piecewise function
p=@(x,y)(x<=0).*(1.2)+(x>0).*4


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

%As expected, the solution is flat 
%in the region{x< =0} where the exponentis small (p(x,y)=1.2)
%and has a pyramid shape in the region {x>0} where 
%the exponent is large (p(x,y)=4)