function writeStruct(structIn, outname)
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

fid = fopen(outname, 'w');


fieldsIn = fields(structIn);
for f = 1:length(fieldsIn)
    fwrite(fid, sprintf('%s\n', fieldsIn{f}));
    cur = eval(['structIn.', fieldsIn{f}]);
    
    if(ischar(cur))
        fwrite(fid, sprintf('%s\n', cur));
    elseif(iscell(cur))
        %skip
    else
        for i = 1:size(cur, 1)
            for j = 1:(size(cur, 2) - 1)
                fwrite(fid, sprintf('%.5f,', cur(i, j)));
            end
            fwrite(fid, sprintf('%.5f\n', cur(i, j + 1)));
        end;
    end
    
end

fclose(fid);









