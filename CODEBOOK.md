
### Short description of the data used in the analysis

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


### Original dataset has been divided into training and test set. Data has been collected from 30 subjects and measures 6 different activities of each subject.

Training set: (7352 observations - 563 variables)
  - X_train -  training set has 7352 observations and 561 variables
  - Y_train - activity type - 7352 observations and 1 variable
  - subject_train -subject ID - 7352 observations and 1 variable     


# Test set: (2947 observations and 563 variables)
  - X_test -  test set has 2947 observations and 561 variables
  - Y_test - activity type - 2947 observations and 1 variable
  - subject_test - subject ID - 2947 observations and 1 variable   
 
# Merged dataset: (10299 observations and 563 variables)

# Variables in the merged dataset:

subject ID - numeric variable (1,2,3,...,30)
activity name - factor variable (6 levels, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

# Numeric variables:
tBodyAcc-XYZ 
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
# Numeric variables
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

### Analysis plan

1. Create test and train data sets
2. Merge two data sets
3. Assign variable names to columns 
4. Extract only variables that contain "[Mm]ean" or [Ss]td in the variable name - we get 86 variable, variables that      do not have mean or std in the label are omitted and not taken into account in the next steps of the analysis

5. Create new data set with 88 variables (86 extracted variables + subject ID + activity name)
    New dataset has 10299 observations and 88 variables
6. Format variable labels. Eliminate special signs from variable names like "-", "()" etc. and introduce lower cases
7. Create tidy dataset - extract mean of each variable for each subject and activity name
8. Order data by subject ID and activity name
9. Save tidy data set in .txt format in the working directory

Tidy data set has 180 observations and 88 variables.

   
