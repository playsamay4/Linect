
local dots = {x = 50, y = 50, isSelected = false, launched = false}

local rayLine = {}

local MouseX, MouseY = 0, 0
local SaveMX, SaveMY = 0, 0
local RayBX, RayBY, RayEX, RayEY = 0, 0, 0, 0
local click = false


function love.load()

end

function love.update()
    MouseX, MouseY = love.mouse.getPosition()

    if click then
        RayBX, RayBY = dots.x, dots.y
        RayEX = MouseX - SaveMX + dots.x
        RayEY = MouseY - SaveMY + dots.y
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.9,0.9,0.9)
    
    if click then 
        love.graphics.setColor(0.4,0.4,0.4)
        love.graphics.line(RayBX, RayBY, RayEX, RayEY)
    end
    
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", dots.x, dots.y, 8)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        SaveMX, SaveMY = love.mouse.getPosition()
        click = true
    end 
end

function love.mousereleased(x, y, button)
    if button == 1 then
        click = false
    end
end

