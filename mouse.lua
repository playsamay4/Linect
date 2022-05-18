mousePositions = {downX = 0,downY = 0,x = 0, y = 0}

function Mouse_Update()
    mousePositions.x, mousePositions.y = love.mouse.getPosition()
end

function love.mousepressed(x,y,button)
    mousePositions.downX, mousePositions.downY = love.mouse.getPosition()
    rayLine.show = true
end

function love.mousereleased(x,y,button)
    rayLine.show = false
    launchSelectedDot()
end
