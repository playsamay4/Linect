Gamestate = {Menu = true, Game = false, Died = false}
local MenuScreenFont = love.graphics.newFont("fonts/Quicksand-Bold.ttf",50)
local menuScreenDots = {x=0,y=0,velX=0,velY=0}
local menuDotSpeed = 100
for i = 0, 30, 1 do
    table.insert(menuScreenDots,{x=math.random(0,love.graphics.getWidth()),y=math.random(0,love.graphics.getHeight()),velX=math.random(0,1),velY=math.random(0,1)})
end



function DiedScreen_Draw()
    love.graphics.setColor(0,0,0,0.3)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setFont(MenuScreenFont)
    love.graphics.setColor(1,1,1)
    if inputMode == "mouse" then
        love.graphics.printf("You died.\nScore: "..GetScore().."\n\nPress any key to retry...",0,250,love.graphics.getWidth(),"center")
    elseif inputMode == "touch" then
        love.graphics.printf("You died.\nScore: "..GetScore().."\n\nTap anywhere to retry...",0,50,love.graphics.getWidth(),"center")
    end
end

function MenuScreen_Update(dt)
    for i,v in ipairs(menuScreenDots) do
        if v.velX == 1 then v.x = v.x + menuDotSpeed * dt end
        if v.velX == 0 then v.x = v.x - menuDotSpeed * dt end

        if v.velY == 1 then v.y = v.y + menuDotSpeed * dt end
        if v.velY == 0 then v.y = v.y - menuDotSpeed * dt end

        if v.x < 0 then v.velX = 1 end
        if v.x > love.graphics.getWidth() then v.velX = 0 end

        if v.y < 0 then v.velY = 1 end
        if v.y > love.graphics.getHeight() then v.velY = 0 end
    end
end

function MenuScreen_Draw()
    love.graphics.setBackgroundColor(0.9,0.9,0.9)

    love.graphics.setColor(1,0,0)
    for i,v in ipairs(menuScreenDots) do
        love.graphics.circle("fill",v.x,v.y,8)
    end


    love.graphics.setColor(0,0,0,0.8)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setFont(MenuScreenFont)
    love.graphics.setColor(1,1,1)
    if inputMode == "mouse" then
        love.graphics.printf("Linect\n\nPress any key to start...",0,250,love.graphics.getWidth(),"center")
    elseif inputMode == "touch" then
        love.graphics.printf("Linect\n\nTap anywhere to start...",0,50,love.graphics.getWidth(),"center")
    end
end

function ResetGame()
    launchSpeed = 5
    launchOccuring = false
    selectedDot = {id = 1}
    dotVelocity = {x = 0, y = 0}
    timer = 0
    slideFactor = 0.9
    Died = false
    mousePositions = {downX = 0,downY = 0,x = 0, y = 0}
    rayColor = {0,0,0,0.3}
    rayLine = {beginX = 0, endX = 0, beginY = 0, endY = 0, angle = 0, speed = 0.9, show = false}
    score = 0

    Gamestate.Died = false
    Gamestate.Game = true
    
    math.randomseed(os.time())
    setDotField()
    setEnemyField()
    randomSelectAsSelected()
end

function StartGame()
    math.randomseed(os.time())
    setDotField()
    setEnemyField()
    randomSelectAsSelected()

    Gamestate.Menu = false
    Gamestate.Game = true
end