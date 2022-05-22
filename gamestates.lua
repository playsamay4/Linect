Gamestate = {Game = true, Died = false}
DiedScreenFont = love.graphics.newFont("fonts/Quicksand-Bold.ttf",50)

function DiedScreen_Draw()
    love.graphics.setColor(0,0,0,0.3)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setFont(DiedScreenFont)
    love.graphics.setColor(1,1,1)
    if inputMode == "mouse" then
        love.graphics.printf("You died.\nScore: "..score.."\n\nPress any key to retry...",0,250,1280,"center")
    elseif inputMode == "touch" then
        love.graphics.printf("You died.\nScore: "..score.."\n\nTap to retry...",0,250,1280,"center")
    end
end
