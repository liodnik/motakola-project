-- Define variables
local screenWidth = 800
local screenHeight = 600
local graveRoadHeight = 100
local backgroundSpeed = 50 -- Adjust this value to change the speed of the scrolling background
local backgroundScroll = 0 -- Initialize background scroll

-- Create player as a local variable
local player = {
  x = screenWidth / 2,
  y = screenHeight - graveRoadHeight - 50, -- Place player above the grave road
  width = 50,
  height = 50,
  speed = 200
}

-- Create stars table
local stars = {}

-- Initialize function
function love.load()
  love.window.setTitle("2D Platformer")
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0, 0, 0)

  -- Generate stars
  for i = 1, 100 do
    local star = {
      x = math.random(0, screenWidth),
      y = math.random(0, screenHeight),
      size = math.random(1, 3)
    }
    table.insert(stars, star)
  end
end

-- Update function
function love.update(dt)
  -- Move background to the left
  backgroundScroll = backgroundScroll + backgroundSpeed * dt
  if backgroundScroll > screenWidth then
    backgroundScroll = 0
  end

  -- Move stars with background
  for _, star in ipairs(stars) do
    star.x = star.x - backgroundSpeed * dt
    if star.x < 0 then
      star.x = screenWidth
    end
  end

  -- Move player horizontally
  if love.keyboard.isDown("left") then
    player.x = player.x - player.speed * dt
  elseif love.keyboard.isDown("right") then
    player.x = player.x + player.speed * dt
  end
end

-- Draw gradient background
local function drawGradientBackground()
  local numSteps = screenHeight
  for i = 0, numSteps do
    local t = i / numSteps
    local r = (1 - t) * 0 + t * 1 -- Interpolates from 0 to 1
    local g = (1 - t) * 0 + t * 0 -- Interpolates from 0 to 0
    local b = (1 - t) * 1 + t * 1 -- Interpolates from 1 to 1
    if t > 0.5 then
      g = (1 - (t - 0.5) * 2) * 0 + (t - 0.5) * 2 * 0.75 -- Interpolates from 0 to 0.75
      b = (1 - (t - 0.5) * 2) * 1 + (t - 0.5) * 2 * 0.8  -- Interpolates from 1 to 0.8
    end
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 0, i * (screenHeight / numSteps), screenWidth, screenHeight / numSteps)
  end
end

-- Draw function
function love.draw()
  -- Draw gradient background
  drawGradientBackground()

  -- Draw stars
  love.graphics.setColor(1, 1, 1)
  for _, star in ipairs(stars) do
    love.graphics.rectangle("fill", star.x, star.y, star.size, star.size)
  end

  -- Draw grave road
  love.graphics.setColor(0.4, 0.4, 0.4)
  love.graphics.rectangle("fill", 0, screenHeight - graveRoadHeight, screenWidth, graveRoadHeight)

  -- Draw player
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end
