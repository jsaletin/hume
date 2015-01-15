function EEGout = fixData(EEG, missingEpochs, winsize)
%EEGout = fixData(EEG, missingEpochs)
%
% This function inserts 0's to fill sections of missing data in the EEG
% struct (e.g. for a Restroom Trip/Power Failure).
%
%   Inputs (Required):
%
%       EEG ? EEGLAB EEG Struct for Data
%
%       missingEpochs ? Vector of missing epochs
%
%   Inputs (Optional):
%
%       winsize ? epoch length in seconds (defualt: 30 seconds)
%
%   Outputs:
%
%       EEGout - Corrected EEGLAB EEG struct.

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
if(nargin < 3)
    winsize = 30;
end

blankEpoch = zeros(size(EEG.data, 1), winsize*EEG.srate);
missingEpochs = sort(missingEpochs) - 1;

newData = EEG.data;

for e = 1:length(missingEpochs)
   epochSt = (missingEpochs(e)*winsize*EEG.srate) + 1;
   newData = [newData(:, 1:(epochSt - 1)), blankEpoch, newData(:, epochSt:end)];
end


EEGout = EEG;
EEGout.data = newData;

EEGout.pnts = size(EEGout.data,2);

