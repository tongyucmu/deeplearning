load data.mat
data_size = 200000;

train_set_x = data_x(1:data_size,:);   
train_set_y = data_y(1:data_size,:);     
filename = ['deep_train_' num2str(data_size) '.mat']
save(filename, 'train_set_x', 'train_set_y');

clear;
load data.mat
data_size = 200000;

valid_set_x = data_x(data_size+1:data_size*2,:); 
valid_set_y = data_y(data_size+1:data_size*2,:);
filename = ['deep_valid_' num2str(data_size) '.mat']
save(filename, 'valid_set_x', 'valid_set_y');

clear;
load data.mat
data_size = 200000;

test_set_x = data_x(2*data_size+1:data_size*3,:); 
test_set_y = data_y(2*data_size+1:data_size*3,:);
filename = ['deep_test_' num2str(data_size) '.mat']
save(filename, 'test_set_x', 'test_set_y');

%train_x = data_x(1:data_size,:);   
%test_x = data_x(data_size+1:data_size*2,:); 

%train_y = data_y(1:data_size,:);     
%test_y = data_y(data_size+1:data_size*2,:);

%libsvmwrite(['train_' num2str(data_size)], train_y, sparse(train_x));
%libsvmwrite(['test_' num2str(data_size)], test_y, sparse(test_x));

