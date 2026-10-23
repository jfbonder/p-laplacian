# p-laplacian

MATLAB code that solves the p(x)-Laplacian equation with Dirichlet boundary
conditions, using piecewise-linear (P1) finite elements.

The code accompanies the paper by A. Aragón, J. Fernández Bonder and D. Rubio,
*Effective numerical computation of p(x)-Laplace equations in 2D*
(see `aragon-bonder-rubio.pdf` in this repository).

## Python version

A vectorised Python port of this code is available in
[pxlaplace](https://github.com/jfbonder/pxlaplace).

## Usage

The scripts `Example1.m` to `Example5.m` reproduce the numerical examples.
The main solver is in `solver.m`.
