function [Accuracy] = Judge(prediction, TestLable)
count = 0;
for i = 1:length(prediction)
    if prediction(i)==TestLable(i)
        count = count + 1;
    end
end
Accuracy = count/length(prediction);
end