function plot_matches(I1, I2, X, Y, VFCIndex, CorrectIndex)

% Authors: Jiayi Ma (jyma2010@gmail.com)
% Date:    04/17/2012

% Define the most matches to plot
NumPlot = 50;

n = size(X,1);
tmp=zeros(1, n);
tmp(VFCIndex) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)+1;
VFCCorrect = find(tmp == 2);
TruePos = VFCCorrect;   %Ture positive
tmp=zeros(1, n);
tmp(VFCIndex) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)-1;
FalsePos = find(tmp == 1); %False positive
tmp=zeros(1, n);
tmp(CorrectIndex) = 1;
tmp(VFCIndex) = tmp(VFCIndex)-1;
FalseNeg = find(tmp == 1); %False negative

NumPos = length(TruePos)+length(FalsePos)+length(FalseNeg);
if NumPos > NumPlot
    t_p = length(TruePos)/NumPos;
    n1 = round(t_p*NumPlot);
    f_p = length(FalsePos)/NumPos;
    n2 = round(f_p*NumPlot);
    f_n = length(FalseNeg)/NumPos;
    n3 = round(f_n*NumPlot);
else
    n1 = length(TruePos);
    n2 = length(FalsePos);
    n3 = length(FalseNeg);
end

per = randperm(length(TruePos));
TruePos = TruePos(per(1:n1));
per = randperm(length(FalsePos));
FalsePos = FalsePos(per(1:n2));
per = randperm(length(FalseNeg));
FalseNeg = FalseNeg(per(1:n3));

interval = 20;
WhiteInterval = 255*ones(size(I1,1), interval, 3);
figure;imagesc(cat(2, I1, WhiteInterval, I2)) ;
hold on ;
line([X(FalseNeg,1)'; Y(FalseNeg,1)'+size(I1,2)+interval], [X(FalseNeg,2)' ;  Y(FalseNeg,2)'],'linewidth', 1, 'color', 'g') ;
line([X(TruePos,1)'; Y(TruePos,1)'+size(I1,2)+interval], [X(TruePos,2)' ;  Y(TruePos,2)'],'linewidth', 1, 'color', 'b') ;
line([X(FalsePos,1)'; Y(FalsePos,1)'+size(I1,2)+interval], [X(FalsePos,2)' ;  Y(FalsePos,2)'],'linewidth', 1, 'color', 'r') ;
axis equal ;axis off  ; 
drawnow;