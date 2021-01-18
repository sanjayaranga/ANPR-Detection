
function [select, dir, done] = detect(varargin)
    
    select = false; 
    dir    = [];
    done = false;

    if nargin == 0  %#ok<ALIGN>
        [root, loct] = uigetfile('*.avi');
            if root == false 
              return;
            end
             dir = [loct root];
            else
             dir = varargin{1};
            end
    if exist(dir, 'file') ~= 2 % checking for file
        fprintf('"%s" is not exist.\n', dir);
        return;
    end
   
    [~, ~, Compatibility] = fileparts(dir); % Check the compatibility 
        Imagespprt = imformats;             % supporting image extensions 
        Videospprt = VideoReader.getFileFormats(); %supporting video extensions
        
            Compatibility = Compatibility(2:end);
    Imag  = any(ismember([Imagespprt.ext], Compatibility));
    done  = any(ismember({Videospprt.Extension}, Compatibility));

    if ~(done || Imag)
        fprintf('File is not supportive).\n');
        return;
    end
        select = true;
end