module GraphicContext
  @@graphic_context = { :color_pairs  => {},
                        :stroke_glyph => 's',
                        :fill_glyph   => 'f' }

  def get_graphic_context
    @@graphic_context
  end

  def register_color_pair(name, front_color, back_color)
    new_pair_index = @@graphic_context[:color_pairs].length + 1
    init_pair(new_pair_index, front_color, back_color)
    @@graphic_context[:color_pairs][name] = new_pair_index
  end

  def set_color_pair(name)
    attron color_pair(@@graphic_context[:color_pairs][name])
  end

  def get_stroke_glyph
    @@graphic_context[:stroke_glyph]
  end

  def set_stroke_glyph(glyph)
    @@graphic_context[:stroke_glyph]  = glyph
  end

  def get_fill_glyph
    @@graphic_context[:fill_glyph]
  end

  def set_fill_glyph(glyph)
    @@graphic_context[:fill_glyph]    = glyph
  end
end
