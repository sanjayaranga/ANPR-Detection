function out = Thrshold(img,Yellow,instant)
    a(:,:,1)=img(:,:,1,:)-Yellow(1);
    a(:,:,2)=img(:,:,2,:)-Yellow(2);
    a(:,:,3)=img(:,:,3,:)-Yellow(3);
    b=sum(abs(a),3);
    out=b<(instant);
end