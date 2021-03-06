function love.load()
  --Making MostImportant Variables
  math.randomseed(os.time())
  AiMode = 0

  Game = {}
  Game.Width = 800
  Game.Height = 600
  Game.FullScreen = false
  Game.NegWidth = Game.Width * -1
  Game.Negheight = Game.Height * -1

  --Defining the center of the game field
  OriginPointX = Game.Width / 2
  OriginPointY = Game.Height / 2
  --Player Data
  
  Player1 = {x = OriginPointX - 350, y = OriginPointY + 0, Width = 16, Height = 64,isMoving = 0}
  Player2 = {x = OriginPointX + 350, y = OriginPointY + 0,Width = 16, Height = 64,isMoving = 0}

  --Ball Data
  Ball = {x = OriginPointX,y = OriginPointY,Width = 16,Height = 16,Angle = 0,Speedx = -2,Speedy = 0}
  ----SPACE RESERVED FOR FUNCTIONS
  function CheckInput()
    --KeyBoard Inputs for Player 1
    if love.keyboard.isDown("w")  then
      Player1.y = Player1.y - 2
      Player1.isMoving = 2

    elseif love.keyboard.isDown("s") then
      Player1.y = Player1.y + 2
      Player1.isMoving = 1
    else
    Player1.isMoving = 0
    end


    --Input for Player2 and only works when Ai mode is 0
    if AiMode == 0 then
      if love.keyboard.isDown("up") then
        Player2.y = Player2.y -2
        Player2.isMoving = 1
    
      
    elseif love.keyboard.isDown("down") then
        Player2.y = Player2.y +2
        Player2.isMoving = 2
    else 
      Player2.isMoving = 0
    end

  end

  function BoundaryCheck()
    Player1.bottomcheck = Player1.y + Player1.Height
    if Player1.bottomcheck >= 600 then
      Player1.y = 600 - Player1.Height
    end
    if Player1.y <= 0 then

      Player1.y = 0

    end
    Player2.bottomcheck = Player2.y + Player1.Height
    if Player2.bottomcheck >= 600 then
      Player2.y = 600 - Player2.Height
    end
    if Player2.y <= 0 then

      Player2.y = 0

    end
    function BallPyhsics()
      Ball.x = Ball.Speedx + Ball.x
      Ball.y = Ball.Speedy + Ball.y
  end
    function CollisonCheck(Col1,Col2)
  if Col1.x + Col1.Width == Col2.x + Col2.Width and  Col2.x ~= Col1.x then

    if Col1.y  == Col2.y or Col1.y + Col1.Height <= Col2.y then

      if Col1.isMoving == 0 then
        Col2.Speedx = Col2.Speedx * -1
        Col2.Speedy = 1.25
      end
      if Col1.isMoving == 1 then
        Col2.Speedx = Col2.Speedx * math.random(-0.75,-1.25)
        Col2.Speedy = Col2.Speedy + 2
      end
      if Col1.isMoving == 2 then
        Col2.Speedx = Col2.Speedx * math.random(-0.75,-1.25)
        Col2.Speedy = Col2.Speedy - 2
      end


    end
   end
  end
  end
end




  function Debug(DebugFlag)
		  print("Player cords")
		  print(Player1.x)
		  print(Player1.y)
		  print("BAllCords")
		  print(Ball.x)
		  print(Ball.y)
  end
  function BallBoundry()

    if Ball.y - Ball.Height >= 600 then
      Ball.Speedy = Ball.Speedy * -1
    end 
    if Ball.y - Ball.Height <= 0 then
      Ball.Speedy = Ball.Speedy * -1
    end

  end

  ----SPACE RESVERED END
end

function love.update(dt)
  CheckInput()
  BoundaryCheck()
  BallPyhsics()
  CollisonCheck(Player1,Ball)
  CollisonCheck(Player2,Ball)
  BallBoundry()
  Debug()

  function love.keypressed( key, scancode, isrepeat )
    if key == "escape" then
      if Game.FullScreen == true then
       love.window.setFullscreen(false, "desktop")
       Game.FullScreen = false
    else
        love.window.setFullscreen(true, "desktop")
        Game.FullScreen = true
      end
    end
  end



end
function love.draw()
  love.graphics.push()
  -- scaling Screen
  love.graphics.scale(love.graphics.getWidth() / Game.Width, love.graphics.getHeight() / Game.Height)

  --Makes Debug Shapes Green as they shoud never be seen ingame
  love.graphics.setColor(0, 1, 0, 1)

  --Drawing Player1
  love.graphics.rectangle("fill",Player1.x,Player1.y,Player1.Width, Player1.Height)

  --Drawing Player2
  love.graphics.rectangle("fill",Player2.x,Player2.y,Player2.Width, Player2.Height)

  --Drawing Ball
  love.graphics.rectangle("fill", Ball.x, Ball.y, Ball.Width, Ball.Height)
  
  --Poping graphics
  love.graphics.pop()
end
