
require 'torch'   -- torch
require 'nn'      -- provides all sorts of trainable modules/layers


-- 10-class problem
noutputs = 10

-- input dimensions
nfeats = 1
width = 32
height = 32
ninputs = nfeats*width*height

-- number of hidden units (for MLP only):
nhiddens = ninputs / 2

print '==> construct model'

-- Simple 2-layer neural network, with tanh hidden units
model = nn.Sequential()
model:add(nn.Reshape(ninputs))
model:add(nn.Linear(ninputs,nhiddens))
model:add(nn.Tanh())
model:add(nn.Linear(nhiddens,noutputs))

----------------------------------------------------------------------
print '==> here is the model:'
print(model)

