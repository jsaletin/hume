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
negCh = handles.CurrMontage.negChans;
o2satCh = handles.CurrMontage.o2satChs;
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
        
        %Checks to see if this channel is NOT a numerical channel (e.g., O2sat)
        if(strcmp(electrodes{e}, Elect) == 1 && ~ismember(electrodes{e}, handles.CurrMontage.o2satChs))
            
            %Checks to see if this electrode should be ploted
            if(strcmp(electrodes{e}, Elect) == 1 && ~ismember(electrodes{e}, hideCh))
                
                %Makes sure the current rage is legal.
                if(range(1) > 0 && range(end) < length(EEG.data))
                    
                    %extracts the data to be ploted and mean centers it
                    centerData = (EEG.data(c, range));
                    
                    %check for negative up
                    if ~(strcmp(electrodes{e}, Elect) == 1 && ~ismember(electrodes{e}, negCh))
                        plotNeg=1;
                        centerData = centerData .* -1;
                    else
                        plotNeg=0;
                    end
                    
                    %the data is ploted inverted.
                    
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
                            
                            if plotNeg
                                plot(h, range, zeros(size(centerData)) + e*plotSpace + (-1*str2num(gridData{g,1}))*(plotSpace/str2num(scaleSpace{e})), '--', 'color', gridData{g,2});
                                text(h, range(1), e*plotSpace + (-1*str2num(gridData{g,1}))*(plotSpace/str2num(scaleSpace{e})),gridData{g,1}, 'FontSize', 9);
                            else
                                plot(h, range, zeros(size(centerData)) + e*plotSpace + (str2num(gridData{g,1}))*(plotSpace/str2num(scaleSpace{e})), '--', 'color', gridData{g,2});
                                text(h, range(1), e*plotSpace + (str2num(gridData{g,1}))*(plotSpace/str2num(scaleSpace{e})),gridData{g,1}, 'FontSize', 9);
                            end
                        end
                    end
                end
                
            end
        elseif (strcmp(electrodes{e}, Elect) == 1 && ismember(electrodes{e}, o2satCh) && ~ismember(electrodes{e}, hideCh))
            % THIS IS A NUMERICAL CHANNEL
            %Makes sure the current rage is legal.
            if(range(1) > 0 && range(end) < length(EEG.data))
                %extracts the data to be ploted 
                rawData = (EEG.data(c, range));
                
                % If o2 is < 80; plot at 80
                floorData = rawData;
                floorData(rawData<80) = 80;
                                
                %scalesData
                scaledCenterData  = (75 - -75) * ( (floorData - 80) / (100 - 80)) - 75;
                
                % If o2 is < 80; plot at 80
                
                scaledCenterData = scaledCenterData([1:handles.EEG.srate:end end]);
                
                %plots the data for this electrode at the appropriate y
                %axis location.
                plotLines = plot(h, range([1:handles.EEG.srate:end end]), ...
                  zeros(size(scaledCenterData)) + scaledCenterData + e*plotSpace, 'Marker', 'o', 'color', colors{e});
                text(h, range([1:handles.EEG.srate:end end]), ... 
                  scaledCenterData + e*(plotSpace) - 20, string(num2cell(round(rawData([1:handles.EEG.srate:end end])))),'HorizontalAlignment','center');
                
                %plotLines = plot(h, range([1:handles.EEG.srate:end end]), centerData([1:handles.EEG.srate:end end]) + e*plotSpace, 'Marker', 'o', 'color', colors{e});
                %Adds a tag to each plot line for use with event marking
                for i = 1:length(plotLines)
                    set(plotLines(i), 'Tag', sprintf('scale:%d;chan:%d',e*plotSpace,c))
                end
                hold(h, 'on')
                
                % Here the scale lines are plotted if the current electrode
                % is in the scaleCh list.
                plot(h, range, zeros(size(centerData)) +  e*(plotSpace) + 75, '--', 'color', [0 .5 0]);
                text(h, range(1), e*(plotSpace) + 75,'100', 'FontSize', 9);
                plot(h, range, zeros(size(centerData)) +  e*(plotSpace), '--', 'color', [1 .5 0]);
                text(h, range(1), e*(plotSpace),'90', 'FontSize', 9);
                plot(h, range, zeros(size(centerData)) +  e*(plotSpace) - 75, '--', 'color', [1 0 0]);
                text(h, range(1), e*(plotSpace) - 75,'80', 'FontSize', 9);


                
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
       curEvents = cur(cur(:, 2) == ceil(range(1)./handles.EEG.srate./handles.stageData.win),:);
       
        %Artifacts
        if and(strcmp(labels{l},'[0]'),size(curEvents,1))
            handles.currentArtifact = 1;
            set(handles.Artifact,'BackgroundColor',[1 .95 .95]);
            set(handles.axes1,'Color',[1 .95 .95]);
        end
        
       %plots all the events in the current range
       for c  = 1:size(curEvents, 1)
           m = plot(h, [((curEvents(c, 2)-1)*handles.stageData.win*handles.EEG.srate)+1, ((curEvents(c, 2)-1)*handles.stageData.win*handles.EEG.srate)+1], ylimVal, 'k', 'LineWidth', 2);
           set(m, 'Tag', labels{l});
           if(gca ~= h)
                axes(h)
           end
           text((curEvents(c, 2)-1)*handles.stageData.win*handles.EEG.srate+1 + 5, plotSpace/4 +10, labels{l})
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

tickMarks = (((newX(1) - 1)/srate):1:((newX(2) - 1)/srate));
numTicks = length(tickMarks);
distanceTicks = handles.stageData.win/numTicks;
curWin = xlim;
ind=floor(newX(2)/(handles.stageData.win*srate));
rstart = handles.stageData.recStart + (floor(newX(1)/srate)/86400);

tickStrs = {datestr(rstart,'HH:MM:SS')};

for t = 2:(numTicks+1)
    
    tickStrs= [tickStrs; datestr(rstart + (distanceTicks*(t-1))/86400,'HH:MM:SS')];
    
end

set(h, 'XTick', [newX(1):15*srate:newX(2) newX(2)], 'XTickLabel', tickStrs, 'XGrid', 'on','XMinorGrid','on','Gridlinestyle','-.','GridAlpha',0.5,'MinorGridAlpha',.75,'FontSize',7);
h.XAxis.MinorTickValues = [newX(1):1*srate:newX(2)];
set(gca, 'Ticklength', [0 0])

%% this section plot lights on and lights off lines

onT = etime(datevec(handles.stageData.lightsON), datevec(handles.stageData.recStart))*srate;
offT = etime(datevec(handles.stageData.lightsOFF), datevec(handles.stageData.recStart))*srate;
plot(h, [onT, onT], [0, maxY], 'r', 'LineWidth', 2);
plot(h, [offT, offT], [0, maxY], 'g', 'LineWidth', 2);

%% Plot any user defined draggable (rectangle) events
cmap = lines(256);
switch handles.plotEvents
    case 1
        if isfield(handles.stageData, 'rectEvents')
            % If any events present not in the standard list (e.g., detected
            % events), append the list
            LUT = eventLUT;
            
            if ~isempty(handles.stageData.rectEvents)
                handles.EventType.String = union( unique([handles.stageData.rectEvents(:,5)]), LUT(:,2));
                
                
                % Checks for events
                curRects = handles.stageData.rectEvents(or( and( [handles.stageData.rectEvents{:,2}].*handles.EEG.srate >= range(1), [handles.stageData.rectEvents{:,2}].*handles.EEG.srate <= range(end) ) , ...
                    and( [handles.stageData.rectEvents{:,3}].*handles.EEG.srate >= range(1), [handles.stageData.rectEvents{:,3}].*handles.EEG.srate <= range(end) ) ),:);
                
                
                %plots all the events in the current range
                for c  = 1:size(curRects, 1)
                    cval = find(strcmp(handles.EventType.String, curRects{c,5}));
                    if isempty(cval)
                        cval = length(handles.EventType.String)+1;
                    end
                    
                    r = rectangle(h, 'Position', [curRects{c,2}*handles.EEG.srate max(find(ismember(handles.CurrMontage.electrodes,curRects{c,1})))*150-75 curRects{c,3}*handles.EEG.srate-curRects{c,2}*handles.EEG.srate 150],'FaceColor', [cmap( cval, :) .2]);
                    if curRects{c,2}*handles.EEG.srate >= range(1)
                        t = text(h, curRects{c,2}*EEG.srate+.25 , max(find(ismember(handles.CurrMontage.electrodes,curRects{c,1})))*150-50 , curRects{c,5},'FontSize',8);
                    end
                end
                
                
            else
                handles.EventType.String = LUT(:,2);
            end
        end
end


%% PLOT  mid lines
l=plot(h, [median(range) median(range)], [0 maxY],  'Color', [0 0 0 .5], 'LineWidth', 1);
uistack(l, 'bottom');




