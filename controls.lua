mousePositions = {downX = 0,downY = 0,x = 0, y = 0}
inputMode = "mouse"
--local GamepadSensitivity = 500
--local UseGamepad = true
local mouseReleaseTimes = 0

if (love.system.getOS() == "NX" or love.system.getOS() == "Horizon" or love.system.getOS() == "iOS" or love.system.getOS() == "Android") then
    inputMode = "touch"
else
    inputMode = "mouse"
end

function Mouse_Update()
    --if love.joystick:getJoystickCount() > 0 and UseGamepad then
    --    inputMode = "gamepad"
    --    mousePositions.downX, mousePositions.downY = 0,0
    --    Joystick = love.joystick:getJoysticks()[1]
    --else
        --inputMode = "mouse"
    --end

    if inputMode == "mouse" then
        mousePositions.x, mousePositions.y = love.mouse.getPosition()
    elseif inputMode == "touch" and love.touch.getTouches()[1] ~= nil then
        mousePositions.x, mousePositions.y = love.touch.getPosition(love.touch.getTouches()[1])
    elseif inputMode == "gamepad" then
        --if (math.floor(dotVelocity.x) < 2 and math.floor(dotVelocity.x) > -2) or (math.floor(dotVelocity.y) < 2 and math.floor(dotVelocity.y) > -2) then rayLine.show = true else rayLine.show = false end
        --print(math.floor(dotVelocity.x).." "..math.floor(dotVelocity.y))
        --mousePositions.x, mousePositions.y = Joystick:getAxis(1)*GamepadSensitivity, Joystick:getAxis(2)*GamepadSensitivity
    end
end

function love.mousepressed(x,y,button)
    --if inputMode == "gamepad" then inputMode = "mouse" UseGamepad = false end

    if inputMode == "mouse" then
        mousePositions.downX, mousePositions.downY = love.mouse.getPosition()
        rayLine.show = true
    end
    if Gamestate.Died then ResetGame() end
    if Gamestate.Menu then StartGame() end
end

function love.mousereleased(x,y,button)
    if inputMode == "mouse" then
        rayLine.show = false
        launchSelectedDot()
        mouseReleaseTimes = mouseReleaseTimes + 1
        if mouseReleaseTimes > 1 and Invincible then Invincible = false end
    end
end




function love.touchpressed(id, x, y, dx, dy, pressure)
    if inputMode == "gamepad" then inputMode = "touch" UseGamepad = false end

    if inputMode == "touch" then
        mousePositions.downX, mousePositions.downY = love.touch.getPosition(id)
        rayLine.show = true
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if inputMode == "touch" then
        rayLine.show = false
        launchSelectedDot()
        mouseReleaseTimes = mouseReleaseTimes + 1
        if mouseReleaseTimes > 1 and Invincible then Invincible = false end
    end
        if Gamestate.Died then ResetGame() end
        if Gamestate.Menu then StartGame() end
end




function love.gamepadreleased(joystick, button)
    --if button == "a" and inputMode == "gamepad" then
    --    launchSelectedDot()
    --end
end

function love.gamepadpressed(joystick,button)
    --if inputMode == "touch" or inputMode == "mouse" then inputMode = "gamepad" UseGamepad = true end

    if button == "start" then
        love.event.quit()
    end
    



end

function ResetMouseReleaseTimes()
    mouseReleaseTimes = 0
end