local cell = 0
local cells = {}
local skip = 0
local code = ""
local comp = ""

local filename = ({...})[1] or "brainfuck.txt"
local codefile = io.open( filename,"r")
if ( codefile ) then
	code = codefile:read( "*all" )
else
	print( "Unable to open "..filename )
end

function g()
	return ( cells[cell] or 0 )
end

function s( a )
	cells[cell] = a
end

function n()
	cell = cell + 1
end

function p()
	cell = cell - 1
end

for i = 1, string.len( code ) do
	local c = string.sub( code, i, i )
	if ( c == "+" ) then
		comp = comp.."s(g()+1)"
	elseif ( c == "-" ) then
		comp = comp.."s(g()-1)"
	elseif ( c == ">" ) then
		comp = comp.."n()"
	elseif ( c == "<" ) then
		comp = comp.."p()"
	elseif ( c == "." ) then
		comp = comp.."io.write(string.char(g()))"
	elseif ( c == "," ) then
		comp = comp.."s(string.byte(io.read(1)))"
	elseif ( c == "[" ) then
		comp = comp.."while not(g()==0)do "
	elseif ( c == "]" ) then
		comp = comp.."end "
	else
		--Unassigned
	end
end

local f = loadstring( comp )
if ( f ) then
	f()
end