function [Q] = Q_ov_GPT2(U, A, P, k)

    sum_U_row = sum(U, 2);
    sum_U_row_rep = repmat(sum_U_row, 1, k);
    U_norm = U ./ (sum_U_row_rep + eps);

    m = sum(sum(A))/2;
    Q = 0.0;

    %预先计算sum(A(i,:))和sum(A(j,:))
    sum_A_i = sum(A, 2);
    sum_A_j = sum(A, 1);

    for i=1:size(A,1)
        disp("%");
        disp(i/size(A,1));
        for j=1:i
            for c=1:size(P,2)
                %筛选出需要计算的n1和n2
                idx_n1 = find(P(:,c)~=1 & [1:size(A)]'~=i & [1:size(A)]'~=j);
                idx_n2 = find(P(:,c)~=1 & [1:size(A)]'~=i & [1:size(A)]'~=j);
                beta_out = sum(F(U_norm, i, idx_n1, c), 'all') / m;
                beta_in = sum(F(U_norm, idx_n2, j, c), 'all') / m;
    
                Q = Q + F(U_norm, i, j , c)*A(i,j) - beta_in*beta_out*sum_A_i(i)*sum_A_j(j) / m;
            end
        end
    end
    Q = Q / m;
end

function [Y] = F(U_norm, i, j , c)
    Y = (1 ./ (1 + exp(-60 .* U_norm(i,c) + 30))) .* (1 ./ (1 + exp(-60 .* U_norm(j,c) + 30)));
end
