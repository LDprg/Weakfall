//
// Created by LD on 29.03.2023.
//
#pragma once

#include <SFML/Graphics.hpp>

#include "Tile.hpp"

class Tilemap : public sf::Drawable {
public:
    Tilemap() {
        tiles.resize(10);
        for (auto& row : tiles) {
            row.resize(10);
        }
    }

    void draw(sf::RenderTarget& target, sf::RenderStates states) const override {
    }

private:
    std::vector<std::vector<Tile>> tiles;
};