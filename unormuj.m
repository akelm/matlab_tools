function wektor=unormuj(input)
j=size(input,2);
wektor=zeros(size(input));
for i=1:j
    
%wywalenie tla
min1=min( input( find( input(:,i)~=(-Inf) ),i  ) );
input1=input(:,i) - min1*ones(size(input,1),1);
%unormowanie
max1=max(input1( find(input1~=Inf) ));
wektor(:,i)=input1/max1;
end
end