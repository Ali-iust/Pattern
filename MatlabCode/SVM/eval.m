function e = eval(label,predict)
[row,col] = size(label);
e = 0;
for i=1:row
    if(label(i,1) ~= predict(i,1))
       e = e + 1; 
    end
end
e = e / row;
end
