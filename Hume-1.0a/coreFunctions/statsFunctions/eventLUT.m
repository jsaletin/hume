function [LUT] = eventLUT

% EVENT LUT 
% [CODE]    LABEL
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
LUT = {
    '[0]'   'Artifact'
    '[1]'   'Movement Arousal'
    '[2]'   'Transient Arousal'
    '[3]'   'Microsleep'
    '[4]'   'Slow Eye Movsments'
    '[5]'   'Rapid Eye Movement'
    '[6]'   'Sleep Spindle'
    '[7]'   'K Complex'
    '[8]'   'Technologist Intervention'
    '[9]'   'Respiratory Event'
    '[A]'   'Apnea'
    '[B]'   'Obstructive Apnea'
    '[C]'   'Central Apnea'
    '[D]'   'Mixed Apnea'
    '[E]'   'Hypopnea'
    '[F]'   'SaO2 <90%'
    '[G]'   'SaO2 <80%'
    '[F]'   'PLM w/ Arousal'
    '[G]'   'PLM w/o Arousal'
    };

end
