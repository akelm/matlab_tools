function [counts,res,korekcja]=korr_alphalas(filename)
[counts,res]=read_thd(filename);
% znajduje nr krzywej z najwieksza liczba calkowitych zliczen
[~,nrmax]=max(sum(counts,2));

%counts(nrmax,:)=[counts(nrmax,7:4096),zeros(1,6)];
% okresla przedzial fitowania
[~,ind1]=find(counts(nrmax,1:2047)==0);
indpocz=max(ind1)+100;
[~,ind2]=find(counts(nrmax,2048:4096)==0);
indkon=min(ind2)-200+2047;

% fituje funkcje kwadratowa, tak na wszelki wypadek...
p2=polyfit(indpocz:indkon,counts(nrmax,indpocz:indkon) ,1);

% tworze krzywa do podzielenia
korekcja=counts(nrmax,:);
korekcja(korekcja==0)=1;
korekcja=korekcja./polyval(p2,1:4096);
%figure;plot(korekcja)
% szukam krzywych niezerowych, ale roznych od nrmax
nrcur=find(sum(counts,2)~=0);
nrcur=nrcur(nrcur~=nrmax);

counts=round(bsxfun(@times,counts(nrcur,:),1./(korekcja)));
res=res(nrcur);

format shortG;
name=[strrep(filename,'.thd','_'),strrep(num2str(res(1)),'.','_'),'.dat'];
dlmwrite(name,counts','delimiter',' ');
end