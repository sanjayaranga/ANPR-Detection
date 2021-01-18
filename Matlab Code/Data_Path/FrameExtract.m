function [LP, Limage] = FrameExtract(img)
    LP = []; 
    LP_num = BORDER(img);
    if(isempty(LP_num))
        LP='e';
        Limage=0;
        return;
    end;
    LP_num = LP_num{1}; 
    LP_num = Binarization(LP_num);
    R_TEMP = label(LP_num);
    Limage = LP_num; 
    R_TEMP = dip_array(R_TEMP);
    R_TEMP = Segmentation(R_TEMP);
    LP = LWrapping(R_TEMP, 120000);
    
    
end
