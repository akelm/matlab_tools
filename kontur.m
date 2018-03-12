function []=kontur(X,M,Y,h)
%contour(X,M,(Y<h).*Y.*(Y>0) + h*(Y>=h))
Z=(Y<h).*Y.*(Y>0) + h*(Y>=h);
contour(X,M,Z,'fill','on','levellist', linspace(min(Z(:)),max(Z(:)), 100))
colormap jet

end