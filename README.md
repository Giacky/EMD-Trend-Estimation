# EMD Trend Estimation
This code is accompanying the thesis "Trend Estimation and Removal via Empirical Mode Decomposition" required for the Degree of Bachelor of Science in Data Science and Artificial Intelligence, Maastricht University.

By Giacomo Anerdi - [GitHub](https://github.com/Giacky)


Matlab is needed to run the entirety of the code. The required MATLAB toolboxes are:
* Statistics and Machine Learning Toolbox
* Signal Processing Toolbox
* Symbolic Math Toolbox


Using the EMD MATLAB package by Gabriel Rilling (already included in the repository) retrieved from:

http://perso.ens-lyon.fr/patrick.flandrin/emd.html


How to set up the software
* Download the folder
* In MATLAB, set the repository folder as the current folder
* Run the setup.m script


Notes:
* The file containing all the 150,000 realisations used to find the confidence interval for the ratio approach is missing due to it's large size. However a new set of realisations can be created with the reals_for_optimal_p_script.m script.
