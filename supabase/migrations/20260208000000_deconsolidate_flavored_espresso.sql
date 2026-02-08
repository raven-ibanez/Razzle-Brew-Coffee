/*
  # Deconsolidate Flavored Espresso Drinks
  
  This migration:
  1. Creates individual menu items for each flavor previously under "Flavored Americano" and "Flavored Latte".
  2. Adds standard variations (Medium, Large, Titan) to each new item.
  3. Adds global extras (Syrups, Espresso Shot, Oat Milk, Whip Cream) to each new item.
  4. Removes the old collective "Flavored Americano" and "Flavored Latte" items.
*/

-- 1. Create individual Flavored Americano items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 
  flavor_name || ' Americano',
  'Rich espresso with hot water and ' || LOWER(flavor_name) || ' syrup.',
  119,
  'espresso',
  false,
  true,
  'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (
  VALUES 
    ('Brown Sugar'), ('Caramel'), ('Hazelnut'), ('French Vanilla'), 
    ('Mocha'), ('Salted Caramel'), ('Vanilla'), ('White Chocolate')
) as f(flavor_name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = f.flavor_name || ' Americano');

-- 2. Create individual Flavored Latte items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT 
  flavor_name || ' Latte',
  'Smooth espresso, steamed milk, and ' || LOWER(flavor_name) || ' syrup.',
  129,
  'espresso',
  false,
  true,
  'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg?auto=compress&cs=tinysrgb&w=800'
FROM (
  VALUES 
    ('Brown Sugar'), ('Caramel'), ('French Vanilla'), ('Hazelnut'), 
    ('Mocha'), ('Salted Caramel'), ('Spanish'), ('Vanilla')
) as f(flavor_name)
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = f.flavor_name || ' Latte');

-- 3. Add variations for all new flavored items
WITH new_items AS (
  SELECT id FROM menu_items WHERE name IN (
    'Brown Sugar Americano', 'Caramel Americano', 'Hazelnut Americano', 'French Vanilla Americano', 
    'Mocha Americano', 'Salted Caramel Americano', 'Vanilla Americano', 'White Chocolate Americano',
    'Brown Sugar Latte', 'Caramel Latte', 'French Vanilla Latte', 'Hazelnut Latte', 
    'Mocha Latte', 'Salted Caramel Latte', 'Spanish Latte', 'Vanilla Latte'
  )
)
INSERT INTO variations (menu_item_id, name, price)
SELECT new_items.id, v.name, v.price
FROM new_items
CROSS JOIN (
  VALUES 
    ('Medium', 0),
    ('Large', 0),
    ('Titan', 20)
) as v(name, price)
ON CONFLICT DO NOTHING;

-- 4. Add global extras for all new flavored items
WITH new_items AS (
  SELECT id FROM menu_items WHERE name IN (
    'Brown Sugar Americano', 'Caramel Americano', 'Hazelnut Americano', 'French Vanilla Americano', 
    'Mocha Americano', 'Salted Caramel Americano', 'Vanilla Americano', 'White Chocolate Americano',
    'Brown Sugar Latte', 'Caramel Latte', 'French Vanilla Latte', 'Hazelnut Latte', 
    'Mocha Latte', 'Salted Caramel Latte', 'Spanish Latte', 'Vanilla Latte'
  )
)
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT new_items.id, addon.name, addon.price, 'Extras'
FROM new_items
CROSS JOIN (
  VALUES 
    ('Syrups', 30),
    ('Espresso Shot', 30),
    ('Oat Milk', 50),
    ('Whip Cream', 50)
) as addon(name, price)
ON CONFLICT DO NOTHING;

-- 5. Delete the old collective items
-- This will also cascade delete their specific flavor add-ons
DELETE FROM menu_items 
WHERE name IN ('Flavored Americano', 'Flavored Latte');
