function [S1c,S1,X,M]=wczytajm(ex,em,filtrout)
sizex=size(ex,2);
sizem=size(em,2);
% ex -- wektor wzbudzenia
% em - wektor emisji
S1_1=zeros(sizem,sizex);
S1c_1=zeros(sizem,sizex);
% emisja w pionie, jak z plików
% wzbudzenie w poziomie
[X,M]=meshgrid(ex,em);

pliki=dir;
n=0;
abs_bok=[];
abs_przod=[];
for i=1:size(pliki,1)
if ~isempty(strfind(pliki(i).name,'bok'))    
    abs_bok=dlmread(pliki(i).name);
end

if ~isempty(strfind(pliki(i).name,'przod'))    
    abs_przod=dlmread(pliki(i).name);
end

if ~isempty(strfind(pliki(i).name,'.DAT'))
	n=n+1;
    pliki(i).name
    plik=dlmread(pliki(i).name);
    aaa=pwd;
    % str2num(pliki(i).name(5:7));
    % str2num(aaa(size(aaa,2)));
    nrkol=n+51*(str2num(aaa(size(aaa,2)))-1);
    nzer=sizem-size(plik,1);
    % nrkol opisuje ile 0 dodac na poczatku oraz w jakiej kolumnie (+1)
    % umiescic emisję
    S1_1((nzer+1):sizem,nrkol)=plik(:,4)./plik(:,6);
    S1c_1((nzer+1):sizem,nrkol)=plik(:,2)./plik(:,6);
end
end


S1_2=korr_em(em',S1_1,[],[],filtrout,[],abs_bok,0);
% krzywa1 to korekcja do R1
S1=korr_em(ex',S1_2',[],[],'krzywa1',[],abs_przod,0)';
S1c_2=korr_em(em',S1c_1,[],[],filtrout,[],abs_bok,0);
S1c=korr_em(ex',S1c_2',[],[],'krzywa1',[],abs_przod,0)';

dlmwrite('X.dat',X,'\t')
dlmwrite('M.dat',M,'\t')
dlmwrite('S1.dat',S1,'\t')
dlmwrite('S1c.dat',S1c,'\t')


end
