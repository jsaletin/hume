function Reliability(primaryScorer,secondaryScorer,outPath,outName)
% Reliability(primaryScorer,secondaryScorer,outPath,outName)
%
% Computes Reliability Agreement between two scorers (Scorer 1 and Scorer
% 2). Takes as input the filenames of two stage statistics output folders.
%
% Computes agreement as well as cohen's kappa for both stages 3 and 4
% separated as well as collapsed
%
% Results printed to the command prompt as well to an html file named
% according to the outName parameter (default: 'Reliability.html')
%
%   Inputs (required):
%       
%       primaryScorer - stage statistics folder for primary scorer.
%
%       secondaryScorer - stage statistics folder for secondary scorer
% 
%   Inputs (optional):
%
%       outPath ? where to place output (default is present working
%       directory)
%
%       outName - filename to save the output as (defailt is "Reliability")
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


if nargin<3
    
    outpath = pwd;
    outName = 'Reliability';
    
elseif nargin<4
    outName = 'Reliability';
end


% load data
if(ischar(primaryScorer))
    file = dir([primaryScorer,'/*_stats.mat']);    
    load([primaryScorer,'/',file.name]);
    stages1 = stageStats.TDTstages;
    stageData1 = stageStats.stageData;
    latencies1 = stageStats.SleepLat(:,2);
    remPeriods1 = size(stageStats.REMperiodStats,2);
    remSegs1 = sum(stageStats.REMperiodStats(10,:));
    LOn1 = stageStats.lightsON;
    LOut1 = stageStats.lightsOUT;
    firstEp1 = min(find(stageStats.stageData.stages~=7));
    lastEp1 = max(find(stageStats.stageData.stages~=7));
    if isfield(stageStats,'fileName')
        
        fName1 = stageStats.fileName;
        
    else
        
        fName1 = stats1;
    end
    
    if isfield(stageStats,'events')   
        events1 = stageStats.events;
    else   
        events1 = [];
    end
    
else
    stages1 = stats1.stageData.TDTstages;
    stageData1 = stats1.stageData;
    latencies1 = stats1.SleepLat(:,2);
    remPeriods1 = size(stats1.REMperiodStats,2);
    remSegs1 = sum(stats1.REMperiodStats(10,:));
    LOn1 = stats1.lightsON;
    LOut1 = stats1.lightsOUT;
    firstEp1 = min(find(stats1.stageData.stages~=7));
    lastEp1 = max(find(stats1.stageData.stages~=7));
    if isfield(stageStats,'fileName')
        
        fName1 = stats1.fileName;
        
    else
        
        fName1 = inputname(1);
    end
    
    if isfield(stageStats,'events')
        events1 = stats1.events;
    else
        events1 = [];
    end
end
if(ischar(secondaryScorer))
    file = dir([secondaryScorer,'/*_stats.mat']);    
    load([secondaryScorer,'/',file.name]);
    stages2 = stageStats.TDTstages;
    stageData2 = stageStats.stageData;
    latencies2 = stageStats.SleepLat(:,2);
    remPeriods2 = size(stageStats.REMperiodStats,2);
    remSegs2 = sum(stageStats.REMperiodStats(10,:));
      LOn2 = stageStats.lightsON;
    LOut2 = stageStats.lightsOUT;
    
    firstEp2 = min(find(stageStats.stageData.stages~=7));
    lastEp2 = max(find(stageStats.stageData.stages~=7));
        if isfield(stageStats,'fileName')
        
        fName2 = stageStats.fileName;
        
    else
        
        fName2 = stats1;
        end
    
        if ~isempty(events1)
                if isfield(stageStats,'events')   
                events2 = stageStats.events;
                else   
               events2 = [];
                end
                
        end
else
    stages2 = stats2.stageData.TDTstages;
    stageData2 = stats2.stageData;
    latencies2 = stats2.SleepLat(:,2);
    remPeriods2 = size(stats2.REMperiodStats,2);
    remSegs2 = sum(stats2.REMperiodStats(10,:));
      LOn2 = stats2.lightsON;
    LOut2 = stats2.lightsOUT;  
    
    firstEp1 = min(find(stats2.stageData.stages~=7));
    lastEp1 = max(find(stats2.stageData.stages~=7));
        if isfield(stageStats,'fileName')
        
        fName2 = stats2.fileName;
        
    else
        
        fName2 = inputname(1);
        end
    
        if ~isempty(events1)
            if isfield(stageStats,'events')
                events2 = stats2.events;
            else
                events2 = [];
            end
            
        end
end


% trim off non-scored epochs

if length(stages1) ~= length(stages2)
    
    error('Reliability:WrongLength',sprintf('Scored Files are different lengths \n\nPlease confirm Lights OUT/ON and run again\n\nScorer 1:\n\tLights Out: %s\n\tLights On: %s\n\nScorer 2:\n\tLights Out: %s\n\tLights On: %s',LOut1,LOn1,LOut2,LOn2));

elseif or(firstEp1~=firstEp2,lastEp1~=lastEp1)
    
    error('Reliability:WrongLndMrk',sprintf('Scored Files have different landmarks \n\nPlease confirm First and Last Scored Epochs and run again\n\nScorer 1:\n\tFirst Epoch: %d\n\tLast Epoch: %d\n\nScorer 2:\n\tFirst Epoch: %d\n\tLast Epoch: %d',firstEp1,lastEp1,firstEp2,lastEp1));
end

%stages1 = stages1(trim1(1):trim1(end));
%stages2 = stages2(trim2(1):trim2(end));

%size(stages1)
% size(stages2)

% tabulate agreement
table = zeros(8, 8);

for t = 0:7
    
    for t2 = 0:7
        table(t+1, t2+1) = sum(stages2 == t & stages1 == t2);
      
    end
    
end

[k agreement] = kappaCalc(table);

% same stats with 3 and 4 collapsed

% EDITS (JMS) 1/4/12 -- FIXED BUG WHEREAS REM WASNT COUNTED IN CODE WHEN
% MATRIX WAS CREATED. ALL SW RECODED AS 3, REM as 4, MT as 5. STAGES NOW
% RUN 0 - 5.
stages1_SW = stages1;
stages1_SW(find(stages1_SW==4))=3;
stages1_SW(find(stages1_SW==5))=4;
stages1_SW(find(stages1_SW==6))=5;
stages1_SW(find(stages1_SW==7))=6;
stages2_SW = stages2;
stages2_SW(find(stages2_SW==4))=3;
stages2_SW(find(stages2_SW==5))=4;
stages2_SW(find(stages2_SW==6))=5;
stages2_SW(find(stages2_SW==7))=6;

tableSW = zeros(7, 7);

for t = 0:6
    
    for t2 = 0:6
        tableSW(t+1, t2+1) = sum(stages2_SW == t & stages1_SW == t2);
      
    end
    
end

[kSW agreementSW] = kappaCalc(tableSW);

% Create Reliability Struct

Reliability.SWSeparated.AgreementTable = [[table;sum(table,1)] [sum(table(1,:));[sum(table(2,:));sum(table(3,:));sum(table(4,:));sum(table(5,:));sum(table(6,:));sum(table(7,:));sum(table(8,:))]; sum(sum(table))]];
Reliability.SWSeparated.PercentAgreements = [(diag(table)'./sum(table,1)).*100 sum(diag(table))'./sum(sum(table))*100];
Reliability.SWSeparated.Kappa = k;
Reliability.SWSeparated.Agreement = agreement;
ReliabilitySep = diag(table);
for i = 1:length(ReliabilitySep)
Reliability.SWSeparated.ReliabilityStat(i) = 200 * ReliabilitySep(i) / (Reliability.SWSeparated.AgreementTable(i,9) + Reliability.SWSeparated.AgreementTable(9,i));
end

Reliability.SWCollapsed.AgreementTable = [[tableSW;sum(tableSW,1)] [sum(tableSW(1,:));[sum(tableSW(2,:));sum(tableSW(3,:));sum(tableSW(4,:));sum(tableSW(5,:));sum(tableSW(6,:));sum(table(7,:))]; sum(sum(tableSW))]];
Reliability.SWCollapsed.PercentAgreements = [(diag(tableSW)'./sum(tableSW,1)).*100 sum(diag(tableSW))'./sum(sum(tableSW))*100];
Reliability.SWCollapsed.Kappa = kSW;
Reliability.SWCollapsed.Agreement = agreementSW;
ReliabilityComb = diag(tableSW);
for i = 1:length(ReliabilityComb)
Reliability.SWCollapsed.ReliabilityStat(i) = 200 * ReliabilityComb(i) / (Reliability.SWCollapsed.AgreementTable(i,8) + Reliability.SWCollapsed.AgreementTable(8,i));
end

% print same results to html file

report = '<html>';

    report = [report,   sprintf('<head><title>Reliability Report: %s</title></head>',outName)];
    report = [report, sprintf('<body><h1 align="center">*** Reliability Report***</h1>\n')];


report = [report, sprintf('<h3 align="center">Generated on: %s<h3>\n', date)];

report = [report,sprintf('<hr><h3>Scorer File 1: %s</h2>\n',fName1)];
report = [report,sprintf('<h3>Scorer File 2: %s</h2>\n',fName2)];
report = [report, '<hr>'];

report = [report,sprintf('<h2>Epoch Agreement (SW SEPARATED)</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>Scorer 2 \\ Scorer 1</b></td><td><td><td><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>S3</b></td><td><td><td><b>S4</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></td><td><td><td><b>TOTAL</b></tr>\n')];
report = [report,sprintf('<tr><td><b>W:</b><td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(1,:),sum(table(1,:)))];
report = [report,sprintf('<tr><td><b>S1:</b><td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(2,:),sum(table(2,:)))];
report = [report,sprintf('<tr><td><b>S2:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(3,:),sum(table(3,:)))];
report = [report,sprintf('<tr><td><b>S3:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(4,:),sum(table(4,:)))];
report = [report,sprintf('<tr><td><b>S4:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(5,:),sum(table(5,:)))];
report = [report,sprintf('<tr><td><b>REM:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(6,:),sum(table(6,:)))];
report = [report,sprintf('<tr><td><b>MT:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',table(7,:),sum(table(7,:)))];
report = [report,sprintf('<tr><td><b>ANOM:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></tr>\n',table(8,:),sum(table(8,:)))];
report = [report,sprintf('<tr><td><b>TOTAL:</b><td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></tr>\n',sum(table,1),sum(sum(table)))];
report = [report, '</table>'];
report = [report,sprintf('<h2>Percent Agreement of Scorer 2 with Scorer 1</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>S3</b></td><td><td><td><b>S4</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></td><td><td><td><b>TOTAL</b></tr>\n')];
report = [report,sprintf('<tr><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</tr>\n',(diag(table)'./sum(table,1)).*100,sum(diag(table))'./sum(sum(table))*100)];
report = [report,'</table>'];
report = [report,sprintf('<h2>Reliability of Scorers [200 * #AgreedEpochs / (rowTotal + ColumnTotal)]</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>S3</b></td><td><td><td><b>S4</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></tr>\n')];
report = [report,sprintf('<tr><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</tr>\n',Reliability.SWSeparated.ReliabilityStat)];
report = [report,'</table>'];
report = [report,sprintf('<br><b>%s</b><br>\n',agreement)];

% plotHypnogram_comp(stageData1, stageData2, 1); % SW SEPARATED - TYPE 1 - JMS 7/30/14
% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, [outName, '_CompHyp1.png'], 'png');
% close(gcf);
% report = [report, sprintf('<h3>Comparison Hypnogram (SW SEPARATED):</h3><img src=''%s''>', [outName, '_CompHyp1.png'])]; 
report = [report, '<br><hr>'];

report = [report, sprintf('<h2>Epoch Agreement (SW COLLAPSED)</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>Scorer 2 \\ Scorer 1</b></td><td><td><td><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>SW</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></td><td><td><td><b>TOTAL</b></tr>\n')];
report = [report,sprintf('<tr><td><b>W:</b><td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(1,:),sum(tableSW(1,:)))];
report = [report,sprintf('<tr><td><b>S1:</b><td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(2,:),sum(tableSW(2,:)))];
report = [report,sprintf('<tr><td><b>S2:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(3,:),sum(tableSW(3,:)))];
report = [report,sprintf('<tr><td><b>SW:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(4,:),sum(tableSW(4,:)))];
report = [report,sprintf('<tr><td><b>REM:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(5,:),sum(tableSW(5,:)))];
report = [report,sprintf('<tr><td><b>MT:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td>%d</td><td><td><td><b>%d</b></tr>\n',tableSW(6,:),sum(tableSW(6,:)))];
report = [report,sprintf('<tr><td><b>ANOM:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></tr>\n',tableSW(7,:),sum(tableSW(7,:)))];
report = [report,sprintf('<tr><td><b>TOTAL:</b><td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></td><td><td><td><b>%d</b></tr>\n',sum(tableSW,1),sum(sum(tableSW)))];
report = [report, '</table>'];
report = [report,sprintf('<h2>Percent Agreement of Scorer 2 with Scorer 1</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>SW</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></td><td><td><td><b>TOTAL</b></tr>\n')];
report = [report,sprintf('<tr><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</tr>\n',(diag(tableSW)'./sum(tableSW,1)).*100,sum(diag(tableSW))'./sum(sum(tableSW))*100)];
report = [report,'</table>'];
report = [report,sprintf('<h2>Reliability of Scorers [200 * #AgreedEpochs / (rowTotal + ColumnTotal)]</h2>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><b>W</b></td><td><td><td><b>S1</b></td><td><td><td><b>S2</b></td><td><td><td><b>SW</b></td><td><td><td><b>REM</b></td><td><td><td><b>MT</b></td><td><td><td><b>ANOM</b></tr>\n')];
report = [report,sprintf('<tr><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</td><td><td><td>%.2f%%</tr>\n',Reliability.SWCollapsed.ReliabilityStat)];
report = [report,'</table>'];
report = [report,sprintf('<br><b>Cohen''s &kappa; </b>= %.2f<br>',kSW)];
report = [report,sprintf('<br><b>%s</b><br><br>\n',agreementSW)];

% plotHypnogram_comp(stageData1, stageData2, 2); 
% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, [outName, '_CompHyp1.png'], 'png');
% close(gcf);
% report = [report, sprintf('<h3>Comparison Hypnogram (SW COLLAPSED):</h3><img src=''%s''>', [outName, '_CompHyp1.png'])]; 
report = [report, '<br><hr>'];

LatMat = [latencies1 latencies2 latencies2-latencies1];
report = [report, sprintf('<h1>Latency Reliability</h1>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><td><td><td><b>Scorer 1</b></td><td><td><td><b>Scorer 2</b></td><td><td><td><b>Minutes Difference</b></tr>\n')];
report = [report,sprintf('<tr><td><b>LO to SO:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(1,:))];
report = [report,sprintf('<tr><td><b>LO to 10 min sleep:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(2,:))];
report = [report,sprintf('<tr><td><b>LO to St 1:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(3,:))];
report = [report,sprintf('<tr><td><b>LO to St 2:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(4,:))];
report = [report,sprintf('<tr><td><b>LO to St 3:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(5,:))];
report = [report,sprintf('<tr><td><b>LO to St 4:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(6,:))];
report = [report,sprintf('<tr><td><b>LO to SW:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(7,:))];
report = [report,sprintf('<tr><td><b>LO to REM:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(8,:))];
report = [report,sprintf('<tr><td><b>LO to ANOM:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(9,:))];
report = [report,sprintf('<tr><td><b>SO to St 1:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(10,:))];
report = [report,sprintf('<tr><td><b>SO to St 2:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(11,:))];
report = [report,sprintf('<tr><td><b>SO to St 3:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(12,:))];
report = [report,sprintf('<tr><td><b>SO to St 4:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(13,:))];
report = [report,sprintf('<tr><td><b>SO to SW:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(14,:))];
report = [report,sprintf('<tr><td><b>SO to REM:</b><td><td><td>%.1f</td><td><td><td>%.1f</td><td><td><td>%.1f</td></tr>\n',LatMat(15,:))];
report = [report,'</table>'];
report = [report, '<br><hr>'];

REMperMat = [remPeriods1 remPeriods2 remPeriods2-remPeriods1];

report = [report, sprintf('<h1>REM Reliability</h1>\n')];
report = [report,sprintf('<table cellpadding="5">\n<tr><td><td><td><td><td><b>Scorer 1</b></td><td><td><td><b>Scorer 2</b></td><td><td><td><b>Difference</b></tr>\n')];
report = [report,sprintf('<tr><td><b>REM Periods:</b><td><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%d</td></tr>\n',REMperMat)];
report = [report,'</table>'];

REMsegMat = [remSegs1 remSegs2 ((remSegs2-remSegs1)/remSegs1)*100];

report = [report,sprintf('<table cellpadding="5">\n<tr><td><td><td><td><b>Scorer 1</b></td><td><td><td><b>Scorer 2</b></td><td><td><td><b>Percent Difference</b></tr>\n')];
report = [report,sprintf('<tr><td><b>REM Segments:</b><td><td><td>%d</td><td><td><td>%d</td><td><td><td>%.1f</td></tr>\n',REMsegMat)];
report = [report,'</table>'];
report = [report, '<br><hr>'];

report = [report, sprintf('<h1>Event Reliability (SCORER 2 - SCORER 1)</h1>\n')];

if ~isempty(events1)
    if ~isempty(events2)
        
        eFields = {events1{:,1}};            
        eFields2 = {events2{:,1}};

        
        evREL = [];

        report = [report, sprintf('<h2>Absolute Difference</h2>\n')];

        report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td><b>Wake</b></td><td><b>MT</b></td><td><b>NREM</b></td><td><b>REM</b></td><td><b>TST</b></td></tr>\n')];
        
        for i=1:length(eFields)
            
            ev1 = events1{i,2};
            
            
            if sum(ismember(eFields2,eFields{i}))>0
                
                ev2 = events2{ismember(eFields2,eFields{i}),2};

                evREL=[ev2-ev1];
                
            else
                
                evREL=[NaN NaN NaN NaN NaN];
                
            end
            
            report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%d</td><td>%d</td><td>%d</td><td>%d</td></tr>\n', [eFields{i},':'], evREL)];
            Reliability.eventsABS{1,1} = eFields{i};
            Reliabiltiy.eventsABS{1,2} = evREL;
            
        end
        report = [report,'</table>'];
        
        report = [report, sprintf('<h2>Percent Difference</h2>\n')];

        report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td><b>Wake</b></td><td><b>MT</b></td><td><b>NREM</b></td><td><b>REM</b></td><td><b>TST</b></td></tr>\n')];
        
        for i=1:length(eFields)
            
            ev1 = events1{i,2};

            if sum(ismember(eFields2,eFields{i}))>0
                
                ev2 = events2{ismember(eFields2,eFields{i}),2};

                evREL=[((ev2-ev1)./ev1).*100];
                
            else
                
                evREL=[NaN NaN NaN NaN NaN];
                
            end
            
            report = [report, sprintf('<tr><td><b>%s</b></td><td>%.1f</td><td>%.1f</td><td>%.1f</td><td>%.1f</td><td>%.1f</td></tr>\n', [eFields{i},':'], evREL)];
           Reliability.eventsPER{1,1} = eFields{i};
            Reliabiltiy.eventsPER{1,2} = evREL;        end
        report = [report,'</table>'];
        
        report = [report, sprintf('<br>Note: NaNs Indicate Event Marked by Scorer 1 and not by Scorer 2\n')];

report = [report, '<br><hr>'];

    else
        report = [report, sprintf('<br>!!! PRIMARY SCORER MARKED EVENTS, SECONDARY SCORER DID NOT, CHECK FILE !!!\n')];
    end

    
mkdir([outPath,'/',outName]);

fid = fopen([outPath,'/',outName,'/',outName,'.html'], 'w');
fwrite(fid, report);

web([outPath,'/',outName,'/',outName,'.html']);

% Create Reliability Struct
eval(['save ''',[outPath,'/',outName,'/',outName],''' Reliability;']);
end
end

function [k agreement] = kappaCalc(table)

% observed agreement
Po = sum(diag(table))./sum(sum(table)); 
Pe = 0;
for x = 1:size(table,1)
    % calculate expected agreement if at chance
    Pe = Pe + sum(table(x,:))/sum(sum(table))*sum(table(:,x))/sum(sum(table)); 
end
% calculate cohen's kappa
k = (Po-Pe)/(1-Pe); 

% interpret kappa according to conventions *approximate*
if k < 0  
    agreement = 'No Agreement';
elseif k >=0 && k <= .20    
    agreement = 'Slight Agreement';
elseif k > .20 && k <= .40  
    agreement = 'Fair Agreement';    
elseif k > .40 && k <= .60    
    agreement = 'Moderate Agreement';    
elseif k > .60 && k <= .80    
    agreement = 'Substantial Agreement';    
elseif k > .80 && k < 1    
    agreement = 'Near Perfect Agreement';    
elseif k >= 1    
    agreement = 'Perfect Agreement';    
end
    
end