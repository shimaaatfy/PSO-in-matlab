function fitval = fitness(X, Y, weight)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
data = X * diag(sqrt(weight));
M=size(data,1);
testnum = round(M/7);
begin = 1;
k = 17;
rmsAll = zeros(1,1);
for j = 1:1
    test = zeros(M,1);
    test(begin : begin+testnum-1) = 1;
    test = logical(test);
    begin = begin+testnum;
    train = ~test;
	train_data=data(train,:);
	train_label=Y(train,1);
	test_data=data(test,:);
	test_label=Y(test,1);
    
    KDT_sdss= createns(train_data,'NsMethod','kdtree', 'Distance','euclidean');
	[index_sdss,~]=knnsearch(KDT_sdss,test_data,'k',k,'distance','euclidean');
    
    spec_sdss = train_label(index_sdss);
    spec_sdss_average = mean(spec_sdss,2);
    z=abs(spec_sdss_average-test_label);
    rmsAll(j,:) = sqrt(sum(z.^2)/size(z,1));
end
    fitval = mean(rmsAll);
end