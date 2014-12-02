load 35data.mat
data_size = 30000;

train_set_x = data_x(1:data_size,:);   
train_set_y = data_y(1:data_size,:);     
filename_x = ['train_set_x_' num2str(data_size) '.csv']
filename_y = ['train_set_y_' num2str(data_size) '.csv']
csvwrite(filename_x, train_set_x);
csvwrite(filename_y, train_set_y);



clear;
load 35data.mat
data_size = 30000;

valid_set_x = data_x(data_size+1:data_size*2,:); 
valid_set_y = data_y(data_size+1:data_size*2,:);
filename_x = ['valid_set_x_' num2str(data_size) '.csv']
filename_y = ['valid_set_y_' num2str(data_size) '.csv']
csvwrite(filename_x, valid_set_x);
csvwrite(filename_y, valid_set_y);

clear;
load 35data.mat
data_size = 30000;

test_set_x = data_x(2*data_size+1:data_size*3,:); 
test_set_y = data_y(2*data_size+1:data_size*3,:);
filename_x = ['test_set_x_' num2str(data_size) '.csv']
filename_y = ['test_set_y_' num2str(data_size) '.csv']
csvwrite(filename_x, test_set_x);
csvwrite(filename_y, test_set_y);



%train_x = data_x(1:data_size,:);   
%test_x = data_x(data_size+1:data_size*2,:); 

%train_y = data_y(1:data_size,:);     
%test_y = data_y(data_size+1:data_size*2,:);

%libsvmwrite(['train_' num2str(data_size)], train_y, sparse(train_x));
%libsvmwrite(['test_' num2str(data_size)], test_y, sparse(test_x));

