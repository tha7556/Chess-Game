local p = require "Piece"
--Game Class, contains Board
Game = {isOver=false, board={
		    --1   2   3   4   5   6   7   8 
			{nil,nil,nil,nil,nil,nil,nil,nil}, --1
			{nil,nil,nil,nil,nil,nil,nil,nil}, --2
			{nil,nil,nil,nil,nil,nil,nil,nil}, --3
 			{nil,nil,nil,nil,nil,nil,nil,nil}, --4
			{nil,nil,nil,nil,nil,nil,nil,nil}, --5
			{nil,nil,nil,nil,nil,nil,nil,nil}, --6
			{nil,nil,nil,nil,nil,nil,nil,nil}, --7
			{nil,nil,nil,nil,nil,nil,nil,nil}  --8
			}, 
			
			whitePieces = {Piece:new({placeHolder="Rook",x=1,y=1,color="White"}),
						   Piece:new({placeHolder="Knight",x=2,y=1,color="White"}),
						   Piece:new({placeHolder="Bishop",x=3,y=1,color="White"}),
						   Piece:new({placeHolder="Queen",x=4,y=1,color="White"}),
						   Piece:new({placeHolder="King",x=5,y=1,color="White"}),
						   Piece:new({placeHolder="Bishop",x=6,y=1,color="White"}),
						   Piece:new({placeHolder="Knight",x=7,y=1,color="White"}),
						   Piece:new({placeHolder="Rook",x=8,y=1,color="White"}),
						   Piece:new({x=1,y=2,color="White"}),
						   Piece:new({x=2,y=2,color="White"}),
						   Piece:new({x=3,y=2,color="White"}),
						   Piece:new({x=4,y=2,color="White"}),
						   Piece:new({x=5,y=2,color="White"}),
						   Piece:new({x=6,y=2,color="White"}),
						   Piece:new({x=7,y=2,color="White"}),
						   Piece:new({x=8,y=2,color="White"}),
						   }, 
			blackPieces = {Piece:new({placeHolder="Rook",x=1,y=8,color="Black"}),
						   Piece:new({placeHolder="Knight",x=2,y=8,color="Black"}),
						   Piece:new({placeHolder="Bishop",x=3,y=8,color="Black"}),
						   Piece:new({placeHolder="Queen",x=4,y=8,color="Black"}),
						   Piece:new({placeHolder="King",x=5,y=8,color="Black"}),
						   Piece:new({placeHolder="Bishop",x=6,y=8,color="Black"}),
						   Piece:new({placeHolder="Knight",x=7,y=8,color="Black"}),
						   Piece:new({placeHolder="Rook",x=8,y=8,color="Black"}),
						   Piece:new({x=1,y=7,color="Black"}),
						   Piece:new({x=2,y=7,color="Black"}),
						   Piece:new({x=3,y=7,color="Black"}),
						   Piece:new({x=4,y=7,color="Black"}),
						   Piece:new({x=5,y=7,color="Black"}),
						   Piece:new({x=6,y=7,color="Black"}),
						   Piece:new({x=7,y=7,color="Black"}),
						   Piece:new({x=8,y=7,color="Black"}),
						   }}
Game.metatable = {}
Game.metatable.__index = Game
function Game:new(newObj)
	return setmetatable(newObj, Game.metatable)
end

--"Main"
print("Running...")
local game = Game:new({}) --Variable for the game

