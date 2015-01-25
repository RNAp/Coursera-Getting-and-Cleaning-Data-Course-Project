# Introduction

The script `run_analysis.R` performs the 5 steps described in the course project's definition.

# Variables

* `X_train`, `y_train`, `X_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `X_complete`, `y_complete` and `subject_complete` merge the previous datasets to further analysis.
* `feature_name` contains the correct names for variable names
* `data` merges `X_complete`, `y_complete` and `subject_complete` in a dataset.
* Finally, `tidyData` contains the relevant averages which will be later stored in a `.txt` file. `aggregate` function was used to calculate average value for each variable.