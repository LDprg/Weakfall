//
// Created by LD on 29.03.2023.
//
#pragma once

#include <SFML/Graphics.hpp>

class Tile : public sf::Drawable {
public:
    Tile(sf::Vector2f position, const std::string& image)
    {
        texture.loadFromFile(image);
        sprite.setTexture(texture);
        sprite.setPosition(position);
        sprite.setOrigin(texture.getSize().x / 2, texture.getSize().y / 2);
        sprite.setScale(0.5, 0.5);
    }

    void draw(sf::RenderTarget& target, sf::RenderStates states) const override {
        target.draw(sprite, states);
    }
private:
    sf::Sprite sprite;
    sf::Texture texture;
};
