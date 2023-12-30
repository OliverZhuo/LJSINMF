function [L] = onion_shell(A)


    L = zeros(1,size(A,1));
    B = A;
    d = 1;
    l = 1;

    while sum(B(:)) ~= 0

        C = sum(B,2);

        i = find(C<=d & C ~= 0);
        
        if ~isempty(i)
            B(i,:) = 0; 
            B(:,i) = 0;
            L(i) = l;
            l = l + 1;
            d = 1;
        else
            d = d + 1;
        end

    end