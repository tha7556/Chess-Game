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
			
			whitePieces = {rook1 = Piece:new({placeHolder="Rook",x=1,y=1,color="White"}),
						   knight1 = Piece:new({placeHolder="Knight",x=2,y=1,color="White"}),
						   bishop1 = Piece:new({placeHolder="Bishop",x=3,y=1,color="White"}),
						   queen = Piece:new({placeHolder="Queen",x=4,y=1,color="White"}),
						   king = Piece:new({placeHolder="King",x=5,y=1,color="White"}),
						   bishop2 = Piece:new({placeHolder="Bishop",x=6,y=1,color="White"}),
						   knight2 = Piece:new({placeHolder="Knight",x=7,y=1,color="White"}),
						   rook2 = Piece:new({placeHolder="Rook",x=8,y=1,color="White"}),
						   pawn1 = Piece:new({x=1,y=2,color="White"}),
						   pawn2 = Piece:new({x=2,y=2,color="White"}),
						   pawn3 = Piece:new({x=3,y=2,color="White"}),
						   pawn4 = Piece:new({x=4,y=2,color="White"}),
						   pawn5 = Piece:new({x=5,y=2,color="White"}),
						   pawn6 = Piece:new({x=6,y=2,color="White"}),
						   pawn7 = Piece:new({x=7,y=2,color="White"}),
						   pawn8 = Piece:new({x=8,y=2,color="White"}),
						   }, 
			blackPieces = {rook1 = Piece:new({placeHolder="Rook",x=1,y=8,color="Black"}),
						   knight1 = Piece:new({placeHolder="Knight",x=2,y=8,color="Black"}),
						   bishop1 = Piece:new({placeHolder="Bishop",x=3,y=8,color="Black"}),
						   queen = Piece:new({placeHolder="Queen",x=4,y=8,color="Black"}),
						   king = Piece:new({placeHolder="King",x=5,y=8,color="Black"}),
						   bishop2 = Piece:new({placeHolder="Bishop",x=6,y=8,color="Black"}),
						   knight2 = Piece:new({placeHolder="Knight",x=7,y=8,color="Black"}),
						   rook2 = Piece:new({placeHolder="Rook",x=8,y=8,color="Black"}),
						   pawn1 = Piece:new({x=1,y=7,color="Black"}),
						   pawn2 = Piece:new({x=2,y=7,color="Black"}),
						   pawn3 = Piece:new({x=3,y=7,color="Black"}),
						   pawn4 = Piece:new({x=4,y=7,color="Black"}),
						   pawn5 = Piece:new({x=5,y=7,color="Black"}),
						   pawn6 = Piece:new({x=6,y=7,color="Black"}),
						   pawn7 = Piece:new({x=7,y=7,color="Black"}),
						   pawn8 = Piece:new({x=8,y=7,color="Black"}),
						   }}
Game.metatable = {}
Game.metatable.__index = Game
function Game:new(newObj)
	return setmetatable(newObj, Game.metatable)
end
function Game:setupGame()
	for key,value in pairs(self.whitePieces) do
		self.board[value.x][value.y] = value
	end
	for key,value in pairs(self.blackPieces) do
		self.board[value.x][value.y] = value
	end
end
function Game:printBoard()
	local write = io.write
	write("\n|   -----------------------------------------------------   |\n|   ")
	for y=#self.board, 1, -1 do
		for x=1, #self.board do
			if self.board[x][y] == nil then
				write("----   ")
			else
				if self.board[x][y].color == "White" then
					write("("..string.sub(self.board[x][y].placeHolder, 1, 2)..")   ")
				else
					write("["..string.sub(self.board[x][y].placeHolder, 1, 2).."]   ")
				end
			end
		end
		write("|   \n|   ")
	end
	write("-----------------------------------------------------   |\n")

end
function Game:displayBoard()
	print("test")
	display.setDefault("background",1,1,1)
	local myRectangle = display.newRect( 40, 100, 35, 35 )
	myRectangle.strokeWidth = 3
	myRectangle:setFillColor( 230/255, 215/255, 194/255 )
	myRectangle:setStrokeColor( 0, 0, 0 )
	
	local myRectangle = display.newRect( 75, 100, 35, 35 )
	myRectangle.strokeWidth = 3
	myRectangle:setFillColor( 171/255, 84/255, 24/255 )
	myRectangle:setStrokeColor( 0, 0, 0 )
end

