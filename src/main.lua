local g = require "Game"
--"Main"
print("Running!")
local game = Game:new({}) --Variable for the game
game:setupGame()
moves = game.board[2][1]:possibleMoves(game)
moves = game.board[2][1]:checkMoves(game, moves)
--print(game.board[2][1].placeHolder.." has "..#moves.." moves")
for i=1, #moves do
	print(moves[i][1]..","..moves[i][2])
end