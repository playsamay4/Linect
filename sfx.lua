wallHitSfx = {
    love.audio.newSource("sfx/wallHit1.wav", "static"),
    love.audio.newSource("sfx/wallHit2.wav", "static"),
    love.audio.newSource("sfx/wallHit3.wav", "static"),
}

collectSfx = {
    love.audio.newSource("sfx/collect1.wav", "static"),
    love.audio.newSource("sfx/collect2.wav", "static"),
    love.audio.newSource("sfx/collect3.wav", "static"),
}

function wallHitSfx:play()
    local sfx = wallHitSfx[math.random(1, #wallHitSfx)]
    sfx:play()
end

function collectSfx:play()
    local sfx = collectSfx[math.random(1, #collectSfx)]
    sfx:play()
end