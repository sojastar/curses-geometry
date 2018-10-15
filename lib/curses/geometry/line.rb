module Line
  
  ### CONSTANTS :
  BOTTOM_LEFT_TO_TOP_RIGHT_GLYPH  = '/'
  TOP_LEFT_TO_BOTTOM_RIGHT_GLYPH  = '\\'
  HORIZONTAL_GLYPH                = '-'
  VERTICAL_GLYPH                  = '|'
  

  ### METHODS :
  def draw_horizontal_line(x1, x2, y)
    if x1 < x2 then min_x, max_x = x1, x2
    else            min_x, max_x = x2, x1
    end
    
    glyph = get_graphic_context[:stroke_glyph]
    setpos(y, min_x)
    min_x.upto(max_x) do |x|
      addch(glyph)
    end  
  end 

  def draw_vertical_line (x, y1, y2)
    if y1 < y2 then min_y, max_y = y1, y2
    else            min_y, max_y = y2, y1
    end

    glyph = get_graphic_context[:stroke_glyph]
    min_y.upto(max_y) do |y|
      setpos(y,x)
      addch(glyph)
    end
  end 

  def draw_line(x1, y1, x2, y2)

    # Set-up of the bresenham algorythm :
    x,   y = x1, y1
    dx, dy = x2 - x1, y2 - y1

    x_increment = dx > 0 ? 1 : -1
    y_increment = dy > 0 ? 1 : -1


    # Edge cases :
    if dy == 0 then   # horizontal line
      draw_horizontal_line(x1, x2, y1)
      return
    end 

    if dx == 0 then   # vertical line
      draw_vertical_line(x1, y1, y2)
      return
    end

    # Scanning the line :
    dx, dy  = dx.abs, dy.abs
    glyph   = get_graphic_context[:stroke_glyph]
    
    # First Point :
    setpos(y1, x1)
    addch(glyph)

    # Rest of the Line :
    if dx > dy then
      d = dx >> 1
      dx.times do |i|
        x += x_increment
        d += dy

        if d >= dx then
          d -= dx;
          y += y_increment;

          setpos(y, x)
        else
          ny = y_increment < 0 ? y : y + 1
          setpos ny, x
        end

        addch(glyph)
      end
    else
      d = dy >> 1
      dy.times do |i|
        y += y_increment
        d += dx

        if d >= dy then
          d -= dy
          x += x_increment
        end

        setpos(y, x)
        addch(glyph)
      end
   end
  end

  def draw_antialiased_line(x1, y1, x2, y2)

    # Set-up of the bresenham algorythm :
    x,   y = x1, y1
    dx, dy = x2 - x1, y2 - y1

    x_increment = dx > 0 ? 1 : -1
    y_increment = dy > 0 ? 1 : -1


    # Edge cases :
    if dy == 0 then   # horizontal line
      previous_stroke_glyph = get_stroke_glyph
      set_stroke_glyph HORIZONTAL_GLYPH
      
      draw_horizontal_line(x1, x2, y1)

      set_stroke_glyph previous_stroke_glyph
      return
    end 

    if dx == 0 then   # vertical line
      previous_stroke_glyph = get_stroke_glyph
      set_stroke_glyph VERTICAL_GLYPH
      
      draw_vertical_line(x1, y1, y2)

      set_stroke_glyph previous_stroke_glyph
      return
    end

    # Chosing the "stepping" glyph :
    if dx > 0 then
      step_glyph = dy > 0 ? TOP_LEFT_TO_BOTTOM_RIGHT_GLYPH : BOTTOM_LEFT_TO_TOP_RIGHT_GLYPH 
    else
      step_glyph = dy > 0 ? BOTTOM_LEFT_TO_TOP_RIGHT_GLYPH : TOP_LEFT_TO_BOTTOM_RIGHT_GLYPH
    end

    # Scanning the line :
    dx, dy = dx.abs, dy.abs
    
    # First Point :
    tan = (dy.to_f / dx).abs
    if ( ( tan > 0.08 ) && ( tan < 5.67 ) ) then
      glyph = step_glyph
    else
      glyph = dx > dy ? HORIZONTAL_GLYPH : VERTICAL_GLYPH
    end

    setpos(y1, x1)
    addch(glyph)

    # Rest of the Line :
    if dx > dy then
      d = dx >> 1
      dx.times do |i|
        x += x_increment
        d += dy

        if d >= dx then
          d -= dx;
          y += y_increment;

          setpos(y, x)
          addch(step_glyph)
        else
          ny = y_increment < 0 ? y : y + 1
          setpos ny, x
          addch(HORIZONTAL_GLYPH)
        end
      end
    else
      d = dy >> 1
      (dy - 1).times do |i|
        y += y_increment
        d += dx

        if d >= dy then
          d -= dy
          x += x_increment

          setpos(y, x)
          addch(glyph)
        else
          setpos(y, x)
          addch(VERTICAL_GLYPH)
        end
      end
   end
  end
end
