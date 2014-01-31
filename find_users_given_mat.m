function [newX] = find_users_given_mat(ids,X)
%%%Specific
%the first column of X should be users id and ids should be  single row
%of the ids you want to find. It returns the
%rows corresponding to those users
ans = [];
count = 1;
for n = 1:size(ids)(2)
    ind = find(X(:,1) == ids(:,n));
    if ind > 0
      ans(count, :) = X(ind,:);
      count = count + 1;
    end 
end
newX = ans;