# 2026 rates (stored as fractions: 0.05 = 5%)
[
  ["Alberta", "AB", 0.05, 0, 0],
  ["British Columbia", "BC", 0.05, 0.07, 0],
  ["Manitoba", "MB", 0.05, 0.07, 0],
  ["New Brunswick", "NB", 0, 0, 0.15],
  ["Newfoundland and Labrador", "NL", 0, 0, 0.15],
  ["Northwest Territories", "NT", 0.05, 0, 0],
  ["Nova Scotia", "NS", 0, 0, 0.14],
  ["Nunavut", "NU", 0.05, 0, 0],
  ["Ontario", "ON", 0, 0, 0.13],
  ["Prince Edward Island", "PE", 0, 0, 0.15],
  ["Quebec", "QC", 0.05, 0.09975, 0],
  ["Saskatchewan", "SK", 0.05, 0.06, 0],
  ["Yukon", "YT", 0.05, 0, 0]
].each do |name, abbreviation, gst, pst, hst|
  province = Province.find_or_initialize_by(abbreviation: abbreviation)
  province.update!(name: name, gst_rate: gst, pst_rate: pst, hst_rate: hst)
end

puts "Loaded #{Province.count} provinces and territories."
