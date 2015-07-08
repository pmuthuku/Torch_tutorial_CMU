----------------------------------------------------------------------------
----------------------------------------------------------------------------
---  Code modified from                                                   --
---  http://blog.aicry.com/torch7-reading-csv-into-tensor/                --
----------------------------------------------------------------------------
----------------------------------------------------------------------------

require 'torch'


-- Split string
function string:split(sep)
   local sep, fields = sep, {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(substr) fields[#fields + 1] = substr end)
  return fields
end


-- Function to read from file
function read_csv_file(fp)
   local filePath = fp

   -- Count number of rows and columns in file
   local i = 0
   for line in io.lines(filePath) do
      if i == 0 then
	 COLS = #line:split(',')
      end
      i = i + 1
   end

   local ROWS = i

   -- Read data from CSV to tensor
   csvFile = io.open(filePath, 'r')

   local data = torch.Tensor(ROWS, COLS)

   local i = 0

   for line in csvFile:lines('*l') do
      i = i + 1
      local l = line:split(' ')
      for key, val in ipairs(l) do
	 data[i][key] = val
      end
   end

   csvFile:close()
   return data

end
