function stageData = smgEventConvert(stageData)
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
stageData = eventSetup(stageData,length(stageData.stages));

LUT = eventLUT;

for ev = 1:size(LUT,1)
    
    eventList = cell2mat(stageData.MarkedEvents(find(ismember(stageData.MarkedEvents(:,1),LUT{ev,1})),3));
    
    if ~isempty(eventList)
        
        for ep=1:length(eventList)
            
            stageData.eventMat(eventList(ep),ev) = sum(and(ismember(stageData.MarkedEvents(:,1)',LUT{ev,1}),[stageData.MarkedEvents{:,3}]==eventList(ep)));
            
        end
        
    end
    
end

end