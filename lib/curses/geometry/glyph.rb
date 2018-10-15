module Glyph 
  def draw_glyph(glyph, x=nil, y=nil)
    setpos(y, x) unless x.nil? || y.nil?
    addch(glyph)
  end
end
