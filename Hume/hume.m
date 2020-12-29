function hume
%   Húmë (formally sleepSMG) ? Open-source MATLAB Sleep Scoring Toolbox
%
%   User-feedback welcomed: jared_saletin@brown.edu
%
%   AUTHORSHIP:
%
%   Jared M. Saletin, PhD (1, 2) and Stephanie M. Greer, PhD (2) E-Mails:
%   jared_saletin@brown.edu , smgreer@gmail.com
%
%       (1) Department of Psychiatry and Human Behavior, Alpert Medical
%       School of Brown University
%
%       (2) Depeartment of Psychology / Helen Wills Neuroscience Institute,
%       University of California at Berkeley
%
%   Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
%
%   DESCRIPTION:
%
%   Húmë (formally sleepSMG) is an open-source MATLAB toolbox for
%   processing and analyzing polysomnographic sleep recordings including:
%   sleep staging, plotting, sleep statistics, data management, and event
%   marking routines. Húmë is open-source and licensed under version 3 of
%   the GNU Genral Public License (see below).
%
%   Húmë is deisnged to be compatable with, and makes extensive use of,
%   existing signal processing tools provided both in MATLAB and through
%   the EEGLAB toolbox (http://sccn.ucsd.edu/eeglab/). A working
%   distribution of EEGLAB is included with Húmë in accordance with the GNU
%   General Public License version 2 provided with EEGLAB. EEGLAB is
%   copyrighted to Arnaud Delorme and Scott Makeig, Salk Institute. The
%   original EEGLAB license is included with this software.
%
%   LICENSE AND USE:
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
% 
%   This program is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%   Húmë is intended for research purposes only. Any commercial or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%
version = '1.0.4';

sleepPath = which('hume');

[fpath] = fileparts(sleepPath);

fprintf(1,'\nInitializing Húmë Version %s\n',version);
addpath(fpath);
fprintf(1,'Loading: Montages\n');
addpath(genpath([fpath,'/montages']));
fprintf(1,'Loading: Functions\n');
addpath(genpath([fpath,'/coreFunctions']));
javaaddpath(([fpath,'/outsideToolboxes/dbDrivers/jtds-1/jtds-1.3.1.jar']));
javaaddpath(([fpath,'/outsideToolboxes/dbDrivers/sqlite-jdbc-3.30.1.jar']));
javaaddpath(([fpath,'/outsideToolboxes/dbDrivers/sqljdbc_8.2/mssql-jdbc-8.2.0.jre8.jar']));
fprintf(1,'Loading: User Interface\n');
addpath(genpath([fpath,'/gui']));

% Check for EEGLAB
if exist('eeglab.m','file')~=2
    fprintf(1,'\n!!! No EEGLAB detected, using included verison (2020_0) !!!\n');
    addpath(([fpath,'/outsideToolboxes/eeglab2020_0']));
    fprintf(1,'Loading: EEGLAB\n');  
    eeglab;
else
    fprintf(1,'Loading: EEGLAB\n');
    eeglab;
end

% Check for nansum

if exist('nansum.m') ~= 2
    
    fprintf(1,'\n!!! No internal nan functions; check Statistics Toolbox !!!\n');
    addpath([fpath,'/outsideToolboxes/misc/nansuite']);
    fprintf(1,'Loading: nan functions\n');

end

% Check for plotSpikeRaster

if exist('plotSpikeRaster.m') ~= 2
    
    addpath([fpath,'/outsideToolboxes/misc/plotSpikeRaster']);
    fprintf(1,'Loading: plotSpikeRaster functions\n');
   
end

sleepScoring;
