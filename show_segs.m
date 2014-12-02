%segs and images contain respectively the manual segmentations and the
%corresponding 4D image.
%max_intensity adjusts the displayed intensity values for better visualization. A value
%of 500 works fine for most sequences. 
%z_pos and time_pos contain respectively the long axis slice number and
%temporal frame number that we wish to visualize.
function show_segs(segs_name,images_name,max_intensity,z_pos,time_pos)

tmp = struct2cell(load(segs_name));
segs = tmp{1};
tmp = struct2cell(load(images_name));
images = tmp{1};

[s_zval s_tval] = size(segs);
[i_yval i_xval i_zval i_tval] = size(images);



if(s_zval ~= i_zval || s_tval~=i_tval)
    disp('error');
    return;
end;

picture = reshape(images(:,:,z_pos,time_pos),256,256);
imshow(picture,[0 max_intensity]);       

temp = segs{z_pos,time_pos};
[sx sy] = size(temp);

if(temp(1,1)~=-99999)
half=(sx-1)/2;

pointsXendo = [temp(1:half,1);temp(1,1)];
pointsYendo = [temp(1:half,2);temp(1,2)];
pointsXepi = [temp(half+2:2*half+1,1);temp(half+2,1)];
pointsYepi = [temp(half+2:2*half+1,2);temp(half+2,2)];


[stemp1 stemp2] = size(pointsXendo);
a1=linspace(0,1,stemp1);
sampling_data_endo=zeros(1000,2);
sampling_data_epi=zeros(1000,2);
b1 = linspace(0,1,1000);


% [pointsendo_int] = unique(floor([pointsXendo pointsYendo]), 'rows');
% [pointsepi_int] = unique(floor([pointsXepi pointsYepi]), 'rows');

sampling_data_endo(:,1) = interp1(a1,pointsXendo,b1,'spline')';
sampling_data_endo(:,2) = interp1(a1,pointsYendo,b1,'spline')';
sampling_data_epi(:,1) = interp1(a1,pointsXepi,b1,'spline')';
sampling_data_epi(:,2) = interp1(a1,pointsYepi,b1,'spline')';



[pointsendo_int] = unique(floor(sampling_data_endo), 'rows');
[pointsepi_int] = unique(floor(sampling_data_epi), 'rows');
% 
% 
% y_bottom = max(pointsendo_int(:,2));
% y_top = min(pointsendo_int(:,2));
% 
% region_x = [];
% region_y = [];
% 
% for i = y_top+1:y_bottom-1
%     x_right  = max(pointsendo_int(find(pointsendo_int(:,2) == i),1)) - 1;
%     x_left  = min(pointsendo_int(find(pointsendo_int(:,2) == i),1)) + 1;
%     region_x = [region_x x_left:x_right];
%     region_y = [region_y i*ones(1,x_right-x_left+1)];
% end

y_bottom_big = max(pointsepi_int(:,2));
y_top_big = min(pointsepi_int(:,2));

region_x_big = [];
region_y_big = [];

for i = y_top_big:y_bottom_big
    x_right  = max(pointsepi_int(find(pointsepi_int(:,2) == i),1));
    x_left  = min(pointsepi_int(find(pointsepi_int(:,2) == i),1));
    region_x_big = [region_x_big x_left:x_right];
    region_y_big = [region_y_big i*ones(1,x_right-x_left+1)];
end

window_size = 15;

num_inst = size(pointsepi_int,1);
raw_x_pos = zeros(num_inst,window_size^2);
raw_y_pos = zeros(num_inst,1);

count = 0;
for i = pointsepi_int'
    count = count + 1;
    start_ind = i - (window_size-1)/2;
    end_ind = i + (window_size-1)/2;
    raw_x_pos(count, :) = reshape(picture(start_ind(1):end_ind(1),start_ind(2):end_ind(2)),1,window_size^2);
    raw_y_pos(count) = 1;
    
end

negative_sample = randi([(window_size+1)/2 i_xval-(window_size+1)/2], 2, num_inst+30);
negative_sample_out = setdiff(negative_sample', [region_x_big' region_y_big'], 'rows');


raw_x_neg = zeros(num_inst,window_size^2);
raw_y_neg = zeros(num_inst,1);
count = 0;
for i = negative_sample_out'
    count = count + 1;
    start_ind = i - (window_size-1)/2;
    end_ind = i + (window_size-1)/2;
    raw_x_neg(count, :) = reshape(picture(start_ind(1):end_ind(1),start_ind(2):end_ind(2)),1,window_size^2);
    raw_y_neg(count) = 0;
    
end

raw_x = [raw_x_pos; raw_x_neg];
raw_y = [raw_y_pos; raw_y_neg];

name = [segs_name '_' num2str(z_pos) '_' num2str(time_pos) '.mat'];

save(name, 'raw_x', 'raw_y');


train_x = [raw_x_pos(1:100,:); raw_x_neg(1:100,:)];
train_y = [raw_y_pos(1:100,:); raw_y_neg(1:100,:)];
test_x = [raw_x_pos(101:end,:); raw_x_neg(101:end,:)];
test_y = [raw_y_pos(101:end,:); raw_y_neg(101:end,:)];


t1 = fitctree(train_x,train_y);
C1 = predict(t1,test_x);

    
accuracy = sum(C1 == test_y)/size(test_x,1)

% 
% region = [region_x' region_y'];
% region_big = [region_x_big' region_y_big'] 
% 
% region_ring = setdiff(region_big, region, 'rows');
% region_x_ring = region_ring(:,1);
% region_y_ring = region_ring(:,2);

dots = sampling_data_endo;
for a=1:999
    line([dots(a,1);dots(a+1,1)],[dots(a,2);dots(a+1,2)],'Color','r'); %endo
end;
line([dots(1000,1);dots(1,1)],[dots(1000,2);dots(1,2)],'Color','r'); %endo


dots = sampling_data_epi;
for a=1:999
    line([dots(a,1);dots(a+1,1)],[dots(a,2);dots(a+1,2)],'Color','g'); %epi
end;
line([dots(1000,1);dots(1,1)],[dots(1000,2);dots(1,2)],'Color','g'); %epi
end;
pause(0.25);

hold on
% scatter(region_x_big,region_y_big);
%scatter(region_x_ring,region_y_ring);
% scatter(region_x_big,region_y_big);
scatter(negative_sample_out(:,1),negative_sample_out(:,2));
hold on
scatter(pointsepi_int(:,1),pointsepi_int(:,2));
% scatter(pointsepi_int(:,1), pointsepi_int(:,2));
    