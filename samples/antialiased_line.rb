require 'curses'
require_relative '../lib/ascii_graphics.rb'
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

  # Randomly draws lines :
  while(true) do
    # Clear the frame :
    set_color_pair    :black_on_white
    set_fill_glyph    ' '
    fill_rectangle    1, 1, max_x - 1, max_y - 1 

    # Draw stuff inside the frame :
    set_color_pair(colors.sample)
    set_stroke_glyph  glyphs.sample

    x1  = rand 2..(max_x - 2) 
    y1  = rand 2..(max_y - 2)
    x2  = rand 2..(max_x - 2)
    y2  = rand 2..(max_y - 2)

    draw_antialiased_line(x1, y1, x2, y2)
    
    refresh
    sleep 0.1 
  end
ensure
  close_screen
end
