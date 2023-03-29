//
// Created by LD on 29.03.2023.
//
#pragma once

#include "../Game/Game.hpp"
#include "mainGame.hpp"

class Test : public GameState {
public:
    Test(){
        shape.setRadius(100.f);
        shape.setFillColor(sf::Color::Green);
    }

    void init() override {
        game->change<mainGame>();
    }

    void event(sf::Event& event) override {
    }

    void update() override {

    }

    void draw() override {
        game->getWindow().draw(shape);
    }
private:
    sf::CircleShape shape;
};