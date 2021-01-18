function [letter,ent] = mapping(imagein,list,xmax)
    out=size(list);
    out=out(2);
    OutMAX=xmax;
    for(nt=1:out)
        x=xor(list(nt).image,imagein);
        SUM=sum(sum(x));
        if(SUM<OutMAX)
            OutMAX=SUM;
            character=list(nt).letter;
        end;
    end;
   ent=OutMAX;
   letter=character;
 end