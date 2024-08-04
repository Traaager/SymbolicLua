Monomial = {}
Monomial.__index = Monomial

Polynomial = {}
Polynomial.__index = Polynomial

---@param coefficient integer
---@param variable string
---@param power integer
function Monomial:new(coefficient, variable, power)
  local mon = {
    coefficient = coefficient,
    variable    = variable,
    power       = power
  }
  return setmetatable(mon, Monomial)
end

function Monomial:toString()
  return tostring(self.coefficient)..self.variable.."^"..tostring(self.power)
end


function Monomial:add(other)
  if self.variable == other.variable then
    if self.power == other.power then
      return Monomial:new(self.coefficient + other.coefficient, self.variable, self.power)
    end
  end
  return Polynomial:new({self, other})
end

function Polynomial:new(listOfMonomials)
  local poly = {}
  for i = 1, #listOfMonomials do
    poly[#poly+1] = listOfMonomials[i]
  end
  return setmetatable(poly, Polynomial)
end









function removeSpaces(polynomial)
  local result = ""
  for i = 1, #polynomial do
    local c = polynomial:sub(i, i)
    if c ~= " " then
      result = result .. c
    end
  end
  return result
end

function getListOfMonomials(expr)
  local result   = {}
  local monomial = ""
  expr = removeSpaces(expr)
  for i = 1, #expr do
    local c = expr:sub(i, i)
    if c == "+" then
      result[#result+1] = monomial
      monomial = ""
      goto continue
    elseif c == "-" then
      result[#result+1] = monomial
      monomial = "-"
      goto continue
    end
    monomial = monomial .. c
    ::continue::
  end
  result[#result+1] = monomial
  return result
end

-- tests
first = Monomial:new(5, "x", 3)
second = Monomial:new(1, "x", 2)
print(first:toString())
