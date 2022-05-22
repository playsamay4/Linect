mousePositions = {downX = 0,downY = 0,x = 0, y = 0}
inputMode = "mouse"

if (love.system.getOS() == "NX" or love.system.getOS() == "Horizon" or love.system.getOS() == "iOS" or love.system.getOS() == "Android") then
    inputMode = "touch"
else
    inputMode = "mouse"
end

function Mouse_Update()

    if inputMode == "mouse" then
        mousePositions.x, mousePositions.y = love.mouse.getPosition()
    elseif inputMode == "touch" and love.touch.getTouches()[1] ~= nil then
        mousePositions.x, mousePositions.y = love.touch.getPosition(love.touch.getTouches()[1])
    end

end

function love.mousepressed(x,y,button)
    if inputMode == "mouse" then
        mousePositions.downX, mousePositions.downY = love.mouse.getPosition()
        rayLine.show = true
    end
end

function love.mousereleased(x,y,button)
    if inputMode == "mouse" then
        rayLine.show = false
        launchSelectedDot()
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    if inputMode == "touch" then
        mousePositions.downX, mousePositions.downY = love.touch.getPosition(id)
        rayLine.show = true
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if inputMode == "touch" then
        rayLine.show = false
        launchSelectedDot()
    end
end


