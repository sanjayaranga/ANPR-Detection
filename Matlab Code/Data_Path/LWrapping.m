function letter = LWrapping(img1, xmax)
    global chardata;
    
    out=size(img1);
    out=out(2);
    out_f=size(chardata.forms);
    out_f=out_f(1);
    
    Tempry=zeros(3,out);
    D_Out=zeros(3,out_f);
    Result=zeros(1,out_f);
    
    if(out~=8)
        letter='error';
        return;
    end
    for(NuM=1:out)
        images(NuM)=struct('image',imresize(img1(NuM).image,chardata.defaultsize));
    end;
    for(NuM=1:out)
        [Tempry,Tempry_2]=mapping(images(NuM).image,chardata.letters,xmax);
        D_Out(1,NuM)=Tempry_2;
        Character(1,NuM)=Tempry;
    end;
    for(NuM=1:out)
        [Tempry,Tempry_2]=mapping(images(NuM).image,chardata.numbers,xmax);
        D_Out(2,NuM)=Tempry_2;
        Character(2,NuM)=Tempry;
    end;
    for(NuM=1:out)
        [Tempry,Tempry_2]=mapping(images(NuM).image,chardata.minussign,xmax);
        D_Out(3,NuM)=Tempry_2;
        Character(3,NuM)=Tempry;
    end;
    for(NuM=1:out_f)
        Tempry(1)=0;
        for(NuM_2=1:out)
            Tempry(NuM_2)=D_Out(chardata.forms(NuM,NuM_2),NuM_2);
        end;
        Result(NuM)=sum(Tempry);
    end;
    max=1200000;
    result=0;
    for(NuM=1:out_f)
        if(Result(NuM)<max)
            max=Result(NuM);
            result=NuM;
        end;
    end;
    form=chardata.forms(result,:);
    for(NuM=1:out)
        letter(NuM)=Character(form(NuM),NuM);
    end;

end