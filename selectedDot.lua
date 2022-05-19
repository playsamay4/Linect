launchSpeed = 5
launchOccuring = false
selectedDot = {id = 1}
dotVelocity = {x = 0, y = 0}
timer = 0
slideFactor = 0.9

function SelectedDot_Update(dt)
    if launchOccuring then timer = timer + dt else timer = 0 end

    for i,dot in ipairs(dots) do
        if dot.isSelected then
            selectedDot.id = i  
            selectedDot.x = dot.x
            selectedDot.y = dot.y
        end

         
    if (dots[i].x ~= nil and selectedDot.x ~= nil) and (i ~= selectedDot.id) and dots[i].isCollected ~= true then
        if ( ( selectedDot.x > dots[i].x-9 ) and (selectedDot.x < dots[i].x+9) ) and ( ( selectedDot.y > dots[i].y-9 ) and (selectedDot.y < dots[i].y+9) )  then 
            collectSfx:play()   
            dots[i].isCollected = true
            --table.remove(dots, i)
            --addDot()
        end
    end

    if (dots[i].isCollected) then
        dots[i].radius = dots[i].radius * 0.8
        if dots[i].radius < 0.1 then
            table.remove(dots, i)
            addDot()
        end
    end 

    if (dots[i].isEntering) then
        dots[i].radius = dots[i].radius + 0.2
        if dots[i].radius > defaultRadius then
            dots[i].isEntering = false
            dots[i].radius = defaultRadius
        end
    end
   
    
        
    end

    dots[selectedDot.id].x = dots[selectedDot.id].x + dotVelocity.x * dt
    dots[selectedDot.id].y = dots[selectedDot.id].y + dotVelocity.y * dt


    dotVelocity.x = dotVelocity.x * slideFactor 
    dotVelocity.y = dotVelocity.y * slideFactor

    if dots[selectedDot.id].x > love.graphics.getWidth() then
        dotVelocity.x = -dotVelocity.x
        dots[selectedDot.id].x = love.graphics.getWidth()
        wallHitSfx:play()
    elseif dots[selectedDot.id].x < 0 then
        dotVelocity.x = -dotVelocity.x
        dots[selectedDot.id].x = 0
        wallHitSfx:play()
    end

    if dots[selectedDot.id].y > love.graphics.getHeight() then
        dotVelocity.y = -dotVelocity.y
        dots[selectedDot.id].y = love.graphics.getHeight()
        wallHitSfx:play()
    elseif dots[selectedDot.id].y < 0 then
        dotVelocity.y = -dotVelocity.y
        dots[selectedDot.id].y = 0
        wallHitSfx:play()
    end

    if timer > 0.1 then
        refocusSelectedDot()
    end


    --print(selectedDot.x, selectedDot.y)
    --print(dots[3].x, dots[3].y)

end 

function Dots_Draw()
    for i,v in ipairs(dots) do
        if not (v.isSelected or v.isLaunched) then
            --Non selected dots
            love.graphics.setColor(dotColor)
            love.graphics.circle("fill", v.x, v.y, v.radius)
            --love.graphics.rectangle("fill",dots[i].x-9, dots[i].y-9, 15, 15)
        end

        if v.isSelected and rayLine.show then
            --Dot when selected and ray is showing
            love.graphics.setColor(selectColor)
            love.graphics.circle("fill", v.x, v.y, 6)
        elseif v.selected then
            --Dot when selected
            love.graphics.setColor(launchColor)
            love.graphics.circle("fill", v.x, v.y, 8)
        elseif v.launched then 
            --Dot when launched
            love.graphics.setColor(launchColor)
            love.graphics.circle("fill", v.x, v.y, 8)
        else

        end
    end 

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

