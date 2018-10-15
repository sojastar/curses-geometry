require 'curses/geometry'
include Curses

Signal.trap("INT") { close_screen; exit 0 }

init_screen
timeout=0
begin
  # Screen setup :
  start_color
  curs_set 0

  max_x = cols  - 1
  max_y = lines - 1

  # Graphic context ( color ) setup :
  register_color_pair(:black_on_white,  COLOR_WHITE,    COLOR_BLACK   )
  register_color_pair(:red_on_blue,     COLOR_RED,      COLOR_BLUE    )
  register_color_pair(:green_on_yellow, COLOR_GREEN,    COLOR_YELLOW  )
  register_color_pair(:magenta_on_cyan, COLOR_MAGENTA,  COLOR_CYAN    )
  register_color_pair(:red_on_green,    COLOR_RED,      COLOR_GREEN   )

  colors  = [:red_on_blue, :green_on_yellow, :magenta_on_cyan, :red_on_green]
  glyphs  = ['o', '.', '+', '*'] 

  # Draws a frame :
  set_color_pair :red_on_blue
  set_stroke_glyph '='
  stroke_rectangle 0, 0, max_x, max_y

  # Randomly draws polygons :
  while(true) do
    # Clear the frame :
    set_color_pair    :black_on_white
    set_fill_glyph    ' '
    fill_rectangle 1, 1, max_x - 1, max_y - 1

    # Draw stuff inside the frame :
    set_color_pair(colors.sample)
    set_fill_glyph    glyphs.sample

    px1 = rand                1..( max_x / 2 )
    py1 = rand                1..( max_y / 2 )
    px2 = rand ( max_x / 2 + 1)..( max_x - 1 )
    py2 = rand                1..( max_y / 2 )
    px3 = rand ( max_x / 2 + 1)..( max_x - 1 )
    py3 = rand ( max_y / 2 + 1)..( max_y - 1 )
    px4 = rand                1..( max_x / 2 )
    py4 = rand ( max_y / 2 + 1)..( max_y - 1 )

    fill_polygon([[px1, py1], [px2, py2], [px3, py3], [px4, py4]])

    refresh
    sleep 0.1
  end
ensure
  close_screen
end
