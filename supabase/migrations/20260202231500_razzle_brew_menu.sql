-- Razzle Brew Coffee Menu Migration
-- Generated on 2026-02-02

-- 1. Insert Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('espresso', 'Espresso', '☕', 1, true),
  ('non-espresso', 'Non-Espresso', '🥛', 2, true),
  ('frappe', 'Ice Blended Frappe', '🥤', 3, true),
  ('sandwich', 'Sandwich', '🥪', 4, true),
  ('rice-meals', 'Rice Meals', '🍛', 5, true),
  ('pasta', 'Pasta', '🍝', 6, true),
  ('snacks', 'Snacks', '🍟', 7, true),
  ('dessert', 'Dessert', '🍨', 8, true)
ON CONFLICT (id) DO UPDATE SET 
  name = EXCLUDED.name, 
  icon = EXCLUDED.icon, 
  active = EXCLUDED.active;

-- Function to handle insertions and variations
-- We use a DO block to avoid multiple roundtrips and manage IDs
DO $$
DECLARE
  v_item_id uuid;
  r RECORD;
  v_drink_addons jsonb := '[
    {"name": "Syrups", "price": 30, "category": "drinks"},
    {"name": "Sauces", "price": 30, "category": "drinks"},
    {"name": "Espresso Shot", "price": 30, "category": "drinks"},
    {"name": "Oreo", "price": 30, "category": "drinks"},
    {"name": "Oat Milk", "price": 50, "category": "drinks"},
    {"name": "Whip Cream", "price": 50, "category": "drinks"},
    {"name": "Matcha", "price": 50, "category": "drinks"},
    {"name": "Nata", "price": 50, "category": "drinks"},
    {"name": "Fruit Jelly", "price": 50, "category": "drinks"},
    {"name": "Coffee Jelly", "price": 50, "category": "drinks"}
  ]';
  v_rice_addons jsonb := '[
    {"name": "Extra Egg", "price": 20, "category": "rice"},
    {"name": "Extra Rice", "price": 20, "category": "rice"}
  ]';
  v_bread_addons jsonb := '[
    {"name": "Extra Bread w/ Butter", "price": 20, "category": "bread"}
  ]';
  v_churro_addons jsonb := '[
    {"name": "Extra Churro Dip", "price": 30, "category": "churros"}
  ]';
  v_scramble_addons jsonb := '[
    {"name": "Candy Sprinkles", "price": 10, "category": "scramble"},
    {"name": "Marshmallow", "price": 10, "category": "scramble"},
    {"name": "Milk Syrup", "price": 20, "category": "scramble"},
    {"name": "Chocolate Syrup", "price": 20, "category": "scramble"}
  ]';
BEGIN
  -- ESPRESSO ITEMS
  -- Cafe Americano (No Syrup)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Cafe Americano (No Syrup)', 'Classic black coffee, bold and smooth.', 99, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 10);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Flavored Americano
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Flavored Americano', 'Americano with your choice of flavor: Brown Sugar, Caramel, Hazelnut, French Vanilla, Mocha, Salted Caramel, White Chocolate.', 119, 'espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Latte (No Syrup)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Latte (No Syrup)', 'Smooth steamed milk over rich espresso.', 129, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Flavored Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Flavored Latte', 'Classic latte with your choice of flavor: Brown Sugar, Caramel, Hazelnut, Spanish, French Vanilla.', 129, 'espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Dark Chocolate Mocha Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Dark Chocolate Mocha Latte', 'Rich dark chocolate meet espresso and steamed milk.', 139, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- White Chocolate Mocha Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('White Chocolate Mocha Latte', 'Creamy white chocolate with espresso and milk.', 139, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Salted Caramel Macchiato
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Salted Caramel Macchiato', 'Sweet caramel with a hint of salt and rich espresso.', 139, 'espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Peppermint Mocha Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Peppermint Mocha Latte', 'Refreshing peppermint with mocha and espresso.', 149, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Peppermint Dark Choco Mocha Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Peppermint Dark Choco Mocha Latte', 'Bold dark chocolate and cool peppermint.', 149, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Biscoff Coffee Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Biscoff Coffee Latte', 'Cookie butter goodness blended with coffee.', 169, 'espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Matcha Espresso Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Matcha Espresso Latte', 'The perfect balance of earthy matcha and bold espresso.', 169, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Ube Espresso Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Ube Espresso Latte', 'Vibrant ube flavor with a kick of espresso.', 169, 'espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Coffee Jelly Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Coffee Jelly Latte', 'Rich latte served with chewy coffee jelly pieces.', 179, 'espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);


  -- NON-ESPRESSO ITEMS
  -- Milky Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Milky Latte', 'Creamy milk base with your choice of flavor: Brown Sugar, Caramel, Hazelnut, French Vanilla, Mocha, Salted Caramel, White Chocolate.', 119, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Specialty Milky Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Specialty Milky Latte', 'Delicious non-coffee options: Green Tea, Bubblegum, Buko Pandan, Dark Choco, Matcha, Ube, or Strawberry.', 129, 'non-espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Premium Milky Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Premium Milky Latte', 'Rich and indulgent: Biscoff, Oreo Matcha, Strawberry Oreo, or Strawberry Matcha.', 149, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Banana Biscoff Latte
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Banana Biscoff Latte', 'Indulgent banana and cookie butter combination.', 169, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Juice & Mocktail
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Juice & Mocktail', 'Refreshing drinks: Dalandan, Mango, Passion Fruit, Honey Dew, Strawberry, Honey Peach, or Blueberry.', 99, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Fruit Tea
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Fruit Tea', 'Freshly brewed fruit tea: Passion Fruit or Honey Peach.', 119, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Shakes (Standard)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Shakes (Standard)', 'Classic shakes: Blueberry, Bubblegum, Buko Pandan, Mango, or Ube.', 149, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Shakes (Premium)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Shakes (Premium)', 'Premium shakes: Strawberry or Biscoff.', 159, 'non-espresso', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Biscoff Coffee Shake
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Biscoff Coffee Shake', 'Indulgent Biscoff blended with coffee.', 169, 'non-espresso', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- ICE BLENDED FRAPPE
  -- Espresso Based (Standard)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Espresso Frappe (Standard)', 'Blended coffee frappe: Caramel, Hazelnut, Mocha, Salted Caramel, or Vanilla Cream.', 159, 'frappe', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Espresso Based (Mid)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Espresso Frappe (Mid)', 'Blended coffee frappe: Biscoff or Dark Chocolate Mocha Cream.', 179, 'frappe', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Espresso Based (Premium)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Espresso Frappe (Premium)', 'Blended coffee frappe: White Chocolate Mocha, Coffee Jelly, Peppermint Mocha, Peppermint Dark Choco, Matcha Espresso, or Ube Espresso.', 199, 'frappe', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_drink_addons) AS x(name text, price decimal, category text);

  -- Non-Espresso (Standard)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Non-Espresso Frappe (Standard)', 'Cream-based frappe: Buko Pandan, Bubblegum, Caramel, Hazelnut, Mango, Salted Caramel, Strawberry, or Vanilla Cream.', 159, 'frappe', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Non-Espresso (Ube/Matcha)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Non-Espresso Frappe (Ube/Matcha)', 'Cream-based frappe: Ube or Matcha Cream.', 169, 'frappe', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Non-Espresso (Oreo/Blueberry)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Non-Espresso Frappe (Oreo/Blueberry/White Choco)', 'Cream-based frappe: Oreo, Blueberry, or White Chocolate Cream.', 169, 'frappe', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Non-Espresso (Biscoff/Banana)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Non-Espresso Frappe (Biscoff/Banana)', 'Cream-based frappe: Biscoff or Banana Biscoff Cream.', 179, 'frappe', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);

  -- Non-Espresso (Dark Choco/Premium)
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Non-Espresso Frappe (Premium)', 'Cream-based frappe: Dark Chocolate, Oreo Matcha, Strawberry Oreo, Peppermint Choco, or Dark Choco Cream.', 189, 'frappe', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Large', 0),
    (v_item_id, 'Titan', 20);


  -- SANDWICH
  -- Egg & Cheese / Ham & Cheese / Ham & Egg
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Egg/Ham & Cheese/Egg Sandwich', 'Toast with your choice of filling: Egg & Cheese, Ham & Cheese, or Ham & Egg.', 99, 'sandwich', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Ala Carte', 0),
    (v_item_id, 'With Reg Fries', 70);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_bread_addons) AS x(name text, price decimal, category text);

  -- Spam & Cheese / Spam & Egg
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Spam & Cheese/Egg Sandwich', 'Toast with your choice of filling: Spam & Cheese or Spam & Egg.', 109, 'sandwich', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Ala Carte', 0),
    (v_item_id, 'With Reg Fries', 70);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_bread_addons) AS x(name text, price decimal, category text);

  -- Ham, Cheese & Egg / Spam, Cheese & Egg
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Premium Club Sandwich', 'Toast with generous filling: Ham, Cheese & Egg or Spam, Cheese & Egg.', 129, 'sandwich', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Ala Carte', 0),
    (v_item_id, 'With Reg Fries', 70);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_bread_addons) AS x(name text, price decimal, category text);


  -- RICE MEALS
  -- Hotdog / Longganisa / Spam / Tocino with Egg
  FOR r IN SELECT unnest(ARRAY['Hotdog', 'Longganisa', 'Spam', 'Tocino']) as n LOOP
    INSERT INTO menu_items (name, description, base_price, category, popular, available)
    VALUES (r.n || ' with Egg', 'Served with garlic rice and egg.', 149, 'rice-meals', false, true)
    RETURNING id INTO v_item_id;
    INSERT INTO add_ons (menu_item_id, name, price, category)
    SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_rice_addons) AS x(name text, price decimal, category text);
  END LOOP;

  -- Tapa with Egg / Cheesy Beef / etc
  FOR r IN SELECT unnest(ARRAY['Tapa with Egg', 'Cheesy Beef', 'Cheesy Hotdog', 'Cheesy Longganisa', 'Cheesy Spam', 'Cheesy Tocino', 'BBQ Pork Belly']) as n LOOP
    INSERT INTO menu_items (name, description, base_price, category, popular, available)
    VALUES (r.n, 'Special rice meal served with garlic rice.', 179, 'rice-meals', true, true)
    RETURNING id INTO v_item_id;
    INSERT INTO add_ons (menu_item_id, name, price, category)
    SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_rice_addons) AS x(name text, price decimal, category text);
  END LOOP;


  -- PASTA
  -- Meaty Spaghetti
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Meaty Spaghetti', 'Classic Filipino-style meaty spaghetti.', 149, 'pasta', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_bread_addons) AS x(name text, price decimal, category text);

  -- Creamy Carbonara
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Creamy Carbonara', 'Rich and creamy carbonara with bacon and mushrooms.', 169, 'pasta', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_bread_addons) AS x(name text, price decimal, category text);


  -- SNACKS
  -- Hashbrown
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Hashbrown', 'Golden and crispy potato hashbrown.', 79, 'snacks', false, true)
  RETURNING id INTO v_item_id;

  -- Churros with Dip
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Churros with Dip', 'Classic churros served with your choice of dip.', 139, 'snacks', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, '6pcs', 0),
    (v_item_id, '12pcs', 60);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_churro_addons) AS x(name text, price decimal, category text);

  -- Churro Split
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Churro Split', 'Delicious churro split dessert.', 149, 'snacks', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_churro_addons) AS x(name text, price decimal, category text);

  -- Fries
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Fries', 'Choice of flavors: Plain Salted, BBQ, Cheese, Sourcream.', 79, 'snacks', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Regular', 0),
    (v_item_id, 'Large', 20);

  -- Nachos Cheesy
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Nachos Cheesy', 'Crispy nachos with rich cheese sauce.', 129, 'snacks', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Solo', 0),
    (v_item_id, 'Sharing', 100);

  -- Nachos Beefy
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Nachos Beefy', 'Nachos topped with savory beef and cheese.', 149, 'snacks', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Solo', 0),
    (v_item_id, 'Sharing', 140);

  -- Poutine Fries Cheesy
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Poutine Fries Cheesy', 'Fries topped with cheese and gravy.', 139, 'snacks', false, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Solo', 0),
    (v_item_id, 'Sharing', 110);

  -- Poutine Fries Beefy
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Poutine Fries Beefy', 'Poutine fries topped with beef.', 159, 'snacks', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Solo', 0),
    (v_item_id, 'Sharing', 150);


  -- DESSERT
  -- Ice Scramble
  INSERT INTO menu_items (name, description, base_price, category, popular, available)
  VALUES ('Ice Scramble', 'Classic Filipino pink ice scramble.', 99, 'dessert', true, true)
  RETURNING id INTO v_item_id;
  INSERT INTO variations (menu_item_id, name, price) VALUES
    (v_item_id, 'Medium', 0),
    (v_item_id, 'Large', 20);
  INSERT INTO add_ons (menu_item_id, name, price, category)
  SELECT v_item_id, name, price, category FROM jsonb_to_recordset(v_scramble_addons) AS x(name text, price decimal, category text);

END $$;
