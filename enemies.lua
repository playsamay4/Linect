function addEnemy()
    table.insert(dots,{x = math.random(0, love.graphics.getWidth()),y = math.random(0, love.graphics.getHeight()),radius = 0, isEntering = true, isEnemy = true})
end

function setEnemyField()
    for i = 1, 10, 1 do
        addEnemy()
    end
end


