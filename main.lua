io.stdout:setvbuf("no")

-- create rectangles
local rct      = {}
local rct_up   = {}

-- Load some default values for our rectangle.
function love.load()
    WW, WH = 650, 360
    h0 = 100

    font = love.graphics.newFont("GILLUBCD.TTF", 20)
    font2 = love.graphics.newFont("ITCKRIST.TTF", 10)

    -- rct.y is the reference, variable that if it changes, other variables changes
    -- down rectangle
    rct.y = WH/2 - h0/2
    rct.x = WW/2 - h0/2
    rct.w, rct.h = h0, h0 -- math.sqrt(rct_up.w^2 - rct_up.h^2)
    -- upper rectangle
    rct_up.w, rct_up.h = h0, 0
    rct_up.x, rct_up.y = rct.x, rct.y

    love.window.setMode(WW, WH, {fullscreen = false, resizable = false, vsync = true})
end

-- Move the rectangle every frame.
function love.update(dt)
    if love.keyboard.isDown("up") then
        rct.y =    (rct.y - 50*dt - (WH/2-h0/2)) % h0 + (WH/2-h0/2)
        rct.h =    (rct.h + 50*dt + h0) % h0
        rct_up.h = math.sqrt(h0^2 - rct.h^2)
        rct_up.y = rct.y - rct_up.h

        -- translate rectangles to center the axis
        -- rct.y = rct_up.y + rct_up.h
        -- rct_up.y = rct_up.y + 0.5*(WH + h0 - (rct.y + rct_up.y))

    elseif love.keyboard.isDown("down") then
        rct.y =    (rct.y + 50*dt - (WH/2-h0/2)) % h0 + (WH/2-h0/2)
        rct.h =    (rct.h - 50*dt + h0) % h0
        rct_up.h = math.sqrt(h0^2 - rct.h^2)
        rct_up.y = rct.y - rct_up.h

        -- translate rectangles to center the axis
        --rct.y = rct_up.y + rct_up.h
        --rct_up.y = rct_up.y + 0.5*(WH + h0 - (rct.y + rct_up.y))
    end
end

-- Draw a coloured circle.
function love.draw(dt)
    love.graphics.setBackgroundColor(0.5, 0.5, 0.4) -- (0.93, 0.67, 0.55)
    -- sky
    love.graphics.setColor(0.50, 0.70, 0.70) -- (0.91, 0.71, 0.30)
    love.graphics.rectangle("fill", 0, 0, WW, WH/2 + h0/2 - 20)
    -- rct up
    love.graphics.setColor(1.0*(rct_up.y)/rct.y, 1.0*rct_up.y/rct.y, 0.9*rct_up.y/rct.y)
    love.graphics.rectangle("fill", rct_up.x, rct_up.y, rct_up.w, rct_up.h)
    -- love.graphics.circle("fill", rct.x, rct.y, 50)
    -- rct down
    love.graphics.setColor(1-rct.y/(WH/2+h0/2)/1.2 + 0.1, 1-rct.y/(WH/2+h0/2)/1.2 + 0.1, 1-rct.y/(WH/2+h0/2)/1.2)
    love.graphics.rectangle("fill", rct.x, rct.y, rct.w, rct.h)
    -- love.graphics.circle("fill", 50,100, (rct.y-180)*0.8)
    text = "Pixel " .. rct_up.y .. "."
    if rct.w*rct.h < 10 or rct_up.w*rct_up.h < 10 then
        love.graphics.setFont(font)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("BOOM", 0, WH/4 , WW, 'center')
    end
end