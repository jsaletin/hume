function plotHypnogram(stageData, cycleBounds, type)
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
winSize = stageData.win;
srate = stageData.srate;

%Plot in Hours
stageData.stageTime = stageData.stageTime./60;
onT = etime(datevec(stageData.lightsON), datevec(stageData.recStart))./60./60;
offT = etime(datevec(stageData.lightsOFF), datevec(stageData.recStart))./60./60;

if nargin < 3
    type = 1;
end

if type == 2
stageData.stages(stageData.stages == 4) = 3;
stageData.stages(stageData.stages == 5) = 4;
stageData.stages(stageData.stages == 6) = 5;
stageData.stages(stageData.stages == 7) = 6;
end


if type == 1

figure('Position', [100, 700, 550, 144]);

% for c = 1:size(cycleBounds, 1)
%     xNREM = stageData.stageTime(cycleBounds(c, 1)) + offT;
%     if(cycleBounds(c, 2) == 0)
%         xREM = 0;
%         wNREM = stageData.stageTime(cycleBounds(c, 3)) - stageData.stageTime(cycleBounds(c, 1));
%         wREM = 0;
%     else
%         xREM = stageData.stageTime(cycleBounds(c, 2)) + offT;
%         wNREM = stageData.stageTime(cycleBounds(c, 2)) - stageData.stageTime(cycleBounds(c, 1));
%         wREM = stageData.stageTime(cycleBounds(c, 3)) - stageData.stageTime(cycleBounds(c, 2));
%         rectangle('Position', [xREM, 0, wREM, 8], 'FaceColor', [242, 180, 198]./255, 'LineStyle', 'none')
%         hold on
%     end
%     rectangle('Position', [xNREM, 0, wNREM, 8], 'FaceColor', [.85 .85 .9], 'LineStyle', 'none')
% end

plot([onT, onT], [0, 9], 'r', 'LineWidth', 1);
hold;
plot([offT, offT], [0, 9], 'g', 'LineWidth', 1);
plot(onT,9,'k^','MarkerSize',8,'MarkerFaceColor','r');
plot(offT,9,'kv','MarkerSize',8,'MarkerFaceColor','g');

% plotmap = [7 4 3 2 1 5 6 0]+1;
% stageColors = [0 0 0; 102 255 255; 0 158 225; 102 102 255; 128 0 255; 255 0 0; 100 100 100; 0 0 0]./255;
%stageNames = {'wake'; 'stage1'; 'stage2'; 'stage3'; 'stage4'; 'rem'; 'mt'};

plotmap = [6 5 4 3 2 1 7 0]+1;
stageColors = [100 100 100; 102 255 255; 0 158 225; 102 102 255; 128 0 255; 255 0 0; 0 0 0; 0 0 0]./255;
%stageNames = {'wake'; 'stage1'; 'stage2'; 'stage3'; 'stage4'; 'rem'; 'mt'};

stageRaster = NaN(8,length(stageData.stages));

for i = 1:8;
    curInds = find(stageData.stages == i-1);
    stageRaster(plotmap(i),curInds)=1;
        connectData(curInds) = plotmap(i)+.5;

end
%stageRaster=flipud(stageRaster);

for i=1:size(stageRaster,1)
    sT = stageData.stageTime(find(~isnan(stageRaster(i,:))));
    
    for e = 1:size(sT,2)
        sTE = sT(e);

        if sTE>=(stageData.stageTime(min(find(stageData.stages<7)))) && sTE<=(stageData.stageTime(max(find(stageData.stages<7))))
            plot([sTE, sTE], [.5+((i)-1), 1.5+((i)-1)], 'Color', stageColors(plotmap(i), :), 'LineWidth', .2);
        end
    end
end


% tmp = find(stageData.stages ~= 7);
% xticks = [stageData.stageTime(1), stageData.stageTime(tmp(1)), stageData.stageTime(tmp(end))];
% xlabels = {datestr(stageData.recStart, 'HH:MM'), datestr(stageData.lightsOFF,'HH:MM'), datestr(stageData.lightsON, 'HH:MM')};

 connector = NaN(length(connectData),1);
 connector(min(find(stageData.stages<7)):max(find(stageData.stages<7))) = connectData(min(find(stageData.stages<7)):max(find(stageData.stages<7)));
 plot(stageData.stageTime, connector, 'k','LineWidth',.2);
%plot(stageData.stageTime, connectData-.5, 'k','LineWidth',.2);

%set(gca, 'Xlim', stageData.stageTime([1, end]),'XTick', xticks,'XTickLabel', xlabels,'Ylim', [0, 7],'YTick', 0:7,'YTickLabel', {'ANOM.'; 'REM'; 'Stage4'; 'Stage3'; 'Stage2'; 'Stage1'; 'MT'; 'Wake'; ''})
set(gca, 'Xlim', stageData.stageTime([1, end]),'Ylim', [0, 9],'YTick', [1:8],'YTickLabel', [{'ANOM'; 'REM'; 'Stage4'; 'Stage3'; 'Stage2'; 'Stage1'; 'WAKE'; 'MT'; ''}]);
set(gca,'TickDir','out');
set(gca,'box','off')

xlabel('Hours');



elseif type == 2
    


    figure('Position', [100, 700, 550, 128]);

% for c = 1:size(cycleBounds, 1)
%     xNREM = stageData.stageTime(cycleBounds(c, 1)) + offT;
%     if(cycleBounds(c, 2) == 0)
%         xREM = 0;
%         wNREM = stageData.stageTime(cycleBounds(c, 3)) - stageData.stageTime(cycleBounds(c, 1));
%         wREM = 0;
%     else
%         xREM = stageData.stageTime(cycleBounds(c, 2)) + offT;
%         wNREM = stageData.stageTime(cycleBounds(c, 2)) - stageData.stageTime(cycleBounds(c, 1));
%         wREM = stageData.stageTime(cycleBounds(c, 3)) - stageData.stageTime(cycleBounds(c, 2));
%         rectangle('Position', [xREM, 0, wREM, 7], 'FaceColor', [242, 180, 198]./255, 'LineStyle', 'none')
%         hold on
%     end
%     rectangle('Position', [xNREM, 0, wNREM, 7], 'FaceColor', [.85 .85 .9], 'LineStyle', 'none')
% end

plot([onT, onT], [0, 8], 'r', 'LineWidth', 1);
hold;
plot([offT, offT], [0, 8], 'g', 'LineWidth', 1);
plot(onT,8,'k^','MarkerSize',8,'MarkerFaceColor','r');
plot(offT,8,'kv','MarkerSize',8,'MarkerFaceColor','g');

% plotmap = [7 4 3 2 1 5 6 0];
% stageColors = [0 0 0; 102 255 255; 0 158 225; 102 102 255; 128 0 255; 255 0 0; 100 100 100; 0 0 0]./255;
% %stageNames = {'wake'; 'stage1'; 'stage2'; 'stage3'; 'stage4'; 'rem'; 'mt'};

plotmap = [5 4 3 2 1 6 0]+1;
stageColors = [100 100 100; 102 255 255; 0 158 225; 128 0 255; 255 0 0; 200 200 200; 0 0 0]./255;
%stageNames = {'wake'; 'stage1'; 'stage2'; 'stage3'; 'stage4'; 'rem'; 'mt'};

stageRaster = NaN(7,length(stageData.stages));

for i = 1:7;
    curInds = find(stageData.stages == i-1);
    stageRaster(plotmap(i),curInds)=1;
    
    connectData(curInds) = plotmap(i)+.5;
end
%stageRaster=flipud(stageRaster);

for i=1:size(stageRaster,1)
    sT = stageData.stageTime(find(~isnan(stageRaster(i,:))));
    
    for e = 1:size(sT,2)
        sTE = sT(e);
        
        if sTE>=(stageData.stageTime(min(find(stageData.stages<6)))) && sTE<=(stageData.stageTime(max(find(stageData.stages<6))))
            plot([sTE, sTE], [.5+((i)-1), 1.5+((i)-1)], 'Color', stageColors(plotmap(i), :), 'LineWidth', .1);
        end
    end
end

% tmp = find(stageData.stages ~= 6);
% xticks = [stageData.stageTime(1), stageData.stageTime(tmp(1)), stageData.stageTime(tmp(end))];
% xlabels = {datestr(stageData.recStart, 'HH:MM'), datestr(stageData.lightsOFF,'HH:MM'), datestr(stageData.lightsON, 'HH:MM')};

 connector = NaN(length(connectData),1);
 connector(min(find(stageData.stages<6)):max(find(stageData.stages<6))) = connectData(min(find(stageData.stages<6)):max(find(stageData.stages<6)));

plot(stageData.stageTime, connector, 'k','LineWidth',.2);

% PLOT EVENTS


%set(gca, 'Xlim', stageData.stageTime([1, end]),'XTick', xticks,'XTickLabel', xlabels,'Ylim', [0, 6],'YTick', 0:6,'YTickLabel', {'ANOM.'; 'REM'; 'SWS'; 'Stage2'; 'Stage1'; 'MT'; 'Wake'; ''})
set(gca, 'Xlim', stageData.stageTime([1, end]),'Ylim', [0, 8],'YTick', [1:7],'YTickLabel', [{'ANOM'; 'REM'; 'SW'; 'Stage2'; 'Stage1'; 'Wake'; 'MT'; ''}]);
set(gca,'TickDir','out');
set(gca,'box','off')

xlabel('Hours');
end
    
    









