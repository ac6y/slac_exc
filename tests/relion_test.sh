#!/bin/bash
relion_import  --do_movies  --optics_group_name "opticsGroup1" --angpix 1.4 --kV 300 --Cs 2.7 --Q0 0.1 --beamtilt_x 0 --beamtilt_y 0 --i "Micrographs/*.tif" --odir Import/job009/ --ofile movies.star --continue  --pipeline_control Import/job009/
