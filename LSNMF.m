A = csvread('Karate.csv', 1, 1);

[node_layer] = onion_shell(A);
[S] = layer_similarity(A, node_layer);
lambda = 0.1;
J = A + lambda*S;
J = scale01(J);
[U] = NMF(J, 3, 500);

disp(U);

function y = scale01(x)
  y = x - min(min(x)) + eps;
  y = y/max(max(y));
end
