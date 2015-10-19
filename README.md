# MATLAB
MATLAB code for EEG analysis

CreateDataSet.m
Loads the raw .bdf files.
In order to run, you will need to download the pop_bdfread file from
http://home.uni-leipzig.de/biocog/content/widmann/eeglab-plugins/

This is designed to batch process your data
It will convert .bdf to .set format
High and low-pass filter the data at 1 and 50 Hz
Run Cleanline (which is an EEGLab plug in you will need to download)
Downsample to 250 Hz
And assign channel loactions

Things you will need to modify:
Line 18: Set the folder path to where you are storing and saving the data

Line 21: Set the number of subjects you want to analyze 

Line 30: Set the name of your .bdf files

Line 52: Set the name of your save file

Throughout each .m file, you'll need to change these parameters

###############################################################

RemoveBadChannles.m
Runs the Clean Raw Data function

###############################################################

EpochData.m
Epochs your data

In line 35, you'll need to define the trigger you want to epoch around, as well as the time frame

###############################################################

RejectBadTrials.m
Rejects bad trials using the EEGLab recommendations

The code stores bad trials and automatically rejects them according to the thresholds

###############################################################

Ref_and_RemoveCZ.m
Re-references to the average of all electrodes
Removes CZ prior to running ICA

###############################################################

ICA.m
Runs ICA

Be mindful of epoch triggers and filenames
Also, change to reflect the time of your epochs in line 32
