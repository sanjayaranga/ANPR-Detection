
classdef Solution < handle

    properties
        status; file; do_interrupt; frame; results_raw; results; vid; exceptions; 
               
    end
    
    methods
        function self = Solution(Dir)
            self.results = {};
            self.do_interrupt = false;
            self.results_raw = {};
            self.frame.nr = 0; 
            self.exceptions = [];
            self.set_status(0);
            self.browse(Dir);
           
        end
        
        function start(self)
            global gui settings;
            Time_ST = tic;
            clearvars self.frame;
            self.frame.nr = 2;
            self.do_interrupt = false;
            self.exceptions = [];
            self.set_status(1);
            gui.SelfMeter(0, 'Starting');
            
            while ~self.do_interrupt && hasFrame(self.vid)
                self.frame.image     = readFrame(self.vid);
                self.frame.timestamp = self.vid.currentTime;
                self.frame.nr        = uint32(self.frame.timestamp * self.vid.FrameRate);
                
                try  [LP, self.frame.image_p] = FrameExtract(self.frame.image);
                    if ~isempty(LP)
                        self.add_result(LP, self.frame.nr, self.frame.timestamp);
                    end
                     gui.Vframe();
                    
                catch EX
                    self.exceptions(end+1) = self.frame; 
                end
                gui.SelfMeter(self.frame.timestamp / self.vid.Duration, LP);
                DWN = toc(Time_ST) / (1+settings.T/104) - self.vid.CurrentTime;
                DWN = min(DWN, settings.mfrm/self.vid.FrameRate);
                DWN = max(DWN, 1/self.vid.FrameRate); 
                Time_N = self.frame.timestamp + DWN - 0.5/self.vid.FrameRate;
                    
                
                if Time_N > self.vid.Duration
                    break;
                end
                self.vid.CurrentTime = Time_N;
            end
            
            if self.do_interrupt
                disp(['Process is stoped. results will be partial']);
            end
            
            self.results_raw = self.results;
            self.results     = self.post_process(self.results);
            gui.Tblresults();
            
            t_end = toc(Time_ST) - DWN;
            gui.SelfMeter(1, 'Finish');
            self.set_status(0);
                        
            disp(['Processed ' num2str(t_end) ' seconds,  ' ...
                num2str(100*t_end/self.vid.Duration) '% of total durations.']);
            disp([int2str(numel(self.exceptions)) ' exceptions found.']);
        end
        
        
        function PRC = post_process(self, UPC)
            UPC(find(char(UPC(:,1)) == 'e'),:) = []; 
            
            CharD = sum((char(UPC(1:size(UPC,1)-1,1)) ~= ...
                              char(UPC(2:size(UPC,1),  1))), 2);
            Plate_D = find(CharD > 3) + 1;
            PRC = {};
            Plate_D = [1; Plate_D; size(UPC,1)+1];
            for b = 1:(length(Plate_D) - 1) 
                Time_Lapce = Plate_D(b):(Plate_D(b+1) - 1);
                if length(Time_Lapce) < 3 
                    continue;
                end
                All_plates = char(UPC(Time_Lapce,1)); 
                PRC(end+1,:) = {'', cell2mat(UPC(Time_Lapce(1),2)), ...
                    cell2mat(UPC(Time_Lapce(1),3))}; 
                
                Processed = [];
                for i = 1:size(All_plates,2) 
                    [ALL,~,Occur] = unique(All_plates(:,i));
                    Plate_3 = zeros(size(ALL));
                    for R = 1:length(ALL) 
                        Plate_3(R) = numel(find(Occur == R));
                    end
                    [~,RMx] = max(Plate_3);
                    
                    if ALL(RMx) ~= ' ' 
                        Processed(end+1) = ALL(RMx); 
                    end
                end
                PRC(end,1) = {char(Processed)};
            end
        end
        
        
        function interrupt(self)
            self.do_interrupt = true;
        end
        
        function add_result(self, Letter, Fextract, Ts)
            global gui;
            
            self.results(end+1,:) = {Letter, Fextract, Ts};
            gui.Tblresults();
        end
        
        
        function browse(self, Dir)
            global gui;
            
            self.file.path = Dir;
                 
            self.vid = VideoReader(self.file.path);
        end
        
        function set_status(self, Detail)
            global gui;
            
            self.status = Detail;
            gui.update_Start(self.status);
        end
       
    end
        
end