local defaultEnemySpeed = 100
local defaultEnemySpeedLowerBound = 50
local defaultEnemySpeedUpperBound = 150


function addEnemy()
    table.insert(dots,{x = math.random(0, love.graphics.getWidth()),y = math.random(0, love.graphics.getHeight()),radius = 0, isEntering = true, isEnemy = true,xVel = math.random(0,1),yVel = math.random(0,1),enemySpeed = defaultEnemySpeed})
end

function setEnemyField()
    for i = 1, 10, 1 do
        addEnemy()
    end
end

function Enemy_Update(dt)
    for i,v in ipairs(dots) do 
        if v.isEnemy then
            if v.xVel == 0 then v.x = v.x - v.enemySpeed * dt end
            if v.xVel == 1 then v.x = v.x + v.enemySpeed * dt end
            if v.yVel == 0 then v.y = v.y - v.enemySpeed * dt end
            if v.yVel == 1 then v.y = v.y + v.enemySpeed * dt end

            if v.x < 0 then v.xVel = 1 RandomEnemySpeed(i) end
            if v.x > love.graphics.getWidth() then v.xVel = 0 RandomEnemySpeed(i) end
            if v.y < 0 then v.yVel = 1 RandomEnemySpeed(i) end
            if v.y > love.graphics.getHeight() then v.yVel = 0 RandomEnemySpeed(i) end
        end
    end
end

function RandomEnemySpeed(i)
    dots[i].enemySpeed = math.random(defaultEnemySpeedLowerBound,defaultEnemySpeedUpperBound)
end