require "quadkey/version"

module Quadkey
  MIN_LATITUDE = -85.05112878
  MAX_LATITUDE = 85.05112878
  MIN_LONGITUDE = -180
  MAX_LONGITUDE = 180
  EARTH_RADIUS = 6378137

  def self.encode(latitude, longitude, precision)
    pixel_x, pixel_y = coordinates_to_pixel(latitude, longitude, precision)
    tile_x, tile_y = pixel_to_tile(pixel_x, pixel_y)
    tile_to_quadkey(tile_x, tile_y, precision)
  end

  def self.decode(quadkey)
    tile_x, tile_y, precision = quadkey_to_tile(quadkey)
    pixel_x, pixel_y = tile_to_pixel(tile_x, tile_y)
    latitude, longitude = pixel_to_coordinates(pixel_x, pixel_y, precision)

    return latitude, longitude, precision
  end

  def self.neighbors(quadkey)
    tile_x, tile_y, precision = quadkey_to_tile(quadkey)
    neighbors = []
    permutation = [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0], [0,  0], [1,  0],
      [-1,  1], [0,  1], [1,  1]
    ]
    permutation.each do |value|
      perm_x, perm_y = value
      neighbors << tile_to_quadkey(tile_x + perm_x, tile_y + perm_y, precision)
    end

    return neighbors
  end

  def self.clip(n, min_value, max_value)
    [[n, min_value].max, max_value].min
  end

  def self.map_size(precision)
    256 << precision
  end

  def self.ground_resolution(latitude, precision)
    latitude = clip(latitude, MIN_LATITUDE, MAX_LATITUDE);
    return Math.cos(latitude * Math::PI / 180) * 2 * Math::PI * EARTH_RADIUS / map_size(precision);
  end

  def self.coordinates_to_pixel(latitude, longitude, precision)
    latitude = clip(latitude, MIN_LATITUDE, MAX_LATITUDE)
    longitude = clip(longitude, MIN_LONGITUDE, MAX_LONGITUDE)

    x = (longitude + 180) / 360
    sin_latitude = Math.sin(latitude * Math::PI / 180)
    y = 0.5 - Math.log((1 + sin_latitude) / (1 - sin_latitude)) / (4 * Math::PI)

    map_size = map_size(precision).to_f
    pixel_x = clip(x * map_size + 0.5, 0, map_size - 1).to_i
    pixel_y = clip(y * map_size + 0.5, 0, map_size - 1).to_i

    return pixel_x, pixel_y
  end

  def self.pixel_to_coordinates(pixel_x, pixel_y, precision)
    map_size = map_size(precision).to_f
    x = (clip(pixel_x, 0, map_size - 1) / map_size).to_f - 0.5
    y = 0.5 - (clip(pixel_y, 0, map_size - 1) / map_size).to_f

    latitude = 90 - 360 * Math.atan(Math.exp(-y * 2 * Math::PI)) / Math::PI
    longitude = 360 * x

    return latitude, longitude
  end

  def self.pixel_to_tile(pixel_x, pixel_y)
    tile_x = pixel_x / 256
    tile_y = pixel_y / 256

    return tile_x, tile_y
  end

  def self.tile_to_pixel(tile_x, tile_y)
    pixel_x = tile_x * 256
    pixel_y = tile_y * 256

    return pixel_x, pixel_y
  end

  def self.tile_to_quadkey(tile_x, tile_y, precision)
    quadkey = ''

    precision.downto(1) do |i|
      digit = '0'.ord
      mask = 1 << (i - 1)
      if (tile_x & mask) != 0
        digit += 1
      end
      if (tile_y & mask) != 0
        digit += 1
        digit += 1
      end
      quadkey += digit.chr
    end

    return quadkey
  end

  def self.quadkey_to_tile(quadkey)
    tile_x = 0
    tile_y = 0
    precision = quadkey.length
    precision.downto(1) do |i|
      mask = 1 << (i - 1)
      case quadkey[precision - i]
      when '0'
      when '1'
        tile_x |= mask
      when '2'
        tile_y |= mask
      when '3'
        tile_x |= mask
        tile_y |= mask
      else
        raise "Invalid Quadkey digit sequence."
      end
    end

    return tile_x, tile_y, precision
  end
end
