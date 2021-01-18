function [WdtH, ouT] = Detect_RECT(mask, image)
   [hori, vert] = find(mask);
   
   [~, place] = min(vert-hori);
   L1 = [vert(place), hori(place)]; 
   
   [~, place] = max(vert-hori);
   L2 = [vert(place), hori(place)]; 
   
   [~, place] = max(vert+hori);
   L3 = [vert(place), hori(place)]; 
   
   [~, place] = min(vert+hori);
   L4 = [vert(place), hori(place)]; 
     
   ouT = 2;
  
   HT = 38;
   WdT = 138;
   
   fixedPoints = [L4; L1; L3; L2];
   movingPoints = [1 1; 1 HT; WdT HT; WdT 1];
   try
   img = rgb2gray(image);
   TFORM = fitgeotrans(fixedPoints,movingPoints,'projective');
   R=imref2d(size(img),[1 size(img,2)],[1 size(img,1)]);
   WdtH=imcrop(imwarp(image,R,TFORM,'OutputView',R), [1 1 WdT HT]);
   
   catch ME
      WdtH = 0;
      ouT = 0; 
   end   
end

