module Rectangle
  def stroke_rectangle(x1, y1, x2, y2)
    draw_horizontal_line(x1, x2, y1)
    draw_horizontal_line(x1, x2, y2)
    draw_vertical_line(x1, y1, y2)
    draw_vertical_line(x2, y1, y2)
  end

  def fill_rectangle(x1, y1, x2, y2)
    min_x, max_x  = x1 < x2 ? [x1,x2] : [x2,x1]
    min_y, max_y  = y1 < y2 ? [y1,y2] : [y2,y1]

    setpos(min_x, min_y)   
    min_y.upto(max_y) do |y|
      setpos(y, min_x)
      min_x.upto(max_x) do |x|
        addch(get_fill_glyph)
      end
    end
  end

  def draw_framed_rectangle(x1, y1, x2, y2)

    # Stroke the frame :
    draw_horizontal_line(x1, x2, y1)
    draw_horizontal_line(x1, x2, y2)
    draw_vertical_line(x1, y1, y2)
    draw_vertical_line(x2, y1, y2)
    
    # Fill the frame :
    min_x, max_x  = x1 < x2 ? [x1,x2] : [x2,x1]
    min_y, max_y  = y1 < y2 ? [y1,y2] : [y2,y1]

    setpos(min_x + 1, min_y + 1)   
    (min_y + 1).upto(max_y - 1) do |y|
      setpos(y, min_x + 1)
      (min_x + 1).upto(max_x + 1) do |x|
        addch(get_fill_glyph)
      end
    end

  end
end
