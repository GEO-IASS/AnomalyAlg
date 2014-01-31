function [newX] = rotatebynum(num,X)
%shift the matrix 'X' row wise  'num' times
newX = circshift(X, [0, (-1 * num)]);