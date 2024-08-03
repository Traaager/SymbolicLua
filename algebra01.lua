expression = "5x^2 + 3xy^3 - 10x + 2y"
-- 5x^2, 3xy^3, -10x, 2y
expression = "2x^3+5x^2-7x+19"

function removeSpaces(str)
  result = ""
  for i = 1, #str do
    local c = str:sub(i, i)
    if c ~= " " then
      result = result .. c
    end
  end
  return result
end

function parse(expr)
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

function analyze(monomial) -- -> coefficient, variables, powers
  
end

mon1 = "2x^5"

result = analyze(mon1)

