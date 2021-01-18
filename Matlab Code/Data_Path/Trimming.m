function imgout =Trimming(imagein)
    reslution=size(imagein);
    ofLeft=0;
    ofRight=0;
    ofTop=0;
    oftBot=0;
   
    
    for(No=reslution(1):-1:1)
        if(sum(imagein(No,:),2)==reslution(2))
            oftBot=oftBot+1;
        else
            break;
        end;
    end;
    
    for(No=reslution(2):-1:1)
        if(sum(imagein(:,No),1)==reslution(1))
            ofRight=ofRight+1;
        else
            break;
        end;
    end;
    
    for(No=1:reslution(1))
        if(sum(imagein(No,:),2)==reslution(2))
            ofTop=ofTop+1;
        else
            break;
        end;
    end;
    

    for(No=1:reslution(2))
        if(sum(imagein(:,No),1)==reslution(1))
            ofLeft=ofLeft+1;
        else
            break;
        end;
    end;
 
    OutTOP=ofTop+1;
    OutBOT=reslution(1)-oftBot;
    OutLEFT=ofLeft+1;
    OutRIGHT=reslution(2)-ofRight;
    imgout=imagein(OutTOP:OutBOT,OutLEFT:OutRIGHT);
end