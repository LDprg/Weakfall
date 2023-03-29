//
// Created by LD on 29.03.2023.
//
#include "Game/Game.hpp"
#include "Gamestates/Test.hpp"

int main()
{
    Game game("Weakfall", {1000, 800});

    game.run<Test>();

    return 0;
}