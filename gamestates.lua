Gamestate = {Game = true, Died = false}
DiedScreenFont = love.graphics.newFont("fonts/Quicksand-Bold.ttf",50)

function DiedScreen_Draw()
    love.graphics.setColor(0,0,0,0.3)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setFont(DiedScreenFont)
    love.graphics.setColor(1,1,1)
    if inputMode == "mouse" then
        love.graphics.printf("You died.\nScore: "..score.."\n\nPress any key to retry...",0,250,love.graphics.getWidth(),"center")
    elseif inputMode == "touch" then
        love.graphics.printf("You died.\nScore: "..score.."\n\nTap to retry...",0,50,love.graphics.getWidth(),"center")
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