function []=zaladuj(rozszerzenie, sciezka, delim, firstrow)

if isempty(sciezka)
    sciezka='./';
end

pliki=dir(sciezka);

for i=1:size(pliki,1)
    if ~isempty(strfind(pliki(i).name,rozszerzenie))
        varn1=strsplit(pliki(i).name,'.');
        varn=matlab.lang.makeValidName(varn1{1});
        plik=dlmread(pliki(i).name,delim,firstrow-1,0);
        assignin('base', varn, plik);
    end
    
    
end

end