function [ RST ] = Binarization( imagein )
    Processing = dip_image(imagein(:, :, 1));
    R_shadow = maxf(Processing,11,'elliptic');
    Processing = Processing + (200 - R_shadow);
    Processing = Processing - 3 * laplace(Processing);
    Processing = ~threshold(Processing, 'isodata', Inf);
    Processing_horiz =  bopening(Processing, 1, 2, 0);
    Processing = bpropagation(Processing_horiz, Processing, Inf, -1, 0);
    
    Processing = brmedgeobjs(Processing);
    Processing = label(Processing, 2, 15); 
    Processing = Processing > 0;
    RST = Processing;
end

