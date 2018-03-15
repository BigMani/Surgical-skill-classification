% This function performs a statistical test to determine if there are
% significant differences in means between two different input matrices
% Inputs: A, B: two different Mx1 matrices
%         method: 'ranksum', 'ttest', or return if neither is provided

function [p,ptext] = sigStar(A, B, method)
    if strcmp(method, 'ranksum')
        [p,~] = ranksum(A,B);
    elseif strcmp(method, 'ttest')
        [~,p] = ttest2(A,B);
    else
        disp('Select either ''ttest'' or ''ranksum'' for sigStar function input');
        return
    end
    p = floor(p*1000)/1000;
    if p < 0.05
        ptext = '*';
    else
        ptext = 'n.s.';
    end
end