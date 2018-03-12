function wynik=korr_em(lambda,fl,lex,filtr_in,filtr_out,abs_in,abs_out,sfera)

if ( (~isempty(fl)) && (~isempty(lambda)))
    wynik=fl; 
    datasp=abs(lambda(1)-lambda(2));
    mnoz=100;
    rozm=size(fl,2);
    
    
     if ~isempty(filtr_in)


         
        eval(['f_in=dlmread(''/home/ania/Desktop/core-shell/fluorolog/filtry/',filtr_in,'_1.ASC'');']);
        f_in1=f_in(  find(f_in(:,1)==round(lex))   ,2);
        wynik(:,1:rozm)=wynik(:,1:rozm)/f_in1*mnoz;
 
         

       fprintf(2,'filtr na wzbudzenie ok\n') 
     end
    
     
    if ~isempty(filtr_out)
        
        
        if datasp==0.5
        eval(['f_out=dlmread(''/home/ania/Desktop/core-shell/fluorolog/filtry/',filtr_out,'_05.ASC'');']);
        
        f_out1=f_out(  find(find(f_out(:,1)==lambda(size(lambda,1))):-datasp:f_out(:,1)==lambda(1))   ,2);
        wynik(:,1:rozm)=wynik(:,1:rozm)./repmat(f_out1,1,rozm)*mnoz;
        fprintf(2,'filtr na emisję ok\n') 
        end  
        
        
        if (datasp-floor(datasp))==0
        eval(['f_out=dlmread(''/home/ania/Desktop/core-shell/fluorolog/filtry/',filtr_out,'_1.ASC'');']);
%find(f_out(:,1)==lambda(1))
%find(f_out(:,1)==lambda(1)) 
%f_out
%lambda(max(size(lambda)))
% find(f_out(:,1)==lambda(max(size(lambda))))
%size(f_out)
        f_out1=f_out(  find(f_out(:,1)==lambda(1)):-datasp: find(f_out(:,1)==lambda(max(size(lambda))))  ,2);
%        find(f_out(:,1)==lambda(1))
%         lambda(size(lambda,1))
         %size(f_out)
%          size(f_out1)
%          size(wynik)
        wynik(:,1:rozm)=wynik(:,1:rozm)./repmat(f_out1,1,rozm)*(mnoz);
        fprintf(2,'filtr na emisję ok\n') 
        end  
        
        if (datasp~=0.5 && (datasp-floor(datasp))~=0)
            disp('zwieksz datasp do 0.5 lub 1')
        end
        
    end
     
     
    if ~isempty(abs_in)
        if (size(abs_in(:))==1)
            wynik(:,1:rozm)=wynik(:,1:rozm)*10^(abs_in/2);
            fprintf(2,'korekcja na absorpcję wzbudzenia ok\n') 
        else
            [~,ind]=min(abs(abs_in(:,1)-lex*ones(size(abs_in(:,1)))   ));
            wynik(:,1:rozm)=wynik(:,1:rozm)*10^(abs_in(ind(1),2)/2);
            fprintf(2,'korekcja na absorpcję wzbudzenia ok\n') 
        end    
    end
    
     
     
    if ~isempty(abs_out)
        datasp2=roundn(abs(abs_out(1,1)-abs_out(2,1)),-1);
        wsp2=datasp/datasp2;
        if (wsp2-floor(wsp2)==0)          
            abs_out1=abs_out(  find(abs_out(:,1)==lambda(1)):wsp2:find(abs_out(:,1)==lambda(size(lambda,1)))   ,2);
            wynik(:,1:rozm);
            (abs_out1/2);
            wynik(:,1:rozm)=wynik(:,1:rozm).*repmat(10.^(abs_out1/2),1,rozm);
            fprintf(2,'korekcja na absorpcję emisji ok\n') 
        else
            fprintf(2,'abs_out: zwieksz datasp do 0.5 lub 1\n')
        end    
    end
     
     if sfera==1
	korr_sf=dlmread('/home/ania/Desktop/core-shell/fluorolog/filtry/korrsf5nm');
	if datasp==0.5
	korr_sf=interp1(korr_sf(:,1),korr_sf(:,2),korr_sf(1,1):0.5:korr_sf(end,1),'spline');
        end
	wynik(:,1:rozm)=wynik(:,1:rozm).*korr_sf(lambda(1:datasp:end)-299,2);
	fprintf(2,'sfera ok\n') 
     end
    
 end
    %figure; plot(lambda,[fl(:,1),wynik(:,2)])
    
end
