function [] = start(start_dir, end_dir)
for i = start_dir:end_dir
    index = num2str(i);
    manual_file = ['manual_seg/manual_seg_32points_pat' index '.mat'];
    data_file  = ['mrimages/sol_yxzt_pat' index '.mat'];
    
    load(data_file);
    
    [~,~,z_pos,time_pos] = size(sol_yxzt);
    
    for m = 1: z_pos
        for n = 1: time_pos
            gen_data(manual_file, data_file, 500, m, n);
        end
    end
    
end
