function wynik=qyield(chrom_str,chromsolv_str,ref_str,refsolv_str,filtr,qyref,richrom_str,riref_str,przedzial,przedzial_ref)

xx=dlmread(chrom_str);
chrom=xx(:,:);
xx=dlmread(ref_str);
ref=xx(:,:);
mask=ones(size(chrom(:,1)));
kolumna=4;


if ~isempty(chromsolv_str)
    chromsolv=dlmread(chromsolv_str);
    chrom(:,2)=chrom(:,kolumna)-chromsolv(:,kolumna);
end

if ~isempty(refsolv_str)
    refsolv=dlmread(refsolv_str);
    ref(:,2)=ref(:,kolumna)-refsolv(:,kolumna);
end

if ~isempty(przedzial)
    mask=((chrom(:,1)>=przedzial(1)) & (chrom(:,1)<=przedzial(2)));
    chrom=chrom(mask,:);
end
if ~isempty(przedzial_ref)
    mask_ref=((ref(:,1)>=przedzial_ref(1)) & (ref(:,1)<=przedzial_ref(2)));
    ref=ref(mask_ref,:);
end

if ~isempty(filtr)
    chrom(:,2)=korr_em(chrom(:,1),chrom(:,2),[],[],filtr,[],[],0);
    ref(:,2)=korr_em(ref(:,1),ref(:,2),[],[],filtr,[],[],0);
end

figure;
subplot(2,1,1);
plot(chrom(:,1),chrom(:,2));
set(gca,'YLim',[min(chrom(:,2),[],1), max(chrom(:,2),[],1)])

subplot(2,1,2);
plot(ref(:,1),ref(:,2))
set(gca,'YLim',[min(ref(:,2),[],1), max(ref(:,2),[],1)])


fileID = fopen('RI');
RI=textscan(fileID,'%s %f');

for i=1:length(RI{1})
    if strcmp(RI{1}(i),richrom_str)
        richrom=RI{2}(i);
    end
    if strcmp(RI{1}(i),riref_str)
        riref=RI{2}(i);
    end
end

wynik=qyref*sum(chrom(:,2))/sum(ref(:,2))*(richrom^2)/(riref^2);

end