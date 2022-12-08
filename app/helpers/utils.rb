module Utils
  # found more about this formula in: https://stackoverflow.com/questions/12966638/how-to-calculate-the-distance-between-two-gps-coordinates-without-using-google-maps
  def distance(loc1, loc2)
    rad_per_deg = Math::PI / 180  # PI / 180
    rkm = 6371                    # Earth radius in kilometers
    rm = rkm * 1000               # Radius in meters

    dlat_rad = (loc2['lat'] - loc1['lat']) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2['lng'] - loc1['lng']) * rad_per_deg

    lat1_rad, lon1_rad = loc1.values.map { |i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.values.map { |i| i * rad_per_deg }

    a = Math.sin(dlat_rad / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    # delta in km
    (rm * c / 1000).round(2)
  end
end
