
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              %
%             Reject Bad Trials                %
%                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%first clear the memory and the MATLAB workspace

clc;
clear;


subject = {'S1' 'S2'}; %creates a variable called subject which can be a list of files

%User's paths. Be sure to set them 

pathname_read  = '/home/filename/';
pathname_write = '/home/filname/';
nsubj = length(subject); %number of subjects

for s=1:nsubj
    
    sname = [pathname_read subject{s} '/DataSetName.set'];
    
    if exist(sname, 'file')>0
        
        fprintf('Processing Subject #%g : %s\n', s, subject{s})
        
        EEG = pop_loadset(sname);
        EEG = eeg_checkset( EEG );
        
        EEG = pop_autorej(EEG, 'nogui','on','threshold',500,'eegplot','off');
        EEG = eeg_checkset( EEG );
        EEG = pop_rejepoch( EEG, find(EEG.reject.rejglobal), 0);
        
        EEG = pop_jointprob(EEG,1,6,2,0,1);
        
        EEG = pop_saveset(EEG, 'filename', [subject{s} '/DataSetSave.set'], 'filepath', pathname_write);
        EEG = eeg_checkset(EEG);
        
    else fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        
    end
    
    
    
end

