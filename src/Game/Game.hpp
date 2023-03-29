//
// Created by LD on 29.03.2023.
//
#pragma once

#include <memory>

#include <SFML/Graphics.hpp>

class Game;

class GameState {
public:
    virtual ~GameState() = default;

    virtual void init() { }

    virtual void update() = 0;
    virtual void draw() = 0;
    virtual void event(sf::Event& event) = 0;

    void setGame(Game* pGame)
    {
        this->game = pGame;
    }

protected:
    Game* game{};
};

template<typename State>
concept GameStateConcept = requires() {
    std::is_base_of_v<GameState, State>;
};

class Game {
public:
    explicit Game(const std::string& title = "SFML works!", const sf::Vector2u size = {1920, 1080}) {
        window.create(sf::VideoMode(size.x, size.y), title);
    }

    ~Game() {
        window.close();
    }

    void run()
    {
        while (window.isOpen())
        {
            sf::Event event{};
            while (window.pollEvent(event))
            {
                gameState->event(event);

                if (event.type == sf::Event::Closed)
                    window.close();
            }

            gameState->update();

            window.clear(sf::Color::White);
            gameState->draw();
            window.display();
        }
    }

    template<GameStateConcept state>
    void change()
    {
        gameState = std::make_unique<state>();
        gameState->setGame(this);

        gameState->init();
    }

    template<GameStateConcept state>
    void run()
    {
        change<state>();
        run();
    }

    sf::RenderWindow& getWindow()
    {
        return window;
    }

private:
    sf::RenderWindow window;
    std::unique_ptr<GameState> gameState;
};
