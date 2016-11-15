local g = require "Game"
--"Main"
print("Running!")
local game = Game:new({}) --Variable for the game
game:setupGame()

game:displayBoard()

-- moves = game.board[2][1]:possibleMoves(game)
-- moves = game.board[2][1]:checkMoves(game, moves)

--game:printBoard()

-- game.whitePieces.knight1:move(game,3,3)
-- game:printBoard()

-- game.board[5][7]:move(game,5,5)
-- game:printBoard()

-- game.whitePieces.knight2:move(game,6,3)
-- game:printBoard()

-- game.board[6][8]:move(game,3,5)
-- game:printBoard()

-- game.board[3][3]:move(game,4,5)
-- game:printBoard()

-- game.board[3][7]:move(game,3,6)
-- game:printBoard()

-- game.board[6][3]:move(game,5,5)
-- game:printBoard()

-- game.board[5][2]:move(game,5,4)
-- game:printBoard()

-- game.board[4][1]:move(game,7,4)
-- game:printBoard()

-- game.whitePieces.queen:move(game,7,7)
-- game:printBoard()

-- game.whitePieces.queen:move(game,7,8)
-- game:printBoard()

-- game.board[4][8]:move(game,5,7)

 