# Clear old data so the seed can be run again safely
Product.destroy_all
Category.destroy_all

catalog = {
  "Interior" => {
    description: "Floor mats, seat covers and organizers that keep the inside of your car clean and comfortable.",
    products: [
      ["All-Weather Rubber Floor Mats (4-Piece)", "Heavy-duty rubber mats with deep grooves that trap snow, slush and road salt. Trim-to-fit for most cars, SUVs and trucks.", 49.99, 40, true],
      ["Carpet Floor Mats - Black (4-Piece)", "Soft carpet mats with a non-slip backing. A clean, simple look for everyday driving in warmer months.", 34.99, 30, false],
      ["Universal Seat Covers - Grey (Front Pair)", "Breathable polyester covers that protect your seats from spills, pet hair and wear. Fits most bucket seats.", 39.99, 25, false],
      ["Back Seat Organizer with Tablet Holder", "Hangs on the back of the front seat. Pockets for snacks, water bottles and toys, plus a clear tablet window for kids.", 24.99, 35, true],
      ["Leather Steering Wheel Cover", "Fits 37-38 cm steering wheels. Improves grip and stays comfortable in both cold winters and hot summers.", 19.99, 50, false]
    ]
  },
  "Exterior" => {
    description: "Wiper blades, covers and accessories for the outside of your vehicle.",
    products: [
      ["Beam Wiper Blade - 22 inch", "Frameless beam blade that presses evenly on the windshield for a streak-free wipe. Fits most J-hook wiper arms.", 21.99, 60, false],
      ["Beam Wiper Blade - 18 inch", "Passenger-side beam blade with a rubber edge that resists cracking in cold weather.", 18.99, 60, false],
      ["Rear Wiper Blade - 12 inch", "Replacement rear wiper for hatchbacks and SUVs. Easy clip-on install.", 14.99, 30, true],
      ["Full Car Cover - Mid-Size Sedan", "Water-resistant cover with a soft inner lining. Protects paint from sun, bird droppings and tree sap.", 69.99, 15, false],
      ["Mud Flaps - Universal (Set of 4)", "Flexible mud flaps that cut down on rock chips and keep slush off the sides of your car.", 29.99, 20, false]
    ]
  },
  "Winter" => {
    description: "Gear for Manitoba winters: scrapers, booster cables and washer fluid.",
    products: [
      ["Snow Brush with Ice Scraper - 52 inch", "Extendable snow brush with a pivoting head and a strong ice scraper. Reaches across trucks and SUV roofs.", 27.99, 45, true],
      ["Heavy-Duty Booster Cables - 20 ft, 4 Gauge", "Thick copper cables with insulated clamps. Long enough to boost from behind or beside another car.", 44.99, 30, false],
      ["Winter Windshield Washer Fluid -45C (3.78 L)", "Washer fluid rated to -45C so it will not freeze in your lines on the coldest prairie mornings.", 6.99, 120, false],
      ["Windshield Snow Cover", "Magnetic cover that keeps frost and snow off your windshield overnight. Saves scraping time in the morning.", 22.99, 25, true],
      ["Portable Jump Starter - 1000A", "Compact lithium jump starter that can start a car without a second vehicle. Also charges phones by USB.", 119.99, 12, false]
    ]
  },
  "Car Care" => {
    description: "Wash, wax and cleaning products to keep your car looking new.",
    products: [
      ["Car Wash Soap - 1.89 L", "pH-balanced car wash soap that removes road salt and grime without stripping wax.", 12.99, 70, false],
      ["Microfibre Cleaning Cloths (12-Pack)", "Lint-free cloths for washing, drying and polishing. Safe on paint, glass and interior screens.", 15.99, 80, true],
      ["Liquid Carnauba Wax - 473 mL", "Adds a deep shine and a protective layer that helps water bead off your paint.", 18.99, 40, false],
      ["Interior Cleaner & Protectant Spray", "Cleans and protects dashboards, door panels and vinyl. Leaves a non-greasy matte finish.", 9.99, 55, false],
      ["Glass Cleaner - Streak Free (650 mL)", "Ammonia-free glass cleaner that is safe on tinted windows. Cuts through winter haze on the inside of the windshield.", 7.99, 65, false]
    ]
  },
  "Electronics" => {
    description: "Phone mounts, chargers and dash cams for the modern driver.",
    products: [
      ["Magnetic Phone Mount - Air Vent", "Strong magnetic mount that clips onto your air vent. Rotates 360 degrees for portrait or landscape view.", 19.99, 50, false],
      ["Dashboard Phone Holder with Suction Cup", "Adjustable arm with a sticky suction base that holds firmly on dashboards and windshields.", 24.99, 35, true],
      ["Dual USB-C Car Charger - 40W", "Fast-charges two phones at once from your 12V outlet. Built-in protection against overheating.", 22.99, 45, false],
      ["1080p Front Dash Cam", "Records full HD video with loop recording and automatic crash detection. Includes 32GB memory card.", 79.99, 18, false],
      ["Bluetooth FM Transmitter", "Plays music and hands-free calls through your car radio. Has a USB charging port built in.", 26.99, 30, true]
    ]
  }
}

catalog.each do |category_name, data|
  category = Category.create!(name: category_name, description: data[:description])

  data[:products].each do |name, description, price, stock, on_sale|
    category.products.create!(
      name: name,
      description: description,
      price: price,
      stock_quantity: stock,
      on_sale: on_sale,
      created_at: 30.days.ago,
      updated_at: 30.days.ago
    )
  end
end

puts "Created #{Category.count} categories and #{Product.count} products."
AdminUser.find_or_create_by!(email: 'karan@gmail.com') { |u| u.password = 'password'; u.password_confirmation = 'password' }
