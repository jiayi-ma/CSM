function [precision, recall, corrRate] = evaluate(CorrectIndex, VFCIndex, siz)

% Authors: Jiayi Ma (jyma2010@gmail.com)
% Date:    04/17/2012

if length(VFCIndex)==0
    VFCIndex = 1:siz;
end

tmp=zeros(1, siz);
tmp(VFCIndex) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)+1;
VFCCorrect = find(tmp == 2);
NumCorrectIndex = length(CorrectIndex);
NumVFCIndex = length(VFCIndex);
NumVFCCorrect = length(VFCCorrect);

corrRate = NumCorrectIndex/siz;
precision = NumVFCCorrect/NumVFCIndex;
recall = NumVFCCorrect/NumCorrectIndex;

fprintf('\ncorrect correspondence rate in the original data: %d/%d = %f\n', NumCorrectIndex, siz, corrRate);
fprintf('precision rate: %d/%d = %f\n', NumVFCCorrect, NumVFCIndex, precision);
fprintf('recall rate: %d/%d = %f\n', NumVFCCorrect, NumCorrectIndex, recall);