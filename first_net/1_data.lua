require 'torch'   -- torch
require 'nn'      -- provides a normalization operator

-- Here we download dataset files. 

-- Note: files were converted from their original LUSH format
-- to Torch's internal format.


tar = 'http://torch7.s3-website-us-east-1.amazonaws.com/data/mnist.t7.tgz'

if not paths.dirp('mnist.t7') then
   os.execute('wget ' .. tar)
   os.execute('tar xvf ' .. paths.basename(tar))
end

train_file = 'mnist.t7/train_32x32.t7'
test_file = 'mnist.t7/test_32x32.t7'


----------------------------------------------------------------------
print '==> loading dataset'

-- We load the dataset from disk, and re-arrange it to be compatible
-- with Torch's representation. Matlab uses a column-major representation,
-- Torch is row-major, so we just have to transpose the data.

-- Note: the data, in X, is 4-d: the 1st dim indexes the samples, the 2nd
-- dim indexes the color channels (RGB), and the last two dims index the
-- height and width of the samples.

trainData = torch.load(train_file,'ascii')
trainData.data = trainData.data:sub(1,6000)
trainData.labels = trainData.labels:sub(1,6000)


-- Finally we load the test data.

testData = torch.load(test_file,'ascii')
testData.data = testData.data:sub(1,1000)
testData.labels = testData.labels:sub(1,1000)


trsize = trainData.data:size(1)
tesize = testData.data:size(1)


----------------------------------------------------------------------
print '==> preprocessing data'

-- Preprocessing requires a floating point representation (the original
-- data is stored on bytes). Types can be easily converted in Torch, 
-- in general by doing: dst = src:type('torch.TypeTensor'), 
-- where Type=='Float','Double','Byte','Int',... Shortcuts are provided
-- for simplicity (float(),double(),cuda(),...):

trainData.data = trainData.data:float()
testData.data = testData.data:float()

trainData.labels = trainData.labels:double()
testData.labels = testData.labels:double()

