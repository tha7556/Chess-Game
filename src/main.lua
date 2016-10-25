--Piece Class		
Piece = {placeHolder="Pawn",color="Grey",x=-1,y=-1,hasMoved=false,number=-1}
Piece.metatable = {}
Piece.metatable.__index = Piece
function Piece:new(newObj)
	return setmetatable(newObj, Piece.metatable)
end
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
game = Game:new({}) --Global variable for the game
--Piece Functions
function Piece:possibleMoves()
	moves = {}
	--Possible moves for pawns 
	if self.placeHolder == "Pawn" then 
		if self.color == "Black" then --Black Pieces
			if self.y - 1 > 0 then --Piece is still on the board
				if game.board[self.x][self.y - 1] == nil then --Space ahead is empty
					moves[#moves + 1] = {self.x,self.y - 1}
				end
				if not hasMoved and game.board[self.x][self.y - 2]  == nil and game.board[self.x][self.y - 1]  == nil then --Hasn't moved and space 2 ahead is empty
					moves[#moves + 1] = {self.x,self.y - 2}
				end
				if game.board[self.x+1][self.y-1] ~= nil and game.board[self.x+1][self.y-1].color ~= self.color then --space to right diagonal is occupied with an enemy
					moves[#moves + 1] = {self.x+1,self.y-1}
				end
				if game.board[self.x-1][self.y-1] ~= nil and game.board[self.x-1][self.y-1].color ~= self.color then --space to left diagonal is occupied with an enemy
					moves[#moves + 1] = {self.x-1,self.y-1}
				end
			end
		elseif self.color =="White" then --White Pieces
			if self.y + 1 < 9 then --Piece is still on the board
				if game.board[self.x][self.y + 1] == nil then --Space ahead is empty
					moves[#moves + 1] = {self.x,self.y + 1}
				end
				if not hasMoved and game.board[self.x][self.y + 2]  == nil and game.board[self.x][self.y + 1]  == nil then --Hasn't moved and space 2 ahead is empty
					moves[#moves + 1] = {self.x,self.y + 2}
				end
				if game.board[self.x+1][self.y+1] ~= nil and game.board[self.x+1][self.y+1].color ~= self.color then --space to right diagonal is occupied
					moves[#moves + 1] = {self.x+1,self.y+1}
				end
				if game.board[self.x-1][self.y+1] ~= nil and game.board[self.x-1][self.y+1].color ~= self.color then --space to left diagonal is occupied
					moves[#moves + 1] = {self.x-1,self.y+1}
				end
			end
		else --No color assigned
			print("Piece Not Valid")
		end
	--Possible moves for Rooks
	elseif self.placeHolder == "Rook" then
		local top, bottom, right, left = false
		for i=1, 7 do
			--Forward
			if not top and self.y+i < 9 then
				if game.board[self.x][self.y+i] ~= nil then --if Space is occupied
					top = true
				end
				if game.board[self.x][self.y+i].color ~= self.color then --prevents rook from friendly fire
					moves[#moves+1] = {self.x, self.y+i}
				end
			end
			--Backward
			if not bottom and self.y-i > 0 then
				if game.board[self.x][self.y-i] ~= nil then --if Space is occupied
					bottom = true
				end
				if game.board[self.x][self.y-i].color ~= self.color then --prevents rook from friendly fire
					moves[#moves+1] = {self.x, self.y-i}
				end
			end
			--Right
			if not right and self.x+i < 9 then
				if game.board[self.x+i][self.y] ~= nil then --if Space is occupied
					right = true
				end
				if game.board[self.x+i][self.y].color ~= self.color then --prevents rook from friendly fire
					moves[#moves+1] = {self.x+i, self.y}
				end
			end
			--Left
			if not left and self.x-i > 0 then
				if game.board[self.x-i][self.y] ~= nil then --if Space is occupied
					left = true
				end
				if game.board[self.x-i][self.y].color ~= self.color then --prevents rook from friendly fire
					moves[#moves+1] = {self.x-i, self.y}
				end
			end
		end
	--Possible moves for Knights
	elseif self.placeHolder == "Knight" then
		if self.y-1 > 0 then --down 1 over 2
			if self.x-3 > 0 and game.board[self.x-2][self.y-1].color ~= self.color then
				moves[#moves+1] = {self.x-2,self.y-1}
			end
			if self.x+3 < 9 and game.board[self.x+2][self.y-1].color ~= self.color then
				moves[#moves+1] = {self.x+2,self.y-1}
			end
		end
		if self.y+1 < 9 then --up 1 over 2
			if self.x-3 > 0 and game.board[self.x-2][self.y+1].color ~= self.color then
				moves[#moves+1] = {self.x-2,self.y+1}
			end
			if self.x+3 < 9 and game.board[self.x+2][self.y+1].color ~= self.color then
				moves[#moves+1] = {self.x+2,self.y+1}
			end
		end
		if self.x+1 < 9 then --right 1 up/down 2
			if self.y-3 > 0 and game.board[self.x+1][self.y-2].color ~= self.color then
				moves[#moves+1] = {self.x+1,self.y-2}
			end
			if self.y+3 < 9 and game.board[self.x+1][self.y+2].color ~= self.color then
				moves[#moves+1] = {self.x+1,self.y+2}
			end
		end
		if self.x-1 > 0 then --left 1 up/down 2
			if self.y-3 > 0 and game.board[self.x-1][self.y-2].color ~= self.color then
				moves[#moves+1] = {self.x-1,self.y-2}
			end
			if self.y+3 < 9 and game.board[self.x-1][self.y+2].color ~= self.color then
				moves[#moves+1] = {self.x-1,self.y+2}
			end
		end
	--Possible moves for Bishops
	elseif self.placeHolder == "Bishop" then
		local topLeft, topRight, bottomLeft, bottomRight = false
		for i=1, 7 do
			--Top Left diagonal
			if not topLeft and self.x-i > 0 and self.y+i < 9 then
				if game.board[self.x-i][self.y+i] ~= nil then --if Space is occupied
					topLeft = true
				end
				if game.board[self.x-i][self.y+i].color ~= self.color then --prevents bishops from friendly fire
					moves[#moves+1] = {self.x-i, self.y+i}
				end
			end
			--Top Right diagonal
			if not topRight and self.x+i > 0 and self.y+i < 9 then
				if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
					topRight = true
				end
				if game.board[self.x+i][self.y+i].color ~= self.color then --prevents bishops from friendly fire
					moves[#moves+1] = {self.x+i, self.y+i}
				end
			end
			--Bottom Left diagonal
			if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
				if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
					bottomLeft = true
				end
				if game.board[self.x-i][self.y-i].color ~= self.color then --prevents bishops from friendly fire
					moves[#moves+1] = {self.x-i, self.y-i} 
				end
			end
			--Bottom Right diagonal
			if not bottomRight and self.x+i < 9 and self.y-i > 0 then
				if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
					bottomRight = true
				end
				if game.board[self.x+i][self.y-i].color ~= self.color then --prevents bishops from friendly fire
					moves[#moves+1] = {self.x+i, self.y-i}
				end
			end
		end
	--Possible moves for the Queen
	elseif self.placeHolder == "Queen" then
		local topLeft, topRight, bottomLeft, bottomRight, top, bottom, right, left = false
		for i=1, 7 do
			--Top Left diagonal
			if not topLeft and self.x-i > 0 and self.y+i < 9 then
				if game.board[self.x-i][self.y+i] ~= nil then --if Space is occupied
					topLeft = true
				end
				if game.board[self.x-i][self.y+i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x-i, self.y+i}
				end
			end
			--Top Right diagonal
			if not topRight and self.x+i > 0 and self.y+i < 9 then
				if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
					topRight = true
				end
				if game.board[self.x+i][self.y+i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x+i, self.y+i}
				end
			end
			--Bottom Left diagonal
			if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
				if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
					bottomLeft = true
				end
				if game.board[self.x-i][self.y-i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x-i, self.y-i} 
				end
			end
			--Bottom Right diagonal
			if not bottomRight and self.x+i < 9 and self.y-i > 0 then
				if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
					bottomRight = true
				end
				if game.board[self.x+i][self.y-i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x+i, self.y-i}
				end
			end
			--Forward
			if not top and self.y+i < 9 then
				if game.board[self.x][self.y+i] ~= nil then --if Space is occupied
					top = true
				end
				if game.board[self.x][self.y+i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x, self.y+i}
				end
			end
			--Backward
			if not bottom and self.y-i > 0 then
				if game.board[self.x][self.y-i] ~= nil then --if Space is occupied
					bottom = true
				end
				if game.board[self.x][self.y-i].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x, self.y-i}
				end
			end
			--Right
			if not right and self.x+i < 9 then
				if game.board[self.x+i][self.y] ~= nil then --if Space is occupied
					right = true
				end
				if game.board[self.x+i][self.y].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x+i, self.y}
				end
			end
			--Left
			if not left and self.x-i > 0 then
				if game.board[self.x-i][self.y] ~= nil then --if Space is occupied
					left = true
				end
				if game.board[self.x-i][self.y].color ~= self.color then --prevents queen from friendly fire
					moves[#moves+1] = {self.x-i, self.y}
				end
			end
		end
	--Possible moves for the King
	elseif self.placeHolder == "King" then
		if self.y+1 < 9 then --forward
			moves[#moves+1] = {self.x, self.y + 1}
		end
		if self.y-1 > 0 then --backward
			moves[#moves+1] = {self.x, self.y - 1}
		end
		if self.x+1 < 9 then --right
			moves[#moves+1] = {self.x + 1, self.y}
		end
		if self.x-1 > 0 then --left
			moves[#moves+1] = {self.x - 1, self.y}
		end
	end
	return moves
end
--"Main"
local pawn1 = Piece:new({placeHolder="King",x=4,y=4,color="White"})
print("running")
local moves = pawn1:possibleMoves()
for i=1, #moves do
	print("["..moves[i][1]..","..moves[i][2].."]")
end
--print(#moves)

