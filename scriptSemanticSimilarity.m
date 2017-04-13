%% This is the script for running multiple iterations for semantic similarity codes
close all
clear all
clc

sum = 0;
addPath = 1;
for expIter = 1:2
    accuracy = functionSemanticSimilarity(expIter, addPath);
    sum = sum + accuracy;
    pause(2);
    addPath = 0
end

avgAcc = sum / expIter