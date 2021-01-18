
function Final=Segmentation(img)
    Size=size(img);
    NU=2;
    OUT_2(1)=0;
    Final(1)=struct('image',-1);
    for(k=1:Size(2))
        CLMN=img(:,k);
        for(NU1=1:Size(1))      
            if(not(any(CLMN(NU1) == OUT_2)))               
                OUT_2(NU)=CLMN(NU1);                
                Final(NU-1)=struct('image',Trimming(not(img == OUT_2(NU))));
                NU=NU+1;
            end
        end
    end
end