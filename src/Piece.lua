--Piece Class		
Piece = {placeHolder="Pawn",color="Grey",x=-1,y=-1,hasMoved=false}
Piece.metatable = {}
Piece.metatable.__index = Piece
function Piece:new(newObj)
	return setmetatable(newObj, Piece.metatable)
end
function Piece:possibleMoves(game)
	if game ~= nil then
		if self.x > 0 and self.y > 0 then
			local moves = {}
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
						
						if self.x+1 < 9 and game.board[self.x+1][self.y-1] ~= nil and game.board[self.x+1][self.y-1].color ~= self.color then --space to right diagonal is occupied with an enemy
							moves[#moves + 1] = {self.x+1,self.y-1}
						end
						if self.x-1 > 0 and game.board[self.x-1][self.y-1] ~= nil and game.board[self.x-1][self.y-1].color ~= self.color then --space to left diagonal is occupied with an enemy
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
						if self.x+1 < 9 and game.board[self.x+1][self.y+1] ~= nil and game.board[self.x+1][self.y+1].color ~= self.color then --space to right diagonal is occupied
							moves[#moves + 1] = {self.x+1,self.y+1}
						end
						if self.x-1 > 0 and game.board[self.x-1][self.y+1] ~= nil and game.board[self.x-1][self.y+1].color ~= self.color then --space to left diagonal is occupied
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
						if game.board[self.x][self.y+i] == nil or game.board[self.x][self.y+i].color ~= self.color then --prevents rook from friendly fire
							moves[#moves+1] = {self.x, self.y+i}
						end
					end
					--Backward
					if not bottom and self.y-i > 0 then
						if game.board[self.x][self.y-i] ~= nil then --if Space is occupied
							bottom = true
						end
						if game.board[self.x][self.y-i] == nil or game.board[self.x][self.y-i].color ~= self.color then --prevents rook from friendly fire
							moves[#moves+1] = {self.x, self.y-i}
						end
					end
					--Right
					if not right and self.x+i < 9 then
						if game.board[self.x+i][self.y] ~= nil then --if Space is occupied
							right = true
						end
						if game.board[self.x+i][self.y] == nil or game.board[self.x+i][self.y].color ~= self.color then --prevents rook from friendly fire
							moves[#moves+1] = {self.x+i, self.y}
						end
					end
					--Left
					if not left and self.x-i > 0 then
						if game.board[self.x-i][self.y] ~= nil then --if Space is occupied
							left = true
						end
						if game.board[self.x-i][self.y] == nil or game.board[self.x-i][self.y].color ~= self.color then --prevents rook from friendly fire
							moves[#moves+1] = {self.x-i, self.y}
						end
					end
				end
			--Possible moves for Knights
			elseif self.placeHolder == "Knight" then
				if self.y-1 > 0 then --down 1 over 2
					if self.x-2 > 0 and (game.board[self.x-2][self.y-1] == nil or game.board[self.x-2][self.y-1].color ~= self.color) then
						moves[#moves+1] = {self.x-2,self.y-1}
					end
					if self.x+2 < 9 and (game.board[self.x+2][self.y-1] == nil or game.board[self.x+2][self.y-1].color ~= self.color) then
						moves[#moves+1] = {self.x+2,self.y-1}
					end
				end
				if self.y+1 < 9 then --up 1 over 2
					if self.x-2 > 0 and (game.board[self.x-2][self.y+1] == nil or game.board[self.x-2][self.y+1].color ~= self.color) then
						moves[#moves+1] = {self.x-2,self.y+1}
					end
					if self.x+2 < 9 and (game.board[self.x+2][self.y+1] == nil or game.board[self.x+2][self.y+1].color ~= self.color) then
						moves[#moves+1] = {self.x+2,self.y+1}
					end
				end
				if self.x+1 < 9 then --right 1 up/down 2
					if self.y-2 > 0 and (game.board[self.x+1][self.y-2] == nil or game.board[self.x+1][self.y-2].color ~= self.color) then
						moves[#moves+1] = {self.x+1,self.y-2}
					end
					if self.y+2 < 9 and (game.board[self.x+1][self.y+2] == nil or game.board[self.x+1][self.y+2].color ~= self.color) then
						moves[#moves+1] = {self.x+1,self.y+2}
					end
				end
				if self.x-1 > 0 then --left 1 up/down 2
					if self.y-2 > 0 and (game.board[self.x-1][self.y-2] == nil or game.board[self.x-1][self.y-2].color ~= self.color) then
						moves[#moves+1] = {self.x-1,self.y-2}
					end
					if self.y+2 < 9 and (game.board[self.x-1][self.y+2] == nil or game.board[self.x-1][self.y+2].color ~= self.color) then
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
						if game.board[self.x-i][self.y+i] == nil or game.board[self.x-i][self.y+i].color ~= self.color then --prevents bishops from friendly fire
							moves[#moves+1] = {self.x-i, self.y+i}
						end
					end
					--Top Right diagonal
					if not topRight and self.x+i < 9 and self.y+i < 9 then
						if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
							topRight = true
						end
						if game.board[self.x+i][self.y+i] == nil or game.board[self.x+i][self.y+i].color ~= self.color then --prevents bishops from friendly fire
							moves[#moves+1] = {self.x+i, self.y+i}
						end
					end
					--Bottom Left diagonal
					if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
						if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
							bottomLeft = true
						end
						if game.board[self.x-i][self.y-i] == nil or game.board[self.x-i][self.y-i].color ~= self.color then --prevents bishops from friendly fire
							moves[#moves+1] = {self.x-i, self.y-i} 
						end
					end
					--Bottom Right diagonal
					if not bottomRight and self.x+i < 9 and self.y-i > 0 then
						if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
							bottomRight = true
						end
						if game.board[self.x+i][self.y-i] == nil or game.board[self.x+i][self.y-i].color ~= self.color then --prevents bishops from friendly fire
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
						if game.board[self.x-i][self.y+i] == nil or game.board[self.x-i][self.y+i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x-i, self.y+i}
						end
					end
					--Top Right diagonal
					if not topRight and self.x+i < 9 and self.y+i < 9 then
						if  game.board[self.x+i][self.y+i] ~= nil then --if Space is occupied
							topRight = true
						end
						if game.board[self.x+i][self.y+i] == nil or game.board[self.x+i][self.y+i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x+i, self.y+i}
						end
					end
					--Bottom Left diagonal
					if not bottomLeft and self.x-i > 0 and self.y-i > 0 then
						if game.board[self.x-i][self.y-i] ~= nil then --if Space is occupied
							bottomLeft = true
						end
						if game.board[self.x-i][self.y-i] == nil or game.board[self.x-i][self.y-i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x-i, self.y-i} 
						end
					end
					--Bottom Right diagonal
					if not bottomRight and self.x+i < 9 and self.y-i > 0 then
						if game.board[self.x+i][self.y-i] ~= nil then --if Space is occupied
							bottomRight = true
						end
						if game.board[self.x+i][self.y-i] == nil or game.board[self.x+i][self.y-i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x+i, self.y-i}
						end
					end
					--Forward
					if not top and self.y+i < 9 then
						if game.board[self.x][self.y+i] ~= nil then --if Space is occupied
							top = true
						end
						if game.board[self.x][self.y+i] == nil or game.board[self.x][self.y+i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x, self.y+i}
						end
					end
					--Backward
					if not bottom and self.y-i > 0 then
						if game.board[self.x][self.y-i] ~= nil then --if Space is occupied
							bottom = true
						end
						if game.board[self.x][self.y-i] == nil or game.board[self.x][self.y-i].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x, self.y-i}
						end
					end
					--Right
					if not right and self.x+i < 9 then
						if game.board[self.x+i][self.y] ~= nil then --if Space is occupied
							right = true
						end
						if game.board[self.x+i][self.y] == nil or game.board[self.x+i][self.y].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x+i, self.y}
						end
					end
					--Left
					if not left and self.x-i > 0 then
						if game.board[self.x-i][self.y] ~= nil then --if Space is occupied
							left = true
						end
						if game.board[self.x-i][self.y] == nil or game.board[self.x-i][self.y].color ~= self.color then --prevents queen from friendly fire
							moves[#moves+1] = {self.x-i, self.y}
						end
					end
				end
			--Possible moves for the King
			elseif self.placeHolder == "King" then
				if self.y+1 < 9 and (game.board[self.x][self.y+1] == nil or game.board[self.x][self.y+1].color ~= self.color)  then --forward
					moves[#moves+1] = {self.x, self.y + 1}
				end
				if self.y-1 > 0  and (game.board[self.x][self.y-1] == nil or game.board[self.x][self.y-1].color ~= self.color)then --backward
					moves[#moves+1] = {self.x, self.y - 1}
				end
				if self.x+1 < 9  and (game.board[self.x+1][self.y] == nil or game.board[self.x+1][self.y].color ~= self.color)then --right
					moves[#moves+1] = {self.x + 1, self.y}
				end
				if self.x-1 > 0  and (game.board[self.x-1][self.y] == nil or game.board[self.x-1][self.y].color ~= self.color)then --left
					moves[#moves+1] = {self.x - 1, self.y}
				end
			end
			return moves
		else
			print("Error, "..self.placeHolder.." is dead")
		end
	else
		print("Error, game is nil")
	end
end
function Piece:checkMoves(game, possibleMoves) --Checks that a move doesn't put the King in check
	local x = self.x --The Piece's original x location
	local y = self.y --The Piece's original x location
	local badMoves = {}
	for i=1, #possibleMoves do
		local newX = possibleMoves[i][1] --Where the Piece is trying to move to (X)
		local newY = possibleMoves[i][2] --Where the Piece is trying to move to (Y)
		local piece = game.board[newX][newY] --The Piece that is already in that spot (or nil)
		self:moveTo(game, newX, newY) --Temporarily moves the Piece to the possible location
		
		if self.color == "White" then
			local kingX = game.whitePieces.king.x 
			local kingY = game.whitePieces.king.y
			
			for key, value in pairs(game.blackPieces) do --check that black cannot take the King next turn
				if game.blackPieces[key].x > 0 then 
					enemyMoves = game.blackPieces[key]:possibleMoves(game)
					for z=1, #enemyMoves do
						if kingX == enemyMoves[z][1] and kingY == enemyMoves[z][2] then
							badMoves[i] = i
							break
						end
					end
				end
			end			
		end
		if self.color == "Black" then
			local kingX = game.blackPieces.king.x 
			local kingY = game.blackPieces.king.y
			for key, value in pairs(game.whitePieces) do --check that white cannot take the King next turn
				if game.whitePieces[key].x > 0 then
					enemyMoves = game.whitePieces[key]:possibleMoves(game)
					for z=1, #enemyMoves do
						if kingX == enemyMoves[z][1] and kingY == enemyMoves[z][2] then
							badMoves[i] = i
							break
						end
					end
				end
			end			
		end
		self:moveTo(game, x, y) --Puts everything back where it started
		if piece ~= nil then
			piece:moveTo(game, newX, newY)			
		else
			game.board[newX][newY] = nil
		end
		
	end
	goodMoves = {}
	for i=1, #possibleMoves do				
		if badMoves[i] == nil then
			goodMoves[#goodMoves+1] = possibleMoves[i]
		end
	end
	return goodMoves
end
function Piece:moveTo(game,x,y) --Only used to check move validity
	if self.x > 0 and self.y > 0 then 
		game.board[self.x][self.y] = nil
	end
	self.x = x
	self.y = y
	if game.board[x][y] ~= nil then
		game.board[x][y].x = -1
		game.board[x][y].y = -1
	end
	game.board[x][y] = self
end
function Piece:move(game, x, y) --Used to move pieces during the game
	local possibleMoves = self:possibleMoves(game)
	possibleMoves = self:checkMoves(game, possibleMoves)
	for i=1, #possibleMoves do
		if x == possibleMoves[i][1] and y == possibleMoves[i][2] then --if it is a possible move
			self.hasMoved = true
			self:moveTo(game,x,y)
			return true
		end
	end
end