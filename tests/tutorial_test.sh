# dl data
wget ftp://ftp.mrc-lmb.cam.ac.uk/pub/scheres/relion30_tutorial_data.tar
wget ftp://ftp.mrc-lmb.cam.ac.uk/pub/scheres/relion50_tutorial_precalculated_results.tar.gz
tar -xf relion30_tutorial_data.tar
tar -zxf relion50_tutorial_precalculated_results.tar.gz

# Import
relion_import  --do_movies  --optics_group_name "opticsGroup1" --optics_group_mtf mtf_k2_200kv.star --angpix 0.885 --kV 200 --Cs 1.4 --Q0 0.1 --beamtilt_x 0 --beamtilt_y 0 --i "tests/relion30_tutorial/Movies/*.tiff" --odir Import/job001/ --ofile movies.star --pipeline_control Import/job001/

# Motion Correction
`which relion_run_motioncorr` --i Import/job001/movies.star --o MotionCorr/job002/ --first_frame_sum 1 --last_frame_sum -1 --use_own  --j 12 --float16 --bin_factor 1 --bfactor 150 --dose_per_frame 1.277 --preexposure 0 --patch_x 5 --patch_y 5 --eer_grouping 32 --gainref tests/relion30_tutorial/Movies/gain.mrc --gain_rot 0 --gain_flip 0 --dose_weighting  --grouping_for_ps 3   --pipeline_control MotionCorr/job002/

# CTF Estimation
`which relion_run_ctffind_mpi` --i MotionCorr/job002/corrected_micrographs.star --o CtfFind/job003/ --Box 512 --ResMin 30 --ResMax 5 --dFMin 5000 --dFMax 50000 --FStep 500 --dAst 100 --ctffind_exe /public/EM/ctffind/ctffind.exe --ctfWin -1 --is_ctffind4  --fast_search  --use_given_ps   --pipeline_control CtfFind/job003/

#`which relion_run_ctffind_mpi` --i MotionCorr/job002/corrected_micrographs.star --o CtfFind/job003/ --Box 512 --ResMin 30 --ResMax 5 --dFMin 5000 --dFMax 50000 --FStep 500 --dAst 100 --ctffind_exe /public/EM/ctffind/ctffind.exe --ctfWin -1 --is_ctffind4  --fast_search  --use_given_ps  --only_do_unfinished   --pipeline_control CtfFind/job006/

# Manual Picking
`which relion_manualpick` --i MotionCorr/job002/corrected_micrographs.star --odir ManualPick/job004/ --pickname manualpick --allow_save   --fast_save --selection ManualPick/job004/micrographs_selected.star --scale 0.25 --sigma_contrast 3 --black 0 --white 0 --topaz_denoise --topaz_exe /public/EM/RELION/topaz --particle_diameter 200  --pipeline_control ManualPick/job004/

# Auto Picking
`which relion_autopick` --i MotionCorr/job002/corrected_micrographs.star --odir AutoPick/job005/ --pickname autopick --LoG  --LoG_diam_min 200 --LoG_diam_max 250 --shrink 0 --lowpass 20 --LoG_adjust_threshold 0  --pipeline_control AutoPick/job005/

# Particle Extraction
`which relion_preprocess` --i CtfFind/job006/micrographs_ctf.star --coord_list AutoPick/job005/autopick.star --part_star Extract/job008/particles.star --part_dir Extract/job008/ --extract --extract_size 256 --float16  --scale 64 --norm --bg_radius 25 --white_dust -1 --black_dust -1 --invert_contrast   --pipeline_control Extract/job008/
