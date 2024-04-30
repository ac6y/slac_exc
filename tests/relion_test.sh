#!/bin/bash

# data import
mkdir -p Import/job001
`which relion_import`  --do_movies  --optics_group_name "opticsGroup1" --angpix 1.4 --kV 300 --Cs 2.7 --Q0 0.1 --beamtilt_x 0 --beamtilt_y 0 --i "Micrographs/*.tif" --odir Import/job001/ --ofile movies.star --pipeline_control Import/job001/

# mpi Motion Correction job
mkdir -p MotionCorr/job002/
`which relion_run_motioncorr_mpi` --i Import/job001/movies.star --o MotionCorr/job002/ --first_frame_sum 1 --last_frame_sum -1 --use_own  --j 1 --float16 --bin_factor 1 --bfactor 150 --dose_per_frame 1.277 --preexposure 0 --patch_x 5 --patch_y 5 --eer_grouping 32 --dose_weighting  --grouping_for_ps 3   --pipeline_control MotionCorr/job002/

# mpi CTF Estimation
mkdir -p CtfFind/job003
`which relion_run_ctffind_mpi` --i MotionCorr/job002/corrected_micrographs.star --o CtfFind/job003/ --Box 512 --ResMin 30 --ResMax 5 --dFMin 5000 --dFMax 50000 --FStep 500 --dAst 100 --ctffind_exe /public/EM/ctffind/ctffind.exe --ctfWin -1 --is_ctffind4  --fast_search  --use_given_ps  --only_do_unfinished   --pipeline_control CtfFind/job003/

# mpi Auto Picking
mkdir -p AutoPick/job004
`which relion_autopick_mpi` --i CtfFind/job003/micrographs_ctf.star --odir AutoPick/job004/ --pickname autopick --LoG  --LoG_diam_min 200 --LoG_diam_max 250 --shrink 0 --lowpass 20 --LoG_adjust_threshold 0  --pipeline_control AutoPick/job004/

# mpi PreProcess Particle Extraction
mkdir -p Extract/job005
`which relion_preprocess` --i AutoPick/job004/micrographs_selected.star --coord_list AutoPick/job004/autopick.star --part_star Extract/job005/particles.star --part_dir Extract/job005/ --extract --extract_size 128 --float16  --norm --bg_radius 48 --white_dust -1 --black_dust -1 --invert_contrast   --pipeline_control Extract/job005/
