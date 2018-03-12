function [mmax,xmax]=flm(X,M,Z,step1,step2,minx,minm)
xi=[X(1,1):step1:X(1,size(X,2))];
mi=[M(1,1):step2:M(size(M,1),1)];
[XI,MI]=meshgrid(xi,mi);
ZI = interp2(X,M,Z,XI,MI,'spline');
[lmaxima,~]= localmax(ZI);
[iRow,iCol] = find( (ZI>=minm).*lmaxima);
mmax=[xi(iCol)',mi(iRow)'];
[lmaxima,~]= localmax(ZI');
[iRow,iCol] = find( (ZI>=minx).*lmaxima');
xmax=[xi(iCol)',mi(iRow)'];
end
