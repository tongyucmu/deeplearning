load 35data.mat
data_size = 20000;
test_x = data_x(data_size+1:data_size*2,:); 
test_y = data_y(data_size+1:data_size*2,:);
libsvmwrite(['test_' num2str(data_size)], test_y, sparse(test_x));

clear
load 35data.mat
data_size = 20000;
train_x = data_x(1:data_size,:);   
train_y = data_y(1:data_size,:);     
libsvmwrite(['train_' num2str(data_size)], train_y, sparse(train_x));

