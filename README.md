# HMM
Hidden Markov Model training and testing on the name of 20 Surahs of the Quran.

We have many voice samples of 20 names recorded. Each voice is splited into 10 ms pieces and for each a vector in a 36-dimensional space.
In this project we aim to learn 20 different HMM in order to specify which Sura is the input sequence.

# Input files
Each "ext" file consist length of the sequence of that observation, then dimension of feature vector and finally (length x dimension) data.

# Procedure
For each name we consider an HMM and try to learn its parameters. We need 8 ~ 16 states for each HMM and 3 ~ 4 gaussian mixture model.
The input sequence is splited into 8 ~ 16 pieces. Each are considerd in one state. Then using clustering, those are again splited into 3 ~ 4 clusters and gaussian mean and variance and covariance (considerd as a diagonal matrix) is learned.
