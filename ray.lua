rayColor = {0,0,0,0.3}
rayLine = {beginX = 0, endX = 0, beginY = 0, endY = 0, angle = 0, speed = 0.9, show = false}


function Ray_Update()
    if rayLine.show then
        rayLine.beginX, rayLine.beginY = selectedDot.x, selectedDot.y
        rayLine.endX = mousePositions.x - mousePositions.downX + selectedDot.x
        rayLine.endY = mousePositions.y - mousePositions.downY + selectedDot.y
    end
end

function Ray_Draw()
    if rayLine.show and not launchOccuring then
        love.graphics.setColor(rayColor)
        love.graphics.line(rayLine.beginX, rayLine.beginY, rayLine.endX, rayLine.endY)
    end
end