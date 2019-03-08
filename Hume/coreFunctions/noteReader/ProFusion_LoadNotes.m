function stageData = ProFusion_LoadNotes(stageData, notesFile, recStart)
%stageData = Twin_LoadNotes(stageData, notesFile)
%
%   Import Grass Twin Recording Notes including Lights Off and Lights On
%   and Record Start. Derived from the Walker Lab at UC Berkeley, 2011.
%
%   Inputs:
%   
%       stageData ? Húmë staging data .mat struct 
%
%       notesFile ? Grass Twin .txt notes file
%
%   Outputs:
%   
%       stageData ? staging data .mat struct including events
%
%%   Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
%
%   This file is part of Húmë.
%   
%   Húmë is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
% 
%   Húmë is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with Húmë.  If not, see <http://www.gnu.org/licenses/>.
%
%   Húmë is intended for research purposes only. Any commercial or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%



notes = importdata(notesFile);
recStartLocal = 0;


if(~isfield(stageData, 'ImportEvents'))
    stageData.ImportEvents = [];
end

for i = 1:length(notes)
    [time, tail] = strtok(notes{i}, ',');
    [ep, tail] = strtok(tail, ',');
    [proStage, tail] = strtok(tail, ',');
    
        tail(tail == ' ') = '';
        tail(tail == '-') = '';
        tail(tail == '/') = '';
        tail(tail == '<') = '';
        tail(tail == '>') = '';
        tail(tail == '.') = '';
        tail(tail == ':') = '';
        tail(tail == '''') = '';
        curTime = datenum([time(1:end)], 'HH:MM:SS');
        if(curTime < recStart)
            curTime = curTime + 1;
        end
        curPoint = etime(datevec(curTime), datevec(recStart))*stageData.srate;
        etime(datevec(curTime), datevec(recStart));
        dataOut = [curPoint, 0, 0];

        if(isfield(stageData.ImportEvents, tail(2:end)))
            cur = eval(['stageData.ImportEvents.', tail(2:end), ';']);
            dataOut = [cur; dataOut];
        end
        try
            eval(['stageData.ImportEvents.', tail(2:end), '= dataOut;'])
        catch
            try
                eval(['stageData.ImportEvents.', 's', tail(2:end), '= dataOut;'])
            catch
                display(['Can''t use note: ', tail(2:end)])
            end
        end
    
end


if(~isfield(stageData, 'recStart'))
    stageData.recStart = recStart;
elseif(stageData.recStart ~= recStart)
    inputRecStart = datestr(stageData.recStart, 'HH:MM:SS');
    notesRecStart = datestr(recStart, 'HH:MM:SS');
    fprintf('The origional recording start (%s) does not match the notes recording start (%s) (Using origional record start)', inputRecStart, notesRecStart);
end

nLoff = recStart + (stageData.ImportEvents.LightsOut(1)/stageData.srate)/86400;
if(~isfield(stageData, 'lightsOFF'))
    stageData.lightsOFF = nLoff;
    
elseif(stageData.lightsOFF ~= nLoff)
    inputRecStart = datestr(stageData.lightsOFF, 'HH:MM:SS');
    notesRecStart = datestr(nLoff, 'HH:MM:SS');
    fprintf('The origional lights off (%s) does not match the notes lights off (%s) (Using origional lights off)', inputRecStart, notesRecStart);
end  


nLon = recStart + (stageData.ImportEvents.LightsOn(1)/stageData.srate)/86400;
if(~isfield(stageData, 'lightsON'))
    stageData.lightsON = nLon;
    
elseif(stageData.lightsON ~= nLon)
    inputRecStart = datestr(stageData.lightsON, 'HH:MM:SS');
    notesRecStart = datestr(nLon, 'HH:MM:SS');
    fprintf('The origional lights on (%s) does not match the notes lights on (%s) (Using origional lights on)', inputRecStart, notesRecStart);
end  







