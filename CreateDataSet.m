

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              %
%               High Pass Filter               %
%               Run Cleanline                  %
%               Downsample to 256              %
%               Add channel locs               %
%                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

%Pathname
pathname = '/home/folder/S';

%Number of subjects
NSubs = 1;



for ss = 1:NSubs
    
    %Load BDF
    % requires pop_bdfread at
    % http://home.uni-leipzig.de/biocog/content/widmann/eeglab-plugins/
    EEG = pop_bdfread('filename', 'Data.bdf', 'pathname', sprintf('%s%i/',pathname,ss));
    EEG = eeg_checkset( EEG );
    

    
    %Filter at 1 and 50 Hz
    EEG = pop_eegfiltnew(EEG, [], 1, 6760, true, [], 0);
    EEG = eeg_checkset( EEG );
   
    %cleanline
    EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:64] ,'computepower',1,'linefreqs',[60 120] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',0,'winsize',4,'winstep',4);
    
    %Resample to 256 Hz
    EEG = pop_resample(EEG, 256);
    EEG = eeg_checkset(EEG);
    
    %Assign Channel Locations
    EEG = pop_chanedit(EEG, 'load',{'/home/lawrence/Documents/Data/BC/EEG1/64_locations.ced' 'filetype' 'autodetect'},'lookup','/home/lawrence/Documents/MATLAB/eeglab13_0_1b/plugins/dipfit2.3/standard_BEM/elec/standard_1005.elc');
    EEG = pop_chanedit(EEG, 'eval','chans = pop_chancenter( chans, [],[]);');
    EEG = eeg_checkset( EEG );
    
    %Save
    EEG = pop_saveset( EEG,  'DataSet.set',  sprintf('%s%i/', pathname,ss),'filename', 'DataSet.set', 'savemode', 'onefile');
    EEG = eeg_checkset( EEG );
    
end

