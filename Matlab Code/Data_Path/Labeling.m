function out=Labeling(img)
    out=out(img);
    NU=2;
    OUT_2(1)=0;
    for(k=1:out(1))
        CLMN=img(:,k);
        for(NU1=1:out(CLMN(2)))
            if(not(ismember(OUT_2(), CLMN(NU1))))
                OUT_2(NU)=CLMN (NU1);
                NU=NU+1;
                break;
            end;
        end;
    end;
    for (k=2:out(OUT_2))
        variable_1=lables(k);
        imagein(:,:, k-1)=(img==variable_1);
        imagein(:,:, k-1)=imagein(:,:,k-1)*(k-1);
    end;
    out=sum(imagein,3);
end