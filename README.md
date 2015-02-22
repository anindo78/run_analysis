# run_analysis
Coursera: Getting and Cleaning Data Course Project

1) First create a directory for the course project and download all data. "data quiz2" directory to store files
2) Create path to read all files. 
3) Read all the test files i.e. *test.txt files. X_test, y_test and subject_test.txt and assign labels
4) Read Activity File and assign labels on name of activity (nameact) and type of activity (label) merge with Lables from y_test.txt

5) Read feature.txt file and save data in "feat" 

6) Repeat step #3 to Read all training files

7) Now combine all into one dataset (overall) and assign labels to the dataset
  This requires using the feat dataset to assign colnames
  
8) Extract only mean and std from the overall dataset name it "featmeanstd"

9) Mutate a new group by variable "groupby" to combine "nameact" and "label"
10) Summarize the data by the groupby variable and compute means.



