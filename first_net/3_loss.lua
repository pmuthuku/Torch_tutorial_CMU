
-- 10-class problem
noutputs = 10

-- This loss requires the outputs of the trainable model to
-- be properly normalized log-probabilities, which can be
-- achieved using a softmax function

model:add(nn.LogSoftMax())

-- The loss works like the MultiMarginCriterion: it takes
-- a vector of classes, and the index of the grountruth class
-- as arguments.

criterion = nn.ClassNLLCriterion()

print '==> here is the loss function:'
print(criterion)
