/*
  # Update Sandwich Options
  
  This migration:
  1. Adds "No Fries" variation (₱0) to all sandwich items.
  2. Ensures "With Regular Fries" variation (₱70) is available for all sandwich items.
  3. Adds fries flavor choices (Plain salted, Bbq, Cheese, Sour cream) as add-ons to all sandwiches.
*/

-- 1. Add "No Fries" variation to all sandwiches
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'No Fries', 0
FROM menu_items
WHERE category = 'sandwich'
AND NOT EXISTS (
  SELECT 1 FROM variations 
  WHERE menu_item_id = menu_items.id 
  AND name = 'No Fries'
);

-- 2. Ensure "With Regular Fries" variation is available (standardizing the name)
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'With Regular Fries', 70
FROM menu_items
WHERE category = 'sandwich'
AND NOT EXISTS (
  SELECT 1 FROM variations 
  WHERE menu_item_id = menu_items.id 
  AND name = 'With Regular Fries'
);

-- 3. Add Fries Flavor add-ons to all sandwiches
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT items.id, f.name, 0, 'Fries Flavor'
FROM menu_items items
CROSS JOIN (
  VALUES 
    ('Plain salted'),
    ('Bbq'),
    ('Cheese'),
    ('Sour cream')
) as f(name)
WHERE items.category = 'sandwich'
AND NOT EXISTS (
  SELECT 1 FROM add_ons 
  WHERE menu_item_id = items.id 
  AND name = f.name
);
