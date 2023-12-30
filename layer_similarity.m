function [S] = layer_similarity(A, L)
    n = size(A,1);
    S = zeros(n,n);
    for i=1:n
        for j=i+1:n
                s1 = sum(A(:,i) & A(:,j));
                s2 = sum(A(:,i) | A(:,j));
                if s2 ~= 0
                    S(i,j) = (L(i) + L(j) ) * (s1/s2);
                    S(j,i) = S(i,j);
                end

        end
    end

end
