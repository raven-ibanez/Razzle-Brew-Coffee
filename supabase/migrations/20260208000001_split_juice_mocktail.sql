/*
  # Split Juice & Mocktail Category
  
  This migration:
  1. Creates separate categories for 'JUICE' and 'MOCKTAIL'.
  2. Duplicates items from the old 'Juice & Mocktail' category into both new ones.
  3. Re-applies the standard variations (Medium, Large, Titan) to all new items.
  4. Removes the old 'Juice & Mocktail' category.
*/

-- 1. Create the new categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('juice', 'JUICE', '🍹', 13, true),
  ('mocktail', 'MOCKTAIL', '🍹', 14, true)
ON CONFLICT (id) DO UPDATE SET active = true;

-- 2. Duplicate Juice items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, description, base_price, 'juice', popular, available, image_url
FROM menu_items
WHERE category = 'juice-mocktail';

-- 3. Duplicate Mocktail items
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url)
SELECT name, description, base_price, 'mocktail', popular, available, image_url
FROM menu_items
WHERE category = 'juice-mocktail';

-- 4. Re-apply standard variations to all new items in Juice and Mocktail categories
-- Standard variations: Medium (0), Large (0), Titan (20)
INSERT INTO variations (menu_item_id, name, price)
SELECT items.id, v.name, v.price
FROM menu_items items
CROSS JOIN (
  VALUES 
    ('Medium', 0),
    ('Large', 0),
    ('Titan', 20)
) as v(name, price)
WHERE items.category IN ('juice', 'mocktail')
ON CONFLICT DO NOTHING;

-- 5. Delete the old items and their dependencies first to satisfy foreign key constraints
DELETE FROM variations 
WHERE menu_item_id IN (SELECT id FROM menu_items WHERE category = 'juice-mocktail');

DELETE FROM add_ons 
WHERE menu_item_id IN (SELECT id FROM menu_items WHERE category = 'juice-mocktail');

DELETE FROM menu_items 
WHERE category = 'juice-mocktail';

-- 6. Finally delete the old collective category
DELETE FROM categories 
WHERE id = 'juice-mocktail';
