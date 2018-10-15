module Polygon
  ### Module variable :
  @left_scan  = nil
  @right_scan = nil


  ### Methods :
  def scan_polygon_left_edge(x1, y1, x2, y2)

    # Escape horizontal lines :
    return if (y1 - y2).abs < 0.75 


    # Calculating useful values for the scanning loop :
    islope    = ( x2 - x1 ).to_f / ( y2 - y1 ).to_f
    #islope    = ( x2 - x1 ) / ( y2 - y1 )

    y_top     = y1 > 0.5 ? ( y1 - 0.5 ).floor.to_i : 0.0
    y_bottom  = ( y2 + 0.5 ).floor.to_i

    x         = ( y_top + 0.5 - y1 ) * islope + x1      # + 0.5 : the scan line goes through the middle of the pixel


    # Scan converting :
    y_top.downto(y_bottom) do |y|
      @left_scan[y] = ( x + 0.5 ).floor.to_i
      x -= islope
    end
  end


  def scan_polygon_right_edge(x1, y1, x2, y2)

    # Escape horizontal lines :
    return if ( y1 - y2 ).abs <  0.75

    # Calculating useful values for the scanning loop :
    islope    = ( x2 - x1 ).to_f / ( y2 - y1 ).to_f
    #islope    = ( x2 - x1 ) / ( y2 - y1 )

    y_top     = y1 > 0.5 ? ( y1 - 0.5 ).floor.to_i : 0.0
    y_bottom  = ( y2 + 0.5 ).floor.to_i

    x         = ( y_top + 0.5 - y1 ) * islope + x1        # + 0.5 : the scan line goes through the middle of the pixel


    # Scan converting :
    y_top.downto(y_bottom) do |y|
      @right_scan[y] = x > 0.5 ? ( x - 0.5 ).floor.to_i : 0.0
      x -= islope
    end
  end


  def fill_polygon (vertices)

    # Clearing the rasterizer's buffers :
    @left_scan   = Array.new(lines) { 1000000 }
    @right_scan  = Array.new(lines) {       0 }

    # Finding the top and bottom of the polygon :

    # Initializing the loop with the first point y value :
    max_y_index = 0
    min_y_index = 0

    max_y = vertices[max_y_index][1].to_i
    min_y = vertices[min_y_index][1].to_i

    vertices.each.with_index do |vertex,i|
      # Find the bottom index :
      if (vertex[1] < min_y) then
        min_y       = vertex[1].to_i
        min_y_index = i
      end

      # Find the top index :
      if vertex[1] > max_y then
        max_y       = vertex[1].to_i
        max_y_index = i
      end
    end


    # Discard null height polygons :
    return if min_y == max_y


    # Devise the winding order :
    previous_point_x  = vertices[(max_y_index - 1 + vertices.length) % vertices.length][0].to_i
    next_point_x      = vertices[(max_y_index + 1) % vertices.length][0].to_i
    winding_order     = previous_point_x < next_point_x ? -1 : 1


    # Scan the left and right edges of the polygon :

    # Left :
    i = 0
    while( vertices[( ( max_y_index + i * winding_order ) + vertices.length) % vertices.length][1] != min_y ) do
      index       = ( ( max_y_index + i * winding_order ) + vertices.length ) % vertices.length
      next_index  = ( ( max_y_index + ( i + 1 ) * winding_order ) + vertices.length ) % vertices.length
      scan_polygon_left_edge( vertices[index][0],
                              vertices[index][1],
                              vertices[next_index][0],
                              vertices[next_index][1] )

      i += 1
    end
    
    # Right :
    i = 0;
    while ( vertices[( ( max_y_index - i * winding_order ) + vertices.length ) % vertices.length][1] != min_y ) do
      index       = ( ( max_y_index - i * winding_order ) + vertices.length ) % vertices.length
      next_index  = ( ( max_y_index - ( i + 1 ) * winding_order ) + vertices.length ) % vertices.length
      scan_polygon_right_edge(  vertices[index][0],
                                vertices[index][1],
                                vertices[next_index][0],
                                vertices[next_index][1] )

      i += 1
    end


    # Draw the polygon :
    min_y.upto(max_y) do |y|
      @left_scan[y].upto(@right_scan[y]) do |x|
        setpos(y, x)
        addch(get_fill_glyph)
      end
    end

  end
end
