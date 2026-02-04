/*
  # Add Espresso Menu Items (Americano and Latte) - Fixed UUIDs

  1. New Categories
    - espresso-americano: ESPRESSO (AMERICANO)
    - espresso-latte: ESPRESSO (LATTE)

  2. New Menu Items
    - Items are inserted without explicit UUIDs to let the database generate them.
    - Variations and Add-ons use subqueries to find the correct menu_item_id by name.
*/

-- 1. Add Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('espresso-americano', 'ESPRESSO (AMERICANO)', '☕', 10, true),
  ('espresso-latte', 'ESPRESSO (LATTE)', '☕', 11, true)
ON CONFLICT (id) DO NOTHING;

-- 2. Add Americano Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Cafe Americano (No Syrup)', 'Rich espresso with hot water, perfect for a pure coffee experience.', 99, 'espresso-americano', true, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Cafe Americano (No Syrup)');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Flavored Americano', 'Customizable Americano with your choice of flavor syrup.', 119, 'espresso-americano', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Flavored Americano');

-- 3. Add Latte Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Cafe Latte (No Syrup)', 'Smooth espresso balanced with steamed milk.', 129, 'espresso-latte', true, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Cafe Latte (No Syrup)');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Flavored Latte', 'Creamy latte infused with your favorite flavor syrup.', 129, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Flavored Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Dark Chocolate Mocha Latte', 'A rich blend of espresso, steamed milk, and dark chocolate.', 139, 'espresso-latte', true, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Dark Chocolate Mocha Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'White Chocolate Mocha Latte', 'Delicious combination of espresso, milk, and white chocolate.', 139, 'espresso-latte', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'White Chocolate Mocha Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Peppermint Mocha Latte', 'Festive mocha with a refreshing hint of peppermint.', 139, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Peppermint Mocha Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Caramel Macchiato', 'Espresso marked with milk and finished with caramel drizzle.', 149, 'espresso-latte', true, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Caramel Macchiato');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Peppermint Dark Choco Mocha Latte', 'Indulgent dark chocolate mocha with peppermint twist.', 149, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Peppermint Dark Choco Mocha Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Biscoff Coffee Latte', 'Unique latte featuring the spiced flavor of Biscoff cookies.', 169, 'espresso-latte', true, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Biscoff Coffee Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Matcha Espresso Latte', 'Perfect balance of earthy matcha and bold espresso.', 169, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Matcha Espresso Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Ube Espresso Latte', 'Creamy latte with the vibrant flavor of Filipino purple yam.', 169, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Ube Espresso Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Coffee Jelly Latte', 'Latte served with chewy, delicious coffee jelly.', 179, 'espresso-latte', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Coffee Jelly Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Sea Salt Latte', 'Espresso and milk with a touch of savory sea salt cream.', 179, 'espresso-latte', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Sea Salt Latte');

-- 4. Add variations for Americano items
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Medium', 0 FROM menu_items WHERE name = 'Cafe Americano (No Syrup)'
ON CONFLICT DO NOTHING;
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 0 FROM menu_items WHERE name = 'Cafe Americano (No Syrup)'
ON CONFLICT DO NOTHING;
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Titan', 10 FROM menu_items WHERE name = 'Cafe Americano (No Syrup)'
ON CONFLICT DO NOTHING;

INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Medium', 0 FROM menu_items WHERE name = 'Flavored Americano'
ON CONFLICT DO NOTHING;
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 0 FROM menu_items WHERE name = 'Flavored Americano'
ON CONFLICT DO NOTHING;
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Titan', 20 FROM menu_items WHERE name = 'Flavored Americano'
ON CONFLICT DO NOTHING;

-- 5. Add variations for Latte items
INSERT INTO variations (menu_item_id, name, price)
SELECT id, size_name, price_offset
FROM (
  VALUES 
    ('Cafe Latte (No Syrup)', 'Medium', 0),
    ('Cafe Latte (No Syrup)', 'Large', 0),
    ('Cafe Latte (No Syrup)', 'Titan', 20),
    ('Flavored Latte', 'Medium', 0),
    ('Flavored Latte', 'Large', 0),
    ('Flavored Latte', 'Titan', 20),
    ('Dark Chocolate Mocha Latte', 'Medium', 0),
    ('Dark Chocolate Mocha Latte', 'Large', 0),
    ('Dark Chocolate Mocha Latte', 'Titan', 20),
    ('White Chocolate Mocha Latte', 'Medium', 0),
    ('White Chocolate Mocha Latte', 'Large', 0),
    ('White Chocolate Mocha Latte', 'Titan', 20),
    ('Peppermint Mocha Latte', 'Medium', 0),
    ('Peppermint Mocha Latte', 'Large', 0),
    ('Peppermint Mocha Latte', 'Titan', 20),
    ('Caramel Macchiato', 'Medium', 0),
    ('Caramel Macchiato', 'Large', 0),
    ('Caramel Macchiato', 'Titan', 20),
    ('Peppermint Dark Choco Mocha Latte', 'Medium', 0),
    ('Peppermint Dark Choco Mocha Latte', 'Large', 0),
    ('Peppermint Dark Choco Mocha Latte', 'Titan', 20),
    ('Biscoff Coffee Latte', 'Medium', 0),
    ('Biscoff Coffee Latte', 'Large', 0),
    ('Biscoff Coffee Latte', 'Titan', 20),
    ('Matcha Espresso Latte', 'Medium', 0),
    ('Matcha Espresso Latte', 'Large', 0),
    ('Matcha Espresso Latte', 'Titan', 20),
    ('Ube Espresso Latte', 'Medium', 0),
    ('Ube Espresso Latte', 'Large', 0),
    ('Ube Espresso Latte', 'Titan', 20),
    ('Coffee Jelly Latte', 'Large', 0),
    ('Coffee Jelly Latte', 'Titan', 20),
    ('Sea Salt Latte', 'Large', 0),
    ('Sea Salt Latte', 'Titan', 20)
) as v(item_name, size_name, price_offset)
JOIN menu_items ON menu_items.name = v.item_name
ON CONFLICT DO NOTHING;

-- 6. Add flavor add-ons for Americano
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, flavor_name, 0, 'Flavor'
FROM (
  VALUES 
    ('Brown Sugar'), ('Caramel'), ('Hazelnut'), ('French Vanilla'), 
    ('Mocha'), ('Salted Caramel'), ('Vanilla'), ('White Chocolate')
) as f(flavor_name)
CROSS JOIN (SELECT id FROM menu_items WHERE name = 'Flavored Americano') as item
ON CONFLICT DO NOTHING;

-- 7. Add flavor add-ons for Latte
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, flavor_name, 0, 'Flavor'
FROM (
  VALUES 
    ('Brown Sugar'), ('Caramel'), ('French Vanilla'), ('Hazelnut'), 
    ('Mocha'), ('Salted Caramel'), ('Spanish'), ('Vanilla')
) as f(flavor_name)
CROSS JOIN (SELECT id FROM menu_items WHERE name = 'Flavored Latte') as item
ON CONFLICT DO NOTHING;
-- 8. Add Global Add-ons for all Espresso items
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT menu_items.id, addon.name, addon.price, 'Extras'
FROM menu_items
CROSS JOIN (
  VALUES 
    ('Syrups', 30),
    ('Espresso Shot', 30),
    ('Oat Milk', 50),
    ('Whip Cream', 50)
) as addon(name, price)
WHERE menu_items.category IN ('espresso-americano', 'espresso-latte')
ON CONFLICT DO NOTHING;
-- 9. Add Additional Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('non-espresso', 'NON-ESPRESSO', '🥛', 12, true),
  ('juice-mocktail', 'JUICE & MOCKTAIL', '🍹', 13, true),
  ('fruit-tea', 'FRUIT TEA', '🍎', 14, true),
  ('shakes', 'SHAKES', '🥤', 15, true)
ON CONFLICT (id) DO NOTHING;

-- 10. Add Non-Espresso Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Milky Latte', 'Refreshing milk-based drink with your choice of flavor.', 119, 'non-espresso', true, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Milky Latte');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Green Tea', 'Classic refreshing green tea.', 129, 'non-espresso', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Green Tea');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Creamy and delicious latte.', 149, 'non-espresso', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Bubblegum Latte'), ('Buko Pandan Latte'), ('Dark Choco Latte'), ('Matcha Latte'), ('Oreo Latte'), ('Strawberry Latte'), ('Ube Latte')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Premium blend latte.', 159, 'non-espresso', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Biscoff Latte'), ('Oreo Matcha Latte'), ('Strawberry Oreo Latte'), ('Strawberry Matcha Latte')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Banana Biscoff Latte', 'Indulgent banana and biscoff blend.', 169, 'non-espresso', true, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Banana Biscoff Latte');

-- 11. Add Juice & Mocktail Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Refreshing juice blend.', 99, 'juice-mocktail', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Dalandan'), ('Honey Dew (Melon)'), ('Honey Peach'), ('Blueberry'), ('Mango'), ('Passion Fruit'), ('Strawberry')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 12. Add Fruit Tea Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Premium fruit-infused tea.', 119, 'fruit-tea', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Honey Peach Fruit Tea'), ('Passion Fruit Fruit Tea')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 13. Add Shakes Menu Items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Creamy ice-blended shake.', 149, 'shakes', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Blueberry Shake'), ('Bubblegum Shake'), ('Buko Pandan Shake'), ('Mango Shake'), ('Ube Shake'), ('Strawberry Shake')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Biscoff Shake', 'Indulgent Biscoff cookie shake.', 159, 'shakes', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Biscoff Shake');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Biscoff Coffee Shake', 'Biscoff shake with a shot of espresso.', 169, 'shakes', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Biscoff Coffee Shake');

-- 14. Add Variations for New Items
INSERT INTO variations (menu_item_id, name, price)
SELECT id, size_name, price_offset
FROM (
  VALUES 
    ('Milky Latte', 'Medium', 0), ('Milky Latte', 'Large', 0), ('Milky Latte', 'Titan', 20),
    ('Green Tea', 'Medium', 0), ('Green Tea', 'Large', 0), ('Green Tea', 'Titan', 20),
    ('Bubblegum Latte', 'Medium', 0), ('Bubblegum Latte', 'Large', 0), ('Bubblegum Latte', 'Titan', 20),
    ('Buko Pandan Latte', 'Medium', 0), ('Buko Pandan Latte', 'Large', 0), ('Buko Pandan Latte', 'Titan', 20),
    ('Dark Choco Latte', 'Medium', 0), ('Dark Choco Latte', 'Large', 0), ('Dark Choco Latte', 'Titan', 20),
    ('Matcha Latte', 'Medium', 0), ('Matcha Latte', 'Large', 0), ('Matcha Latte', 'Titan', 20),
    ('Oreo Latte', 'Medium', 0), ('Oreo Latte', 'Large', 0), ('Oreo Latte', 'Titan', 20),
    ('Strawberry Latte', 'Medium', 0), ('Strawberry Latte', 'Large', 0), ('Strawberry Latte', 'Titan', 20),
    ('Ube Latte', 'Medium', 0), ('Ube Latte', 'Large', 0), ('Ube Latte', 'Titan', 20),
    ('Biscoff Latte', 'Medium', 0), ('Biscoff Latte', 'Large', 0), ('Biscoff Latte', 'Titan', 20),
    ('Oreo Matcha Latte', 'Medium', 0), ('Oreo Matcha Latte', 'Large', 0), ('Oreo Matcha Latte', 'Titan', 20),
    ('Strawberry Oreo Latte', 'Medium', 0), ('Strawberry Oreo Latte', 'Large', 0), ('Strawberry Oreo Latte', 'Titan', 20),
    ('Strawberry Matcha Latte', 'Medium', 0), ('Strawberry Matcha Latte', 'Large', 0), ('Strawberry Matcha Latte', 'Titan', 20),
    ('Banana Biscoff Latte', 'Medium', 0), ('Banana Biscoff Latte', 'Large', 0), ('Banana Biscoff Latte', 'Titan', 20),
    ('Dalandan', 'Medium', 0), ('Dalandan', 'Large', 0), ('Dalandan', 'Titan', 20),
    ('Honey Dew (Melon)', 'Medium', 0), ('Honey Dew (Melon)', 'Large', 0), ('Honey Dew (Melon)', 'Titan', 20),
    ('Honey Peach', 'Medium', 0), ('Honey Peach', 'Large', 0), ('Honey Peach', 'Titan', 20),
    ('Blueberry', 'Medium', 0), ('Blueberry', 'Large', 0), ('Blueberry', 'Titan', 20),
    ('Mango', 'Medium', 0), ('Mango', 'Large', 0), ('Mango', 'Titan', 20),
    ('Passion Fruit', 'Medium', 0), ('Passion Fruit', 'Large', 0), ('Passion Fruit', 'Titan', 20),
    ('Strawberry', 'Medium', 0), ('Strawberry', 'Large', 0), ('Strawberry', 'Titan', 20),
    ('Honey Peach Fruit Tea', 'Medium', 0), ('Honey Peach Fruit Tea', 'Large', 0), ('Honey Peach Fruit Tea', 'Titan', 20),
    ('Passion Fruit Fruit Tea', 'Medium', 0), ('Passion Fruit Fruit Tea', 'Large', 0), ('Passion Fruit Fruit Tea', 'Titan', 20),
    ('Blueberry Shake', 'Large', 0), ('Blueberry Shake', 'Titan', 20),
    ('Bubblegum Shake', 'Large', 0), ('Bubblegum Shake', 'Titan', 20),
    ('Buko Pandan Shake', 'Large', 0), ('Buko Pandan Shake', 'Titan', 20),
    ('Mango Shake', 'Large', 0), ('Mango Shake', 'Titan', 20),
    ('Ube Shake', 'Large', 0), ('Ube Shake', 'Titan', 20),
    ('Strawberry Shake', 'Large', 0), ('Strawberry Shake', 'Titan', 20),
    ('Biscoff Shake', 'Large', 0), ('Biscoff Shake', 'Titan', 20),
    ('Biscoff Coffee Shake', 'Large', 0), ('Biscoff Coffee Shake', 'Titan', 20)
) as v(item_name, size_name, price_offset)
JOIN menu_items ON menu_items.name = v.item_name
ON CONFLICT DO NOTHING;

-- 15. Add Milky Latte Flavors
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, flavor_name, 0, 'Flavor'
FROM (
  VALUES 
    ('Brown Sugar'), ('Caramel'), ('Hazelnut'), ('French Vanilla'), 
    ('Mocha'), ('Salted Caramel'), ('Vanilla'), ('White Chocolate')
) as f(flavor_name)
CROSS JOIN (SELECT id FROM menu_items WHERE name = 'Milky Latte') as item
ON CONFLICT DO NOTHING;

-- 16. Add Oat Milk to all Non-Espresso items
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT menu_items.id, 'Oat Milk', 50, 'Extras'
FROM menu_items
WHERE menu_items.category = 'non-espresso'
ON CONFLICT DO NOTHING;

-- 17. Add Frappe Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('frappe-espresso', 'Ice Blended Frappe (Espresso)', '🍧', 16, true),
  ('frappe-non-espresso', 'Ice Blended Frappe (Non-Espresso)', '🍧', 17, true)
ON CONFLICT (id) DO NOTHING;

-- 18. Add Espresso Frappe Menu Items
-- Group 1: 159 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Creamy espresso-based frappe.', 159, 'frappe-espresso', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Caramel Coffee Cream'), ('Hazelnut Coffee Cream'), ('Mocha Cream'), 
  ('Salted Caramel Coffee Cream'), ('Vanilla Coffee Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- Group 2: 179 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Premium espresso-based frappe.', 179, 'frappe-espresso', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Biscoff Coffee Cream'), ('Dark Chocolate Mocha Cream'), ('White Chocolate Mocha Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- Group 3: 199 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Specialty espresso-based frappe.', 199, 'frappe-espresso', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Coffee Jelly Frappe'), ('Peppermint Mocha Cream'), ('Peppermint Dark Choco Mocha Cream'), 
  ('Matcha Espresso Cream'), ('Ube Espresso Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 19. Add Non-Espresso Frappe Menu Items
-- Group 1: 159 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Refreshing cream-based frappe.', 159, 'frappe-non-espresso', false, true, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Buko Pandan Cream'), ('Bubblegum Cream'), ('Caramel Cream'), ('Hazelnut Cream'), 
  ('Mango Cream'), ('Salted Caramel Cream'), ('Strawberry Cream'), ('Vanilla Cream'), ('Ube Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- Group 2: 169 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Premium cream-based frappe.', 169, 'frappe-non-espresso', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Matcha Cream'), ('Oreo Cream'), ('Blueberry Cream'), ('White Chocolate Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- Group 3: 179 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Biscoff Cream', 'Indulgent Biscoff cream frappe.', 179, 'frappe-non-espresso', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Biscoff Cream');

-- Group 4: 189 Base (Large)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Specialty cream-based frappe.', 189, 'frappe-non-espresso', false, true, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Banana Biscoff Cream'), ('Dark Chocolate Cream'), ('Oreo Matcha Cream'), 
  ('Strawberry Oreo Cream'), ('Peppermint Choco Cream'), ('Peppermint Dark Choco Cream')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 20. Add Variations for Frappe Items (Large and Titan)
INSERT INTO variations (menu_item_id, name, price)
SELECT id, size_name, price_offset
FROM (
  VALUES 
    -- Espresso Frappes 159/179
    ('Caramel Coffee Cream', 'Large', 0), ('Caramel Coffee Cream', 'Titan', 20),
    ('Hazelnut Coffee Cream', 'Large', 0), ('Hazelnut Coffee Cream', 'Titan', 20),
    ('Mocha Cream', 'Large', 0), ('Mocha Cream', 'Titan', 20),
    ('Salted Caramel Coffee Cream', 'Large', 0), ('Salted Caramel Coffee Cream', 'Titan', 20),
    ('Vanilla Coffee Cream', 'Large', 0), ('Vanilla Coffee Cream', 'Titan', 20),
    -- Espresso Frappes 179/199
    ('Biscoff Coffee Cream', 'Large', 0), ('Biscoff Coffee Cream', 'Titan', 20),
    ('Dark Chocolate Mocha Cream', 'Large', 0), ('Dark Chocolate Mocha Cream', 'Titan', 20),
    ('White Chocolate Mocha Cream', 'Large', 0), ('White Chocolate Mocha Cream', 'Titan', 20),
    -- Espresso Frappes 199/219
    ('Coffee Jelly Frappe', 'Large', 0), ('Coffee Jelly Frappe', 'Titan', 20),
    ('Peppermint Mocha Cream', 'Large', 0), ('Peppermint Mocha Cream', 'Titan', 20),
    ('Peppermint Dark Choco Mocha Cream', 'Large', 0), ('Peppermint Dark Choco Mocha Cream', 'Titan', 20),
    ('Matcha Espresso Cream', 'Large', 0), ('Matcha Espresso Cream', 'Titan', 20),
    ('Ube Espresso Cream', 'Large', 0), ('Ube Espresso Cream', 'Titan', 20),
    
    -- Non-Espresso Frappes 159/179
    ('Buko Pandan Cream', 'Large', 0), ('Buko Pandan Cream', 'Titan', 20),
    ('Bubblegum Cream', 'Large', 0), ('Bubblegum Cream', 'Titan', 20),
    ('Caramel Cream', 'Large', 0), ('Caramel Cream', 'Titan', 20),
    ('Hazelnut Cream', 'Large', 0), ('Hazelnut Cream', 'Titan', 20),
    ('Mango Cream', 'Large', 0), ('Mango Cream', 'Titan', 20),
    ('Salted Caramel Cream', 'Large', 0), ('Salted Caramel Cream', 'Titan', 20),
    ('Strawberry Cream', 'Large', 0), ('Strawberry Cream', 'Titan', 20),
    ('Vanilla Cream', 'Large', 0), ('Vanilla Cream', 'Titan', 20),
    ('Ube Cream', 'Large', 0), ('Ube Cream', 'Titan', 20),
    -- Non-Espresso Frappes 169/189
    ('Matcha Cream', 'Large', 0), ('Matcha Cream', 'Titan', 20),
    ('Oreo Cream', 'Large', 0), ('Oreo Cream', 'Titan', 20),
    ('Blueberry Cream', 'Large', 0), ('Blueberry Cream', 'Titan', 20),
    ('White Chocolate Cream', 'Large', 0), ('White Chocolate Cream', 'Titan', 20),
    -- Non-Espresso Frappes 179/199
    ('Biscoff Cream', 'Large', 0), ('Biscoff Cream', 'Titan', 20),
    -- Non-Espresso Frappes 189/209
    ('Banana Biscoff Cream', 'Large', 0), ('Banana Biscoff Cream', 'Titan', 20),
    ('Dark Chocolate Cream', 'Large', 0), ('Dark Chocolate Cream', 'Titan', 20),
    ('Oreo Matcha Cream', 'Large', 0), ('Oreo Matcha Cream', 'Titan', 20),
    ('Strawberry Oreo Cream', 'Large', 0), ('Strawberry Oreo Cream', 'Titan', 20),
    ('Peppermint Choco Cream', 'Large', 0), ('Peppermint Choco Cream', 'Titan', 20),
    ('Peppermint Dark Choco Cream', 'Large', 0), ('Peppermint Dark Choco Cream', 'Titan', 20)
) as v(item_name, size_name, price_offset)
JOIN menu_items ON menu_items.name = v.item_name
ON CONFLICT DO NOTHING;

-- 21. Add Food and Dessert Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('rice-meals', 'Rice Meals', '🍚', 20, true),
  ('pasta', 'Pasta', '🍝', 21, true),
  ('snacks', 'Snacks', '🍟', 22, true),
  ('sandwich', 'Sandwich', '🥪', 23, true),
  ('dessert', 'Dessert', '🍨', 24, true)
ON CONFLICT (id) DO NOTHING;

-- 22. Add Rice Meals
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Hearty rice meal with egg.', 149, 'rice-meals', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES ('Hotdog with Egg'), ('Longganisa with Egg'), ('Spam with Egg'), ('Tocino with Egg')) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Premium rice meal with specialty toppings.', 179, 'rice-meals', false, true, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Tapa with Egg'), ('Cheesy Beef'), ('Cheesy Hotdog'), ('Cheesy Longganisa'), 
  ('Cheesy Spam'), ('Cheesy Tocino'), ('BBQ Pork Belly')
) as t(name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 23. Add Pasta
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Meaty Spaghetti', 'Classic sweet and savory spaghetti.', 149, 'pasta', true, true, 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Meaty Spaghetti');

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Creamy Carbonara', 'Rich and creamy white sauce pasta.', 169, 'pasta', true, true, 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Creamy Carbonara');

-- 24. Add Snacks
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Delicious snack option.', price, 'snacks', false, true, 'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Hashbrown', 79), 
  ('Churros with Dip', 139), 
  ('Churro Split', 149), 
  ('Fries', 79)
) as t(name, price)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Crispy toppings with savory sauce.', base_price, 'snacks', false, true, 'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Nachos Cheesy', 129), 
  ('Nachos Beefy', 149), 
  ('Poutine Fries Cheesy', 139), 
  ('Poutine Fries Beefy', 159)
) as t(name, base_price)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 25. Add Sandwich
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, 'Pressed sandwich served ala carte or as a combo.', base_price, 'sandwich', false, true, 'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (VALUES 
  ('Egg & Cheese', 99), ('Ham & Cheese', 99), ('Ham & Egg', 99),
  ('Spam & Cheese', 109), ('Spam & Egg', 109),
  ('Ham, Cheese & Egg', 129), ('Spam, Cheese & Egg', 129)
) as t(name, base_price)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = t.name);

-- 26. Add Dessert
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 'Ice Scramble', 'Classic Filipino frozen dessert.', 99, 'dessert', true, true, 'https://images.pexels.com/photos/1352296/pexels-photo-1352296.jpeg?auto=compress&cs=tinysrgb&w=800'
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Ice Scramble');

-- 27. Add Variations for Snacks, Sandwiches, and Dessert
INSERT INTO variations (menu_item_id, name, price)
SELECT id, '12 pcs', 60 FROM menu_items WHERE name = 'Churros with Dip'
ON CONFLICT DO NOTHING;

INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 20 FROM menu_items WHERE name = 'Fries'
ON CONFLICT DO NOTHING;

-- Nachos/Poutine Variations
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Sharing', offset_price
FROM (
  VALUES 
    ('Nachos Cheesy', 100), 
    ('Nachos Beefy', 140), 
    ('Poutine Fries Cheesy', 110), 
    ('Poutine Fries Beefy', 150)
) as v(name, offset_price)
JOIN menu_items ON menu_items.name = v.name
ON CONFLICT DO NOTHING;

-- Sandwich Variations (Combo)
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'With Reg Fries', 70 FROM menu_items WHERE category = 'sandwich'
ON CONFLICT DO NOTHING;

-- Ice Scramble Variations
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 20 FROM menu_items WHERE name = 'Ice Scramble'
ON CONFLICT DO NOTHING;

-- 28. Add Extras (Add-ons)
-- Rice Meals Extras
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, extra_name, 20, 'Extras'
FROM (VALUES ('Egg'), ('Rice')) as e(extra_name)
CROSS JOIN (SELECT id FROM menu_items WHERE category = 'rice-meals') as item
ON CONFLICT DO NOTHING;

-- Pasta Extras
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Bread w/ Butter', 20, 'Extras'
FROM menu_items WHERE category = 'pasta'
ON CONFLICT DO NOTHING;

-- Churros Extras
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Dip', 30, 'Extras'
FROM menu_items WHERE name = 'Churros with Dip'
ON CONFLICT DO NOTHING;

-- Ice Scramble Extras
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, extra_name, extra_price, 'Toppings'
FROM (VALUES 
  ('Candy Sprinkles', 10), 
  ('Marshmallow', 10), 
  ('Milk', 20), 
  ('Chocolate Syrup', 20)
) as toppings(extra_name, extra_price)
CROSS JOIN (SELECT id FROM menu_items WHERE name = 'Ice Scramble') as item
ON CONFLICT DO NOTHING;

