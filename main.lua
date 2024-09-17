_G.love = require("love")

function love.load()
    width, height = love.graphics.getDimensions()
    flappy = {}
    flappy.x = 100
    flappy.y = height/2
    flappy.r = 15
    flappy.jump = 200
    _G.gravity_speed = 100
    obstacle = {}
    obstacle.x = 500
    obstacle.y = 0
    obstacle.width = 50
    obstacle.height = 300
end

function love.update(dt)
    flappy.y = flappy.y + gravity_speed * dt
    if love.keyboard.isDown("space") then
        flappy.y = flappy.y - (flappy.jump * dt)*2
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", flappy.x, flappy.y, flappy.r)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
end
