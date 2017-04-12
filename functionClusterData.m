function clusteringModel = functionClusterData(vggFeatures, datasetLabels, NUMBER_OF_CLUSTERS, NUMBER_OF_CLASSES)
USE_SUBSET_OF_FEATURES = 0;
%% START >>> K-means clustering of IDT features of dataset (all videos, all classes)
disp('K-means clustering of vgg features of dataset (all images, all classes)');
subSetOfAllFeatures = zeros(0,0);
offset = 0;
stride = 15;
subsetOfFeatures = [];
perClassFeatures = 90; % This number will change as per dataset. This number should be less than the minumum number of features
%across all classes

for i = 1:NUMBER_OF_CLASSES
    classFeatures = vggFeatures(:,datasetLabels == i);
    if USE_SUBSET_OF_FEATURES
        subsetOfFeatures = [subsetOfFeatures classFeatures(:, 1:perClassFeatures)];
    else
        subsetOfFeatures = [subsetOfFeatures classFeatures(:, :)];
    end
    i
end
%clear subSetOfAllFeatures
% subSetOfAllFeatures = allFeatures(:, startFeatureIndexTrain(4):5:endFeatureIndexTrain(4));
[clusterCenters, clusterAssignmentsOfData] = vl_kmeans(subsetOfFeatures, NUMBER_OF_CLUSTERS, 'Initialization', 'plusplus');
% Using Matlab kmeans
% [clusterAssignmentsOfData, clusterCenters] = kmeans(subSetOfAllFeatures', NUMBER_OF_CLUSTERS);
% clusterCenters = clusterCenters';
%% END >>> K-means clustering of IDT features of dataset (all videos, all classes)

if USE_SUBSET_OF_FEATURES
%     a = reshape(clusterAssignmentsOfData, [], perClassFeatures);
%     clusteringModel = mode(a, 2);
else
    for i = 1:NUMBER_OF_CLASSES
        clusteringModel.classClusterAssignment(i, 1) = mode(clusterAssignmentsOfData(datasetLabels == i));
        % Number of samples per class
        clusteringModel.classClusterAssignment(i, 2) = length(clusterAssignmentsOfData(datasetLabels == i));
    end
end

clusteringModel.clusterCenters = clusterCenters;

%funtionTSNEVisualisation(subsetOfFeatures, clusterAssignmentsOfData)
%% t SNE visualisation
% for i = 1:NUMBER_OF_CLASSES
%    funtionTSNEVisualisation(subsetOfFeatures(:, perClassFeatures * (i-1) + 1: perClassFeatures * (i-1) + perClassFeatures), ...
%                             a(i, :));
% end