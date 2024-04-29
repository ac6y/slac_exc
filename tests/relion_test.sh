#!/bin/bash

# data import
relion_import  --do_movies  --optics_group_name "opticsGroup1" --angpix 1.4 --kV 300 --Cs 2.7 --Q0 0.1 --beamtilt_x 0 --beamtilt_y 0 --i "Micrographs/*.tif" --odir Import/job001/ --ofile movies.star --pipeline_control Import/job001/

# mpi job
`which relion_run_motioncorr_mpi` --i Import/job001/movies.star --o MotionCorr/job002/ --first_frame_sum 1 --last_frame_sum -1 --use_own  --j 1 --float16 --bin_factor 1 --bfactor 150 --dose_per_frame 1.277 --preexposure 0 --patch_x 5 --patch_y 5 --eer_grouping 32 --dose_weighting  --grouping_for_ps 3   --pipeline_control MotionCorr/job002/
