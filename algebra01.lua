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
    power       = power,
    sign        = coefficient > 0 and "+" or "-"
  }
  return setmetatable(mon, Monomial)
end

function Monomial:toString()
  if self.coefficient == 0 then
    return ""
  else
    if self.coefficient == 1 then
      if self.power == 0 then
        return "1"
      elseif self.power == 1 then
        return self.variable
      else
        return self.variable.."^"..tostring(self.power)
      end
    elseif self.coefficient == -1 then
      if self.power == 0 then
        return "-1"
      elseif self.power == 1 then
        return "-"..self.variable
      else
        return "-"..self.variable.."^"..tostring(self.power)
      end
    else
      if self.power == 0 then
        return tostring(self.coefficient) 
      elseif self.power == 1 then
        return tostring(self.coefficient)..self.variable
      else
        return tostring(self.coefficient)..self.variable.."^"..tostring(self.power)
      end
    end
  end
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
  local poly = {
    monomials = {}
  }
  local mons = poly.monomials
  for i = 1, #listOfMonomials do
    mons[#mons+1] = listOfMonomials[i]
  end
  return setmetatable(poly, Polynomial)
end

function Polynomial:toString()
  local result = ""
  for _, m in pairs(self.monomials) do
    result = result .. m:toString()
  end
  return result
end

function Polynomial:fromString(str)

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
monomials = {
  Monomial:new( 1, "x", 0),
  Monomial:new(-1, "x", 0),
  Monomial:new( 2, "x", 0),
  Monomial:new(-2, "x", 0),
  Monomial:new( 1, "x", 1),
  Monomial:new(-1, "x", 1),
  Monomial:new( 2, "x", 1),
  Monomial:new(-2, "x", 1),
  Monomial:new( 1, "x", 2),
  Monomial:new(-1, "x", 2),
  Monomial:new( 2, "x", 2),
  Monomial:new(-2, "x", 2),
  Monomial:new( 0, "x", 2),
}

for i = 1, #monomials do
  print(i..": "..monomials[i]:toString())
end
