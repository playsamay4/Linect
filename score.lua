local score = 0
local scoreFont = love.graphics.newFont("fonts/Quicksand-Bold.ttf", 24)
local scoreNumberFont = love.graphics.newFont("fonts/Quicksand-Bold.ttf",50)

function Score_Draw()
    love.graphics.setColor(0,0,0,0.3)
    love.graphics.setFont(scoreFont)
    love.graphics.rectangle("fill", 30, 30, 100, 100)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Score", 47, 30)
    love.graphics.setFont(scoreNumberFont)
    love.graphics.printf(score, 30, 55, 100, "center")

end

function IncrementScore()
    score = score + 1
end

function ResetScore()
    score = 0
end
