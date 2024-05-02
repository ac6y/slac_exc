# dl data
wget ftp://ftp.mrc-lmb.cam.ac.uk/pub/scheres/relion30_tutorial_data.tar
wget ftp://ftp.mrc-lmb.cam.ac.uk/pub/scheres/relion50_tutorial_precalculated_results.tar.gz
tar -xf relion30_tutorial_data.tar
tar -zxf relion50_tutorial_precalculated_results.tar.gz

# import
relion_import  --do_movies  --optics_group_name "opticsGroup1" --optics_group_mtf mtf_k2_200kv.star --angpix 0.885 --kV 200 --Cs 1.4 --Q0 0.1 --beamtilt_x 0 --beamtilt_y 0 --i "tests/relion30_tutorial/Movies/*.tiff" --odir Import/job001/ --ofile movies.star --pipeline_control Import/job001/
