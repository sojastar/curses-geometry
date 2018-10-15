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

  # Randomly draws a single char :
  while(true) do
    set_color_pair colors.sample
    draw_glyph glyphs.sample, rand(0..max_x), rand(0..max_y)
    refresh
    sleep 0.1
  end

ensure
  close_screen
end
