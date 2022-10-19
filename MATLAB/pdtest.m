opts = detectImportOptions("PETDetectiveThreshold.csv");
% preview("PETDetectiveThreshold.csv", opts)
pd = readmatrix("PETDetectiveThreshold.csv", opts)
pd(2:4)
pd(1,2)
pd(1)