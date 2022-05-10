This is supplementary file to PLoS One article: "Real-time estimation of horizontal gaze angle by saccade integration using in-ear electro-oculography"..

Authors:

Lubos Hladek
Bernd Porr
Owen Brimijoin

Corresponding author:

Lubos Hladek 
hladek@gmail.com
lubos.hladek@nottingham.ac.uk

Requirements:

MATLAB (tested with version 9.0.0.341360 (R2016a))
(optional) OPTI toolbox (see: https://inverseproblem.co.nz/OPTI/) (download from: https://github.com/jonathancurrie/OPTI) and L-BFGS-B solver (https://inverseproblem.co.nz/OPTI/index.php/Solvers/L-BFGS-B).
(this is used for non-linear fitting but it can be replaced by more appropriate solver)


Description:

This file contains data of five participants who participated in the experiment and MATLAB script to run the main analysis.
It runs the algorithm including the calibration procedure and it produces Fig9 and Fig10. 
These figures will note be exactly the same as in the article because the algorithm has stochastic features (for exmaple in the saccade integration) but the results will be very similar. 
The data are divided into the data obtained from the EOG bioamplifier (Glasgow Neuro Ltd.) and the video-based eye tracker (Pupil Labs) data.
Data are in CSV format with first line indicating the name of the row. The data can be loaded by the MATLAB function readtable(filename).

EOG_S#.txt 
- bioamplifier data
row1 - EOG (bioamplifier output in) [mV]
row2 - GAZE_INTERPOLATED (the video-based eye tracker output interpolated to EOG timestamps) [deg]
row3 - SACC (saccades detected on the GAZE data using EyeMMV toolbox [36] ) [deg]
row4 - STIM (position of the visual stimulus) [deg]
row5 - TIME (EOG timestamp) [s]

GAZE_S#.txt
- video-based eye tracker data
row1 - GAZE (raw eye tracker output)  [deg]
row2 - TIME (video-based eye tracker timestamps) [s]

S#_data_F#
- precomputed data of the non-linear fitting procedure, for each subject and frequency. These data can be obtain by running STEP1 of the run_analysis.m.

run_analysis.m
- the MATLAB file to run the analysis. Please note that in the initial run it is required to compute the output of the non-linear fitting procedure in order to obtain the output parameters.
This usually takes several hours to compute all combination of parameters. Currently, the procedure requires opti_lbfsgb function which is a general purpose slover, however, this can be replaced by a more efficient solver.

match2setofsaccades.m
- the helper function to perform matching of the saccades.

EyeEOG_export.m
- this is MATLAB class which performs the computation of the parameters on the EOG data, saccade detection, and the saccade integration

detect_saccade.m
- this function has the code of the saccade detection algorithm.

compute_new_estimate.m
- this function has the code of the saccade integration algorithm.

[36] Krassanakis V, Filippakopoulou V, Nakos B. EyeMMV toolbox: An eye movement post-analysis tool based on a two-step spatial dispersion threshold for fixation identification. J Eye Mov Res. 2014;7(1): 1–10.