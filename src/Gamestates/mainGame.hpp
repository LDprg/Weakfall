//
// Created by LD on 29.03.2023.
//
#pragma once

#include "../Game/Game.hpp"

#include "../Object/Tile.hpp"

class mainGame : public GameState {
public:
    mainGame()
    : tile(sf::Vector2f(200, 200), "assets/img/Gass.png") {
    }

    void event(sf::Event& event) override {
    }

    void update() override {

    }

    void draw() override {
        game->getWindow().draw(tile);
    }
private:
    Tile tile;
};