%   This is a demo for removing outliers.

% Authors: Jiayi Ma (jyma2010@gmail.com)
% Date:    11/17/2012

clear all; 
close all; 
normalize = 1;
visualize = 1;
conf.minP = 1e-5;
conf.lambda = 500;
conf.a = 5;

ImgName1 = 'church1.jpg' ;
ImgName2 = 'church2.jpg' ;

I1 = imread(ImgName1) ;
I2 = imread(ImgName2) ;

load('church.mat');

normal.xm=0; normal.ym=0;
normal.xscale=1; normal.yscale=1;
if normalize, [nX, nY, normal]=norm2(X,Y); end
nX = [nX, ones(size(nX,1), 1)];
nY = [nY, ones(size(nY,1), 1)];

if ~exist('conf'), conf = []; end
conf = EMTPS_init(conf);

tic;Transform=EMTPS(nX, nY, conf.gamma, conf.lambda, conf.theta, conf.a, conf.MaxIter, conf.ecr, conf.minP);toc;

if normalize, Transform.V=Transform.V*normal.yscale+repmat(normal.ym,size(Y,1),1); end 

if ~exist('CorrectIndex'), CorrectIndex = Transform.Index; end
[precise, recall, corrRate] = evaluate(CorrectIndex, Transform.Index, size(X,1));
plot_matches(I1, I2, X, Y, Transform.Index, CorrectIndex)

if visualize
    idx = Transform.Index;
    interval = 20;
    WhiteInterval = 255*ones(size(I1,1), interval, 3);
    figure;imagesc(cat(2, I1, WhiteInterval, I2)) ;
    hold on ;
    line([X(idx,1)'; Y(idx,1)'+size(I1,2)+interval], [X(idx,2)' ;  Y(idx,2)'],'linewidth', 1, 'color', 'b') ;
    axis equal ;axis off  ; 
    drawnow;
    
    idx = setdiff(1:size(X, 1), Transform.Index);
    interval = 20;
    WhiteInterval = 255*ones(size(I1,1), interval, 3);
    figure;imagesc(cat(2, I1, WhiteInterval, I2)) ;
    hold on ;
    line([X(idx,1)'; Y(idx,1)'+size(I1,2)+interval], [X(idx,2)' ;  Y(idx,2)'],'linewidth', 1, 'color', 'b') ;
    axis equal ;axis off  ; 
    drawnow;
end
