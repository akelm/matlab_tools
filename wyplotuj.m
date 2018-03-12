function []=wyplotuj(varn,kolumny,unor)

if isempty(kolumny)
    kolumny=[1 2];
end

for i=2:length(kolumny)
    hold on;
    if ~unor
        plot(varn(:,1),varn(:,i));
    else
        plot(varn(:,1),unorm(varn(:,i)));
    end
end