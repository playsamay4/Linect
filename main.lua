local dots = {}
local backgroundColor = {0.9,0.9,0.9}
local dotColor = {0.4,0.4,0.4}
local selectColor = {0.9,0,0}
local launchColor = {0.9,0,0}
local rayColor = {0,0,0,0.3}

local rayLine = {beginX = 0, endX = 0, beginY = 0, endY = 0, angle = 0, speed = 0.9, show = false}

local launchOccuring = false

local mousePositions = {downX = 0,downY = 0,x = 0, y = 0}

local selectedDot = {id = 1}

local dotVelocity = {x = 0, y = 0}

local timer = 0

local launchSpeed = 5

--[[
    TO DO:
    -Add a meter for how far you can launch the selected dot, based on how many dots you've collected.
    
]]


function love.load()
    math.randomseed(os.time())
    placeDotField()
    randomSelectAsSelected()
end


function love.update(dt)
    if launchOccuring then timer = timer + dt else timer = 0 end
    mousePositions.x, mousePositions.y = love.mouse.getPosition()


    if rayLine.show then
        rayLine.beginX, rayLine.beginY = selectedDot.x, selectedDot.y
        rayLine.endX = mousePositions.x - mousePositions.downX + selectedDot.x
        rayLine.endY = mousePositions.y - mousePositions.downY + selectedDot.y
    end


    for i,dot in ipairs(dots) do
        if dot.isSelected then
            selectedDot.id = i  
            selectedDot.x = dot.x
            selectedDot.y = dot.y
        end
        
    end

    if launchOccuring then
        dots[selectedDot.id].x = dots[selectedDot.id].x + dotVelocity.x * dt
        dots[selectedDot.id].y = dots[selectedDot.id].y + dotVelocity.y * dt
    end


    dotVelocity.x = dotVelocity.x * 0.9
    dotVelocity.y = dotVelocity.y * 0.9

    if timer > 1 then
        refocusSelectedDot()
    end

    print(dotVelocity.x)

end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor)

    if rayLine.show and not launchOccuring then
        love.graphics.setColor(rayColor)
        love.graphics.line(rayLine.beginX, rayLine.beginY, rayLine.endX, rayLine.endY)
    end

    for i,v in ipairs(dots) do
        if v.isSelected and rayLine.show then
            love.graphics.setColor(selectColor)
            love.graphics.circle("fill", v.x, v.y, 6)
        elseif v.selected then
            love.graphics.setColor(launchColor)
            love.graphics.circle("fill", v.x, v.y, 8)
        elseif v.launched then 
            love.graphics.setColor(launchColor)
            love.graphics.circle("fill", v.x, v.y, 8)
        else
            love.graphics.setColor(dotColor)
            love.graphics.circle("fill", v.x, v.y, 5)
        end
    end 


end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "r" then
        placeDotField()
        randomSelectAsSelected()
    elseif key == "f" then
        addDot()
    elseif key == "space" then
        launchSelectedDot()
    end
end

function love.mousepressed(x,y,button)
    mousePositions.downX, mousePositions.downY = love.mouse.getPosition()
    rayLine.show = true
end

function love.mousereleased(x,y,button)
    rayLine.show = false
    launchSelectedDot()
end


function placeDotField()
    dots = {}
    for i=1, 30, 1 do
        addDot()
    end
end

function addDot()
    table.insert(dots, {x = math.random(0, love.graphics.getWidth()), y = math.random(0, love.graphics.getHeight())})
end

function refocusSelectedDot()
    dots[selectedDot.id].isSelected = true
    launchOccuring = false
end

function launchSelectedDot()
    for i,v in ipairs(dots) do
        if v.isSelected then
            v.isSelected = false
            v.launched = true
            --If the mouse ends up left of the dot, then the velocity is negative
            if mousePositions.x < mousePositions.downX then
                dotVelocity.x = -math.sqrt( (rayLine.beginX-selectedDot.x)^2 + (rayLine.endX-selectedDot.x)^2 )*launchSpeed
            else
                dotVelocity.x = math.sqrt( (rayLine.beginX-selectedDot.x)^2 + (rayLine.endX-selectedDot.x)^2 )*launchSpeed
            end

            --If the mouse ends up above the dot, then the velocity is negative
            if mousePositions.y < mousePositions.downY then
                dotVelocity.y = -math.sqrt( (rayLine.beginY-selectedDot.y)^2 + (rayLine.endY-selectedDot.y)^2 )*launchSpeed
            else
                dotVelocity.y = math.sqrt( (rayLine.beginY-selectedDot.y)^2 + (rayLine.endY-selectedDot.y)^2 )*launchSpeed
            end

            launchOccuring = true
        end
    end

end

function randomSelectAsSelected()
    local selected = math.random(1, #dots)
    dots[selected].isSelected = true
    rayLine.originX = dots[selected].x
    rayLine.originY = dots[selected].y
    rayLine.endX = dots[selected].x + 100
    rayLine.endY = dots[selected].y + 100
end



