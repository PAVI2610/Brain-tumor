 
 
x=featuresnew(:, 1:11);
y=featuresnew(:, 12);
rand=randperm(244);
xtr=x(rand(1:196), :);
ytr=y(rand(1:196), :);
xt=x((197:end), :);
yt=y((197:end), :);
xtr=normalize(xtr);
%xtr=table2array(xtr);
xt=normalize(xt);
%xt=table2array(xt);
%ytr=table2array(ytr);
%yt=table2array(yt);
mdl=fitcknn(xtr,ytr,'NumNeighbors',5);
y_predict=predict(mdl,xt); 
trainresult=predict(mdl,xtr);
testresult=predict(mdl,xt);
trainaccuracy=sum(trainresult==ytr)/length(ytr)*100;
testaccuracy=sum(testresult==yt)/length(yt)*100;

sp1=sprintf("Train Accuracy=%.2f",trainaccuracy);
 

sp=sprintf("Test Accuracy=%.2f",testaccuracy);
disp(sp);
 disp(sp1);
  %Plot the decision boundary and data points
figure;
gscatter(x(:,1), x(:,2), y, 'rb');
hold on;
 
title(sprintf('KNN Classification of Brain Tumor MRI (Accuracy = %.2f%%)', testaccuracy));
xlabel('trainresult');
ylabel('testresult');
legend({'Tumor', 'Healthy', 'Decision Boundary'}, 'Location', 'Best');
  % Evaluate the model
  figure;
conf_mat = confusionmat(yt,  testresult);
precision = conf_mat(1,1)/(conf_mat(1,1)+conf_mat(2,1));
recall = conf_mat(1,1)/(conf_mat(1,1)+conf_mat(1,2));
f1_score = 2 * (precision * recall) / (precision + recall);

[roc_x, roc_y, ~, auc] = perfcurve(yt,testresult  , '1');

% Print the evaluation metrics
fprintf('Confusion matrix:\n');
disp(conf_mat);

fprintf('Precision: %f\n', precision);
fprintf('Recall: %f\n', recall);
fprintf('F1 score: %f\n', f1_score);
fprintf('AUC: %f\n', auc);

% Plot the ROC curve
plot(roc_x, roc_y);
xlabel('False positive rate');
ylabel('True positive rate');
title('ROC curve');



