require "dotField"
require "ray"
require "selectedDot"
require "mouse"
require "sfx"
require "score"
require "enemies"
require "gamestates"


--[[
    TO DO:
    -Add a meter for how far you can launch the selected dot, based on how many dots you've collected.
    - Add a timer for the game
    - Add sfx for dragging and launching
    - Improve sucky collision detection/hitboxes
]]

function love.update(dt)
    if Gamestate.Game then
        Mouse_Update()
        SelectedDot_Update(dt)
        Ray_Update()
    elseif Gamestate.Menu then
        MenuScreen_Update(dt)
    end
end

function love.draw()
    if Gamestate.Game then
        DotField_Draw()
        Ray_Draw()
        Dots_Draw()
        Score_Draw()
    elseif Gamestate.Died then
        DiedScreen_Draw()
    elseif Gamestate.Menu then
        MenuScreen_Draw()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "r" then
        setDotField()
        randomSelectAsSelected()
    elseif key == "f" then
        addDot()
    end

    if Gamestate.Died then
        ResetGame()
    end

    if Gamestate.Menu then
        StartGame()
    end
end

function love.gamepadpressed(joystick,button)
    if button == "start" then
        love.event.quit()
    end
end