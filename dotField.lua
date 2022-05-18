dots = {{x = 0, y = 0, isSelected = false}}
backgroundColor = {0.9,0.9,0.9}
dotColor = {0.4,0.4,0.4}
selectColor = {0.9,0,0}
launchColor = {0.9,0,0}



function setDotField()
    dots = {}
    for i=1, 30, 1 do
        addDot()
    end
end

function addDot()
    table.insert(dots, {x = math.random(0, love.graphics.getWidth()), y = math.random(0, love.graphics.getHeight())})
end

function DotField_Draw()
    love.graphics.setBackgroundColor(backgroundColor)
end