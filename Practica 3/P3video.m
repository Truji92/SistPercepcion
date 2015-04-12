close all; clear all; clc;

video = videoinput('winvideo',1, 'YUY2_640x360');
video.ReturnedColorSpace = 'RGB';

% Tomamos todos los frames
video.TriggerRepeat = inf; %disparos continuos
video.FrameGrabInterval = 3; % cogemos uno de cada 2

%% 3 
gamma = 4:-0.05:0;
start(video)

for i = 1:length(gamma) 
    I = getdata(video,1);
    I = imadjust(I, [], [], gamma(i));
    imshow(I);
end

stop(video);

%%  4

video.ReturnedColorSpace = 'grayscale';

umbral = 0:255;
start(video);
for i = 1:length(umbral);
    I = getdata(video,1);
    I = I > umbral(i);
    imshow(I);
end

stop(video);

%% 5
video.ReturnedColorSpace = 'RGB';

start(video);
I_anterior = getdata(video,1);
while video.FramesAcquired < 100 
    I = getdata(video,1);
    I_dif = imabsdiff(I, I_anterior);
    imshow(I_dif);
    I_anterior = I;
end

stop(video);

%% 6

video.ReturnedColorSpace = 'grayscale';

umbral = 50;

start(video);
I_anterior = getdata(video,1);
while video.FramesAcquired < 150 
    I = getdata(video,1);
    I_dif = imabsdiff(I, I_anterior) > umbral;
    imshow(I_dif);
    I_anterior = I;
end

stop(video);

%% 7

video.ReturnedColorSpace = 'grayscale';

umbral = 100;

start(video);
I_anterior = getdata(video,1);
while video.FramesAcquired < 150 
    I = getdata(video,1);
    I_dif = imabsdiff(I, I_anterior) > umbral;
    
    
    [Ietiq, N]=bwlabel(I_dif);  
    
    if N > 0
        
        stats=regionprops(Ietiq,'Area','Centroid'); 
        areas=cat(1,stats.Area);
        centroides=cat(1,stats.Centroid); 
        Pos_mayor = find(areas == max(areas));

        subplot(1,2,1);
        imshow(I_dif);
        hold on; 
        plot(centroides(Pos_mayor, 1), centroides(Pos_mayor, 2), 'rx', 'markersize', 10, 'linewidth', 10); 
        hold off;
        
        subplot(1,2,2);
        imshow(I);
        hold on; 
        plot(centroides(Pos_mayor, 1), centroides(Pos_mayor, 2), 'rx', 'markersize', 10, 'linewidth', 10); 
        hold off;
        I_anterior = I;
    end
end

stop(video);

