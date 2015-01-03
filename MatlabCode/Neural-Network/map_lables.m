function new_labels = map_labels(labels)
[row,col] = size(labels);
new_labels = zeros(row,10);
for i=1:row
    n = labels(i,1);
    new_labels(i,n+1) = 1;
end
end
