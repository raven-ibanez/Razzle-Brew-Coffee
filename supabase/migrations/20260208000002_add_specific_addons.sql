/*
  # Add Category-Specific Add-ons
  
  This migration:
  1. Adds 'NATA' (50) to all products in the 'Fruit Tea' category.
  2. Adds 'Syrup' (30), 'Oat milk' (50), and 'Coffee jelly' (50) to all products in the 'Ice Blended Espresso' category.
  
  Uses WHERE NOT EXISTS to avoid duplication since unique constraints on (menu_item_id, name) vary.
*/

-- 1. Add 'NATA' to all items in fruit-tea category
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'NATA', 50, 'Extras'
FROM menu_items
WHERE category = 'fruit-tea'
AND NOT EXISTS (
  SELECT 1 FROM add_ons 
  WHERE menu_item_id = menu_items.id 
  AND name = 'NATA'
);

-- 2. Add 'Syrup', 'Oat milk', and 'Coffee jelly' to ice blended espresso items
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT items.id, addon.name, addon.price, 'Extras'
FROM menu_items items
CROSS JOIN (
  VALUES 
    ('Syrup', 30),
    ('Oat milk', 50),
    ('Coffee jelly', 50)
) as addon(name, price)
WHERE items.category = 'frappe-espresso'
AND NOT EXISTS (
  SELECT 1 FROM add_ons 
  WHERE menu_item_id = items.id 
  AND name = addon.name
);
