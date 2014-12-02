d = dir('manual_seg/*');
data_x = [];
data_y = [];

size_pos_list = [];
size_neg_list = [];

%for i = 3:length(d)
for i = 3:1000
	i
    %disp(d(i).name)
    load(['manual_seg/' d(i).name]);
    data_x = [data_x; raw_x];
    data_y = [data_y; raw_y];
    
    size_pos_list = [ size_pos_list; size(find(raw_y > 1), 1)];
    size_neg_list = [ size_neg_list; size(find(raw_y == 0), 1)];
end


   

size(data_y, 1)
size(find(data_y > 0), 1)    
size(find(data_y == 0), 1)

