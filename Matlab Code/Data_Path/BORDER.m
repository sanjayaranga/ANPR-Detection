function [Border] = BORDER(image)
 
    DetectImg = rgb2hsv(image);
    Real_Masking = Threshold(DetectImg);
    Real_Masking = dip_image(Real_Masking(:, :, 1));
    Masking = Color_threshold(DetectImg);
    Masking = dip_image(Masking(:, :, 1)); 
    Masking = bopening(Masking, 4, -1, 0);
    Masking = bclosing(Masking, 12, -1, 0);
    Masking = bpropagation(Masking, Real_Masking, Inf, 2, 0);
    Masking = label(Masking, 2, 140, 0); 
    
    MASK_2 = logical(Masking == 1);
    CELL = cell(1, 1);
    
    [imgOUT, NUMBER] = Detect_RECT(MASK_2, image);
    if(NUMBER == 0)
       Border = cell(0, 0); 
    else
        Border{1} = imgOUT;
    end
