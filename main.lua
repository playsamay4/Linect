require "dotField"
require "ray"
require "selectedDot"
require "mouse"
require "sfx"
require "score"

--[[
    TO DO:
    -Add a meter for how far you can launch the selected dot, based on how many dots you've collected.
    - Add enemies
    - Add a timer for the game
    - Menus/ title screen
    - Add sfx for dragging and launching
    - Improve sucky collision detection/hitboxes
]]


function love.load()
    math.randomseed(os.time())
    setDotField()
    randomSelectAsSelected()
end


function love.update(dt)
    Mouse_Update()
    SelectedDot_Update(dt)
    Ray_Update()
end

function love.draw()
    DotField_Draw()
    Ray_Draw()
    Dots_Draw()
    Score_Draw()

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
end



