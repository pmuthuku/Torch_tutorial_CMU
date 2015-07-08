-- Comments are denoted using the double hyphen

require 'optim'

-- Simple variable assignment
N = 5


-- Create a random tensor using torch.rand() function
A = torch.rand(N,N)



-- Make it symmetric by multiplying it with its transpose
A = A*A:t()

-- make it definite
A:add(0.001, torch.eye(N))


-- add a linear term
b = torch.rand(N)




-- Create a closure that returns Objective function and gradient
function feval(x)


   --Objective function
   local f = x:dot(A*x)-b:dot(x) --  (x'Ax - bx)

   --Gradient 
   local df = (A*x - b)*2

   print('Error is ' .. f )

   return f, df

end



-- Let's call the optimizer
x = torch.rand(N) -- initialize the value of X


-- settings for the optimization algorithm
state = {
   learningRate = 0.01
}


optimizer = optim.sgd

-- Call it once
optimizer(feval, x, state)
-- Arguments:
-- i)  Closure that returns objective function and gradient 
-- ii) The parameter that needs to be optimized
-- iii)Settings for the optimizer


-- Run multiple iterations of this
for i = 1,5 do
   optimizer(feval, x, state)
end



