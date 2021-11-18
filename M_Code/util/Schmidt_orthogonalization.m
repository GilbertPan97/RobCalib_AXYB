function b = Schmidt_orthogonalization(a)

    [m,n] = size(a);
    if(m<n)
        error('Error! The row is smaller than the column and cannot be calculated. Please transpose and re-enter');
        return
    end
    
    b=zeros(m,n);
    
    % Orthogonalization
    b(:,1)=a(:,1);
    for i=2:n
        for j=1:i-1
            b(:,i)=b(:,i)-dot(a(:,i),b(:,j))/dot(b(:,j),b(:,j))*b(:,j);
        end
        b(:,i)=b(:,i)+a(:,i);
    end

    % Normalization
    for k=1:n
        b(:,k)=b(:,k)/norm(b(:,k));
    end
end