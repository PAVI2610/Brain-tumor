x=featuresnew(:, 1:11);
y=featuresnew(:, 12);
rand=randperm(196);
xtr=x(rand(1:196), :);
ytr=y(rand(1:196), :);
xt=x((196:end), :);
yt=y((196:end), :);
model=fitctree(xtr,ytr);%,nSplit=50,kfold=10);
trainresult=predict(model,xtr); 
trainaccuracy=sum(trainresult==ytr)/length(ytr)*100;
testresult=predict(model,xt);
testaccuracy=sum(testresult==yt)/length(yt)*100;

sp=sprintf("Test Accuracy=%.2f",testaccuracy);
sp1=sprintf("Train Accuracy=%.2f",trainaccuracy);
disp(sp);
disp(sp1);
%Plot the decision boundary and data points
figure;
gscatter(x(:,1), x(:,2), y, 'rb');
hold on;
 
title(sprintf('DECISION TREE Classification of Brain Tumor MRI (Accuracy = %.2f%%)', testaccuracy));
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






 
