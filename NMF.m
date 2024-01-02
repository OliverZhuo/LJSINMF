function [U] = NMF(A, k, maxiter)

[n, m] = size(A);

U = rand(n, k);

for i = 1:maxiter

    U = U .* ( A * U) ./ max(U * (U' * U) , 1e-10);

end


