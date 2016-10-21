--Game Class, contains Board
Game = {isOver=false, board={
			{nil,nil,nil,nil,nil,nil,nil,nil}, --1
			{nil,nil,nil,nil,nil,nil,nil,nil}, --2
			{nil,nil,nil,nil,nil,nil,nil,nil}, --3
 			{nil,nil,nil,nil,nil,nil,nil,nil}, --4
			{nil,nil,nil,nil,nil,nil,nil,nil}, --5
			{nil,nil,nil,nil,nil,nil,nil,nil}, --6
			{nil,nil,nil,nil,nil,nil,nil,nil}, --7
			{nil,nil,nil,nil,nil,nil,nil,nil}  --8
			}}
Game.metatable = {}
Game.metatable.__index = Game
function Game:new(newObj)
	return setmetatable(newObj, Game.metatable)
end
game = Game:new({}) --Global variable for the game
--Piece Class		
Piece = {placeHolder="Pawn",color="Grey",x=-1,y=-1,hasMoved=false,number=-1}
Piece.metatable = {}
Piece.metatable.__index = Piece
function Piece:new(newObj)
	return setmetatable(newObj, Piece.metatable)
end
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
				if game.board[self.x+1][self.y-1] ~= nil then --space to right diagonal is occupied
					moves[#moves + 1] = {self.x+1,self.y-1}
				end
				if game.board[self.x-1][self.y-1] ~= nil then --space to left diagonal is occupied
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
				if game.board[self.x+1][self.y+1] ~= nil then --space to right diagonal is occupied
					moves[#moves + 1] = {self.x+1,self.y+1}
				end
				if game.board[self.x-1][self.y+1] ~= nil then --space to left diagonal is occupied
					moves[#moves + 1] = {self.x-1,self.y+1}
				end
			end
		else --No color assigned
			print("Piece Not Valid")
		end
	--Possible moves for Rooks
	elseif self.placeHolder == "Rook" then
		 --moves to the right
		for i=1, 7 do
			if self.x+i < 9 and game.board[self.x+i][self.y] ~= nil then
				moves[#moves+1] = {self.x+i,self.y}
				break
			elseif self.x+i < 9 then
				moves[#moves+1] = {self.x+i,self.y}
			end
		end
		 --moves to the left
		for i=1, 7 do 
			if self.x-i > 0 and game.board[self.x-i][self.y] ~= nil then
				moves[#moves+1] = {self.x-i,self.y}
				break
			elseif self.x-i > 0 then
				moves[#moves+1] = {self.x-i,self.y}
			end
		end
		--moves forward
		for i=1, 7 do
			if self.y+i < 9 and game.board[self.x][self.y+i] ~= nil then
				moves[#moves+1] = {self.x,self.y+i}
				break
			elseif self.y+i < 9 then
				moves[#moves+1] = {self.x,self.y+i}
			end
		end
		--moves backward
		for i=1, 7 do
			if self.y-i > 0 and game.board[self.x][self.y-i] ~= nil then
				moves[#moves+1] = {self.x,self.y-i}
				break
			elseif self.y-i > 0 then
				moves[#moves+1] = {self.x,self.y-i}
			end
		end
	--Possible moves for Knights
	elseif self.placeHolder == "Knight" then
		if self.y-1 > 0 then --down 1 over 2
			if self.x-3 > 0 then
				moves[#moves+1] = {self.x-2,self.y-1}
			end
			if self.x+3 < 9 then
				moves[#moves+1] = {self.x+2,self.y-1}
			end
		end
		if self.y+1 < 9 then --up 1 over 2
			if self.x-3 > 0 then
				moves[#moves+1] = {self.x-2,self.y+1}
			end
			if self.x+3 < 9 then
				moves[#moves+1] = {self.x+2,self.y+1}
			end
		end
		if self.x+1 < 9 then --right 1 up/down 2
			if self.y-3 > 0 then
				moves[#moves+1] = {self.x+1,self.y-2}
			end
			if self.y+3 < 9 then
				moves[#moves+1] = {self.x+1,self.y+2}
			end
		end
		if self.x-1 > 0 then --left 1 up/down 2
			if self.y-3 > 0 then
				moves[#moves+1] = {self.x-1,self.y-2}
			end
			if self.y+3 < 9 then
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
				moves[#moves+1] = {self.x-i, self.y+i}
			end
			--Top Right diagonal
			if not topRight and self.x+i > 0 and self.y+i < 9 then
				if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
					topRight = true
				end
				moves[#moves+1] = {self.x+i, self.y+i}
			end
			--Bottom Left diagonal
			if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
				if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
					bottomLeft = true
				end
				moves[#moves+1] = {self.x-i, self.y-i} 
			end
			--Bottom Right diagonal
			if not bottomRight and self.x+i < 9 and self.y-i > 0 then
				if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
					bottomRight = true
				end
				moves[#moves+1] = {self.x+i, self.y-i}
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
				moves[#moves+1] = {self.x-i, self.y+i}
			end
			--Top Right diagonal
			if not topRight and self.x+i > 0 and self.y+i < 9 then
				if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
					topRight = true
				end
				moves[#moves+1] = {self.x+i, self.y+i}
			end
			--Bottom Left diagonal
			if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
				if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
					bottomLeft = true
				end
				moves[#moves+1] = {self.x-i, self.y-i} 
			end
			--Bottom Right diagonal
			if not bottomRight and self.x+i < 9 and self.y-i > 0 then
				if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
					bottomRight = true
				end
				moves[#moves+1] = {self.x+i, self.y-i}
			end
			--Forward
			if not top and self.y+i < 9 then
				if game.board[self.x][self.y+i] ~= nil then --if Space is occupied
					bottomRight = true
				end
				moves[#moves+1] = {self.x, self.y+i}
			end
		end
	--Possible moves for the King
	elseif self.placeHolder == "King" then
	
	end
	return moves
end
--"Main"
local pawn1 = Piece:new({placeHolder="Queen",x=4,y=4,color="White"})
print("running")
local moves = pawn1:possibleMoves()
for i=1, #moves do
	print("["..moves[i][1]..","..moves[i][2].."]")
end
--print(#moves)

