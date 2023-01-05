% EXPORT STIM - NIMH MonkeyLogic - Vision Lab, IISc
% ----------------------------------------------------------------------------------------
% This function exports saved stimuli from .bhv2 file, if not stored, throws warning.
%
% INPUTS
%   bhvFileFullPath   - full path of .bhv2 file
%
% OUTPUT
%   exptImages        - images used in experiment, which are stored in .bhv2 file.
%
% VERSION HISTORY
% 17-Dec-2022 - Arun   - First Implementation
% 05-Jan-2023 - Thomas - Earlier code was part of wmLib, now transferred to mlLib
% ----------------------------------------------------------------------------------------

function exptImages = ml_exportStim(bhvFileFullPath)

% READ the file
[~,mlConfig,~] = mlread(bhvFileFullPath);

if mlConfig.SaveStimuli == 1 % Read stimuli only if they were stored by ML    
    % MAKE a temporary folder to store stimuli
    exptImages     = [];
    if(~isfolder('zztemp'))
        mkdir('zztemp')
    end    
    
    % USE the MonkeyLogic function to export to the temo folder
    mlexportstim('zztemp',bhvFileFullPath);
    files = dir('zztemp\'); 
    count = 1;
    for stimid = 3:length(files)
        if(strcmp(files(stimid).name(end-2:end), 'wav') ~= 1)
            % SAVE all stimuli except the correct and incorrect tones (which are in .wav)
            exptImages{count,1} = imread(['zztemp\' files(stimid).name]);
            count               = count+1;
        end
        delete(['zztemp\' files(stimid).name]);
    end
    rmdir('zztemp');
else
    fprintf('WARNING! Stimulus images not stored in BHV file \n');
end
end
