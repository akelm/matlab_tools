% na podstawie haiss2007
% daje stezenie w cz./ml
function [rozm,stezenie]=aunpconc(wext,wref)
    load haiss2007.mat
    if exist('wref','var')
        wref1=interp1(wref(:,1),wref(:,2),wext(:,1),'spline','extrap');
        wext(:,2)=wext(:,2)-wref1;
    end
    % znajduje pol SPR
    datasp=sign(wext(2,1)-wext(1,1));
    wext1(:,1)=wext(1,1):0.1*datasp:wext(size(wext,1),1);
    wext1(:,2)=interp1(wext(:,1),wext(:,2),wext1(:,1),'spline');
    % size(wext1)
    ind=knnsearch(wext1(:,1), [525;580]);
    [~,imax]=max(wext1([ind(1):datasp:ind(2)],2));
    polmax=wext1(ind(1)+(-1+imax)*datasp,1);
    % okreslam wielkosc np
    ind2=knnsearch(polspr(:,1),polmax);
    rozm=polspr(ind2,2);
    % znajduje ekstynkcje przy 450
    ind3=knnsearch(wext1(:,1),450);
    extynkcja=wext1(ind3,2);
    % znajduje wsp ekst
    ind4=knnsearch(epsilon(:,1),rozm);
    wspeks=epsilon(ind4,2);
    % znajduje stezenie
    stezenie=extynkcja/wspeks*6.022*10^20;
end