_G.love = require("love")

function love.load()
    math.randomseed(os.time())
    width, height = love.graphics.getDimensions()
    jumptimer = 0
    timerSecond = 0
    timerMinute = 0
    Score = 0
    flappy = {}
    flappy.x = width/3
    flappy.y = height/2
    flappy.r = 15
    flappy.jump = 60
    _G.play = true
    _G.condJump = 0
    _G.gravity_speed = 170
    block = {}
    nbBlock = 500                                                                          
    blockWidth = 50
    blockHeight = 300
    blockSpeed = 100
    defaultFont = love.graphics.newFont(20)
    blockLoad()
end

function love.update(dt)
    timer()
    -- gravité
    flappy.y = flappy.y + gravity_speed * dt

    -- jumps 
    jumptimer = jumptimer + love.timer.getDelta()
    if love.mouse.isDown(1) and jumptimer >= 0.2 then
        jumptimer = 0
        flappy.y = flappy.y - flappy.jump 
    end
    if flappy.y + flappy.r <= 0 then
        flappy.y = 0 + flappy.r
    elseif flappy.y + flappy.r >= height then 
        flappy.y = height - flappy.r
    end
    
    --deplacements des blocs
    for i = 0, nbBlock*2 do 
        block[i].x = block[i].x - blockSpeed * dt
    end

    checkCollisions()
end  

function checkCollisions()
    nb = nbBlock
   
    for i = 0, nbBlock * 2 do
        local b = block[i]
        -- Vérifie si flappy est à l'intérieur du bloc en cours
        if flappy.x + flappy.r > b.x and flappy.x - flappy.r < b.x + b.width and
           flappy.y + flappy.r > b.y and flappy.y - flappy.r < b.y + b.height then
            -- Collision détectée
            blockCollision()
            break
        end
    end
end


function blockCollision()
    flappy.x = width/3
    flappy.y = height/2
end

function timer()
    timerFont = love.graphics.newFont(100)
    timerSecond = timerSecond + love.timer.getDelta()
    textTimer = "0" .. tostring(timerMinute) .. ":0" .. tostring(math.floor(timerSecond))
    if timerSecond >= 60 then
        timerSecond = 0
        timerMinute = timerMinute + 1
    elseif timerSecond >= 10 then
        textTimer = "0" .. tostring(timerMinute) .. ":" .. tostring(math.floor(timerSecond))
    elseif timerSecond <= 10 then
        textTimer = "0" .. tostring(timerMinute) .. ":0" .. tostring(math.floor(timerSecond))
    elseif timerMinute >= 10 and timerSecond <= 10 then
        textTimer = tostring(timerMinute) .. ":0" .. tostring(math.floor(timerSecond))
    elseif timerMinute >= 10 and timerSecond >= 10 then
        textTimer = tostring(timerMinute) .. ":" .. tostring(math.floor(timerSecond))
    end
end

function blockLoad()
    block[0] = {x = 1000, y = 0, width = 50, height = 300}
    for blockPos = 1, nbBlock do
        
        yBlock = 0
        xBlock = block[blockPos-1].x + 250
        blockHeight = math.random(200,500)
        block[blockPos] = { x = xBlock,  y = yBlock, width = blockWidth, height = blockHeight}
    
    end 
    for i = nbBlock, nbBlock*2 do
        blockHeight = height - block[i-nbBlock].height - 250
        yBlock = height-blockHeight
        xBlock = block[i-nbBlock].x
        block[i] = { x = xBlock,  y = yBlock, width = blockWidth, height = blockHeight}
    end
end

function blockDraw()
    for b = 0, nbBlock*2 do
        local block = block[b]
        love.graphics.rectangle("fill", block.x, block.y, block.width, block.height)
    end
end


function love.draw()
    love.graphics.setColor(0, 1, 0)
    blockDraw()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(defaultFont)

    love.graphics.print(tostring(nb) .. " Y :" .. tostring(math.floor(flappy.y)), 10, 100)
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", flappy.x, flappy.y, flappy.r)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(timerFont)
    love.graphics.print(textTimer, width/2-150, 10)
end
