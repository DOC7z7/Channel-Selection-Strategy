%This demo code is a channel selection strategy, which is used to select three channels with the highest value from the 16-channel hyperspectral video, laying the foundation for the subsequent object tracking.
%It is noteworthy that the data set used by this code is provided by IEEE WHISPERS. If there is no data set, please go to https://www.hsitracking.com/ 
clear;clc;
close all;
base_path='D:/BaiduNetdiskDownload/whispers/test';
videos={'ball';'basketball';'board';'book';'bus';'bus2';'campus';'car';'car2';'car3';'card';'coin';'coke';'drive';'excavator';'face';'face2';'forest';'forest2';'fruit';'hand';'kangaroo';'paper';'pedestrain';'pedestrian2';'player';'playground';'rider1';'rider2';'rubik';'student';'toy1';'toy2';'trucker';'worker'};OPs = zeros(numel(videos),1);
videoNum=numel(videos);
for vid = 1:videoNum
    video_path = [base_path '/' videos{vid} '/HSI/' ];
    format = 'png';
    files = dir(strcat(video_path,'*.',format));
    ground_truth = dlmread([video_path 'groundtruth_rect.txt']);

    for n = 1:numel(files)
        filename = strcat(video_path,files(n).name);
        img = imread(filename);
        img = X2Cube(img);
        img=img./max(img(:));
        
        if n==1
            [c1,c2,c3] = H2TC(img,ground_truth)    %Three channels with the highest value are obtained: c1,c2,c3
        end

        %The following is the visualization result of three channels

        Final_img= Three_channels_visualization(img,c1,c2,c3);
        
        imshow(Final_img);
        
        %Save the three-channel results
        [path, name, ext] = fileparts(filename) ;
        out_filename = strcat( name , '.jpg' );
        file_path_name = strcat('D:\Three-channel visualization\',videos{vid});
        if exist(file_path_name)== 0
            mkdir(file_path_name);
            mkdir(file_path_name,'\img');
        end
        jpg_file = fullfile( 'D:\Three-channel visualization\',videos{vid} ,'\img\', out_filename ) ;
        imwrite(Final_img,jpg_file,'jpg');
    end
    disp(numel(files));
end