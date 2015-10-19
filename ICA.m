
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              %
%                     ICA                      %
%                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

%settings that will change for each subject

%User's paths. Be sure to set them 

filepath  = '/home/filename/';

NSubs = 1;

Epoch_trigger = {'1'};
alleeg_filename = 'DataSetName.set';
alleeg_epoch_filename = 'DataSetICAEpochs.set';
ica_filename = 'DataSetSaveICA.set';


for ss = 3:NSubs
    
    EEG_ALL = pop_loadset( 'filename', alleeg_filename, 'filepath', sprintf('%s%i/',filepath,ss));
    EEG_ALL = eeg_checkset( EEG_ALL );
    
    EEG = pop_epoch( EEG_ALL, Epoch_trigger, [-1 1.996], 'newname','All Epochs', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    
    EEG = pop_saveset( EEG,  'filename',alleeg_epoch_filename, 'filepath', sprintf('%s%i/',filepath,ss));
    EEG = eeg_checkset( EEG );
    
    EEG = pop_runica(EEG, 'extended', 1);
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG,  'filename', ica_filename, 'filepath',sprintf('%s%i/',filepath,ss));
    EEG = eeg_checkset( EEG );
    
    clear EEG
end
clear eeg

