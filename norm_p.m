%This function computes the p-norm of a matrix A
%It is used to compute the error between some exact solutions
%and the computed solution in some experiments.

function normp = norm_p(A,exp);
absA=abs(A);
suma=sum(sum(absA.^exp));
normaux=((suma)^(1/exp));
normapfro=normaux;
end