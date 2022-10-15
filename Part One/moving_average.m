function Y=moving_average(X,w);
% Y=moving_average(X,w)
% this m-file is a simplistic implementation of the running-average filter
% X is the input signal (it should be a row-vector )
% and w the window width (it should be odd !!!)


Y=X;  % initialization
[m,n]=size(X);

for i=1+(w-1)/2:n-(w-1)/2;
      X_windowed=[ X(i-(w-1)/2:i+(w-1)/2)];
     Y(i)=mean(X_windowed);  
end
