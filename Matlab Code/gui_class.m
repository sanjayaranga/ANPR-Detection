classdef gui_class < handle

    properties
        IMG; LPC; textField;
    end
    
    methods
        function self = gui_class()
            self.IMG    = gui_figure; 
            self.LPC = guihandles(self.IMG);

            set(self.LPC.figure1, 'Name', 'License plate recognition GUI');
            
            self.LPC.axes1.XColor = [1 1 1];
            self.LPC.axes1.YColor = [1 1 1];
            self.LPC.axes1.XTick = [];
            self.LPC.axes1.YTick = [];
            
            self.clean(); % clean window
            set(self.IMG, 'CloseRequestFcn', @self.callback_close);
        end   
        
        function browse(self, varargin)
            global processing;
            % Loading File
            if nargin <= 1 
                [select, dir, done] = detect();
            else
                [select, dir, done] = detect(varargin{1});
            end
            
            if ~select
                return;
            end             
            if exist('processing', 'var')
                delete(processing);
            end
            self.clean();
            [~, naMe, extens] = fileparts(dir); 
             
            self.txtName('Name', [naMe extens]);
            processing = Solution(dir);
        end
        
 
        function start(self)
            global processing; %processing part
               if exist('processing', 'var')
                if processing.frame.nr ~= 0 
                    location = processing.file.path;
                    self.browse(location);
                end
            else
                self.browse();
            end
           processing.start();
        end
        
        function stop(self) %stop process
            global processing;
            processing.interrupt();
        end
        
        function Vframe(self)
            global processing settings;
            
            if settings.raw_video
                proc = processing.frame.image_processed;
            else
                proc = processing.frame.image;
            end
            image(proc, 'Parent', self.LPC.axes1);
            self.LPC.axes1.Visible = 'off';
         end
        
        function clean(self) % clean table and images function and disable buttons
            self.LPC.table_results.Data = {};
            self.SelfMeter(0, '');
            set(self.LPC.Start, 'Enable', 'off'); 
          end
        
        function Tblresults(self) % update table results
            global processing; 
            
            self.LPC.table_results.Data = processing.results;
        end
        
        function txtName(self, FldName, text)
            h = eval(['self.LPC.' FldName]);
            set(h, 'String', text);
        end
        
        function update_Start(self, select)% Disable Buttons
            if select == 0 
                set(self.LPC.Start, 'Enable', 'on');
                set(self.LPC.Stop,  'Enable', 'off');
            else 
                set(self.LPC.Start, 'Enable', 'off');
                set(self.LPC.Stop,  'Enable', 'on');
            end
        end
        
        function SelfMeter(self, fraction, txt)
            detail = self.LPC.axes2;
            barh(detail, 0, fraction, 3, 'c'); % show in bar 
            set(detail, 'XLim', [0 1]);
            set(detail, 'XTick', []);
            set(detail, 'YTick', []);
            set(detail, 'XTickLabel', []);
            set(detail, 'YTickLabel', []);
            self.textField = text(0.5, 0, txt, 'Parent', self.LPC.axes2, ...
                'HorizontalAlignment', 'center');
        end
        
        function exit(self) % exit
            
            delete(self.IMG);
        end
        
        function callback_close(self, ~, event)
            self.exit();
        end
    end
    
end