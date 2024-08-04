require("algebra01")

-- tests
first  = Monomial:new( 2, "x", 3)
second = Monomial:new( 7, "x", 2)
third  = Monomial:new(10, "x", 3)
fourth = Monomial:new( 3, "y", 3)
fifth  = Monomial:new( 2, "y", 3)

print(first:sub(second):toString())

