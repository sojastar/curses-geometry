require 'curses'
require_relative "geometry/version"
require_relative "geometry/graphic_context"
require_relative "geometry/glyph"
require_relative "geometry/line"
require_relative "geometry/rectangle"
require_relative "geometry/polygon"

module Curses
  module Geometry
    include GraphicContext
    include Glyph 
    include Line
    include Rectangle
    include Polygon
  end
  include Geometry
end
