Monomial = {}
Monomial.__index = Monomial

Polynomial = {}
Polynomial.__index = Polynomial

---@param coefficient integer
---@param variable string
---@param power integer
function Monomial:new(coefficient, variable, power)
  if coefficient == 0 then
    return setmetatable({
      coefficient = 0,
      variable    = nil,
      power       = 1,
      sign        = coefficient > 0 and "+" or "-"
     }, Monomial)
  end

  if not variable then
    return setmetatable({
      coefficient = coefficient,
      variable    = nil,
      power       = 1,
      sign        = coefficient > 0 and "+" or "-"
     }, Monomial)
  end

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
  for i, m in pairs(self.monomials) do
    if i == 1 then
      goto continue
    end
    result = result .. " " .. m.sign .. " "
    ::continue::
    result = result .. m:toString()
  end
  return result
end

function Polynomial:addMonomial(monomial)
  for _, m in ipairs(self.monomials) do
    if m.variable == monomial.variable then
      if m.power == monomial.power then
        m.coefficient = m.coefficient + monomial.coefficient
        return self
      end
    end
  end
  self.monomials[#self.monomials+1] = monomial
  return self
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
first  = Monomial:new( 2, "x", 3)
second = Monomial:new( 7, "x", 2)
third  = Monomial:new(10, "x", 3)
fourth = Monomial:new( 3, "y", 3)
fifth  = Monomial:new( 2, "y", 3)

summa1 = first:add(second)
summa2 = first:add(third)
summa3 = first:add(fourth)

print(first:toString())
print(second:toString())
print(fourth:toString())
print(fifth:toString())
print(first:add(second):addMonomial(fourth):addMonomial(fifth):toString())
