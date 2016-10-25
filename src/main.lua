local g = require "Game"
--"Main"
print("Running!")
local game = Game:new({}) --Variable for the game
game:setupGame()
print(game.board[1][1].placeHolder)