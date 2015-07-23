# Getting and Cleaning Data Course Project

Description of variables, data and any transformations or work that was performed with data can be found in [CodeBook.md](CodeBook.md).

Project's tasks was done in [run_analysis.R](run_analysis.R). This script does following:  
    1. Downloads the data in `.zip` format.  
    2. Unzips it to the `data/` directory.  
    3. Loads test and train data from downloaded dataset.  
    4. Makes appropriate lables for each type of measurement  
    5. Merges two datasets: test and train.  
    6. Extracts all measurements of the mean and standard deviation.  
    7. Makes independent tidy dataset.  
    
Note: script requires `data.table`, `dplyr` and `reshape2` packages.