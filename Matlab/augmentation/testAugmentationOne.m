% Tested Augmentation Hypothesis One on The Folowing Sets:
% ALL PASS: data_4, data_5, data_6,
% ALL FAIL: pathsNotAutoClasses

data = data_5;
errors = 0;
successes = 0;

for i = 1 : size(data, 1)
    disp(i);
    result = testAugmentationHypothesisOne(graph6(data(i, :)));
    if (result)
        successes = successes + 1;
    else
        errors = errors + 1;
    end
end

disp(['NFailures = ', num2str(errors)]);

disp(['NSuccesses = ', num2str(successes)]);