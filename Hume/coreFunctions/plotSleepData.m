function handles = plotSleepData(handles, range)
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

%% SET UP
plotSpace = 150; % 150 microVolts p-p (at normal scale) between channels
EEG = handles.EEG;
srate = EEG.srate;
electrodes = handles.CurrMontage.electrodes;
colors = handles.CurrMontage.colors;
scaleSpace = handles.CurrMontage.scale;
hideCh = handles.CurrMontage.hideChans;
bigGridMat = handles.CurrMontage.bigGridMat;
ampChans = handles.CurrMontage.scaleChans;
h = handles.axes1;

%% Plot all of the electrode data on the main axes (handles.axes1)
hold(h, 'off')
%Loop through each electrode in the above list
for e = 1:length(electrodes)
    %find data for that electrode by name
    for c = 1:length(EEG.chanlocs)
        
        Elect = EEG.chanlocs(c).labels;
        
        %Checks to see if this electrode should be ploted
        if(strcmp(electrodes{e}, Elect) == 1 && ~ismember(electrodes{e}, hideCh))
            
            %Makes sure the current rage is legal.
            if(range(1) > 0 && range(end) < length(EEG.data))
                
                %extracts the data to be ploted and multiples by -1 so that
                %the data is ploted inverted.
                centerData = (EEG.data(c, range))*-1;
                scaledCenterData = centerData .* (plotSpace/str2num(scaleSpace{e}));
                %scalesData
                
                %plots the data for this electrode at the appropriate y
                %axis location.
                plotLines = plot(h, range, scaledCenterData + e*plotSpace, 'color', colors{e});
                
                %Adds a tag to each plot line for use with event marking
                for i = 1:length(plotLines)
                    set(plotLines(i), 'Tag', sprintf('scale:%d;chan:%d',e*plotSpace,c))
                end
                hold(h, 'on')
                
                % Here the scale lines are plotted if the current electrode
                % is in the scaleCh list.
                 if(ismember(electrodes{e}, ampChans))
                    gridDataNum =  find(ismember(ampChans,electrodes{e}));
                    gridData = bigGridMat{gridDataNum,2};

                     for g = 1:size(gridData,1)
                         
                         plot(h, range, zeros(size(centerData)) + e*plotSpace + (-1*str2num(gridData{g,1}))*(plotSpace/str2num(scaleSpace{e})), '-.', 'color', gridData{g,2});

                     end
                 end
            end
            
        end
    end
end

% Y axis - uses electrode list as labels 
maxY = plotSpace*(length(electrodes) + .75);
set(h, 'Ylim', [plotSpace/4, maxY], 'YTick', plotSpace:plotSpace:(maxY), 'YTickLabel', electrodes)

%% This section checks for any USER events in the current data range and plots them
%set(handles.Artifact,'Value',0);
handles.currentArtifact = 0;
set(handles.axes1,'Color',[1 1 1]);
set(handles.Artifact,'BackgroundColor',[1 1 1]);
%checks for events
if(isfield(handles.stageData, 'MarkedEvents'))
    ylimVal = ylim(h);
    labels = unique(handles.stageData.MarkedEvents(:,1));

    %loops through all the labels in the events struct
    for l = 1:length(labels)
           

            
       %gets the data from the current label
       cur = cell2mat(handles.stageData.MarkedEvents(find(ismember(handles.stageData.MarkedEvents(:,1),labels(l))),2:3));
       
       %checks for any events that are in the current range
       curEvents = cur(cur(:, 1) >= range(1) & cur(:, 1) <= range(end), :);
       
        %Artifacts
        if and(strcmp(labels{l},'[0]'),size(curEvents,1))
            handles.currentArtifact = 1;
            set(handles.Artifact,'BackgroundColor',[1 .95 .95]);
            set(handles.axes1,'Color',[1 .95 .95]);
        end
        
       %plots all the events in the current range
       for c  = 1:size(curEvents, 1)
           

           
           m = plot(h, [curEvents(c, 1), curEvents(c, 1)], ylimVal, 'k', 'LineWidth', 2);
           set(m, 'Tag', labels{l});
           if(gca ~= h)
                axes(h)
           end
           text(curEvents(c, 1) + 5, plotSpace/4 +10, labels{l})
       end
    end
end

%% CONTROL ARTIFACTS



%% NOTATION EVENTS

if(isfield(handles.stageData, 'ImportEvents'))
    ylimVal = ylim(h);
    labels = fields(handles.stageData.ImportEvents);
    
    %loops through all the labels in the events struct
    for l = 1:length(labels)
       %gets the data from the current label
       cur = eval(['handles.stageData.ImportEvents.', labels{l}, ';']);
       
       %checks for any events that are in the current range
       curEvents = cur(cur(:, 1) >= range(1) & cur(:, 1) <= range(end), :);
       
       %plots all the events in the current range
       for c  = 1:size(curEvents, 1)
           m = plot(h, [curEvents(c, 1), curEvents(c, 1)], ylimVal, 'k', 'LineWidth', 2);
           set(m, 'Tag', labels{l});
           if(gca ~= h)
                axes(h)
           end
           text(curEvents(c, 1) + 5, 10, labels{l})
       end
    end
end


%% This section fixes the axes labels and ranges 

% Y axis - uses electrode list as labels 
maxY = plotSpace*(length(electrodes) + .75);
set(h, 'Ylim', [plotSpace/4, maxY], 'YTick', plotSpace:plotSpace:(maxY), 'YTickLabel', electrodes)

% X axis
newX = [range(1), range(end)];
xlim(h, newX)

tickMarks = (((newX(1) - 1)/srate):10:((newX(2) - 1)/srate));
numTicks = length(tickMarks);
distanceTicks = handles.stageData.win/numTicks;
curWin = xlim;
ind=floor(newX(2)/(handles.stageData.win*srate));
rstart = handles.stageData.recStart + (floor(newX(1)/srate)/86400);

tickStrs = {datestr(rstart,'HH:MM:SS')};

for t = 2:numTicks
    
    tickStrs= [tickStrs; datestr(rstart + (distanceTicks*(t-1))/86400,'HH:MM:SS')];
    
end

set(h, 'XTick', newX(1):10*srate:newX(2), 'XTickLabel', tickStrs, 'XGrid', 'on','XMinorGrid','on','Gridlinestyle','-');
h.XAxis.MinorTickValues = [newX(1):1*srate:newX(2)];

set(gca, 'Ticklength', [0 0])
%% this section plot lights on and lights off lines

onT = etime(datevec(handles.stageData.lightsON), datevec(handles.stageData.recStart))*srate;
offT = etime(datevec(handles.stageData.lightsOFF), datevec(handles.stageData.recStart))*srate;
plot(h, [onT, onT], [0, maxY], 'r', 'LineWidth', 2);
plot(h, [offT, offT], [0, maxY], 'g', 'LineWidth', 2);



