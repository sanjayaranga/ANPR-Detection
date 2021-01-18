
function letter = Letter( image )
    HeighT=size(image,1);
    numb=1;
    iN=0;
    create=0;
    while(numb<size(image,2))
        if(sum(image(:,numb))<HeighT)
            iN=iN+1;
            WdtH=0;
            while (sum(image(:,numb+WdtH))<HeighT)
                WdtH=WdtH+1;
                create=create+1;
            end;
            numb=numb+WdtH+1;
        else
            numb=numb+1;
        end
    end
end

