/*
  # Update Ice Scramble Variations
  
  This migration:
  1. Adds "Medium" variation (₱0) to the "Ice Scramble" item.
  2. Ensures "Large" variation (₱20) is available for "Ice Scramble".
*/

-- 1. Add "Medium" variation to Ice Scramble
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Medium', 0
FROM menu_items
WHERE name = 'Ice Scramble'
AND NOT EXISTS (
  SELECT 1 FROM variations 
  WHERE menu_item_id = menu_items.id 
  AND name = 'Medium'
);

-- 2. Ensure "Large" variation is available for Ice Scramble
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 20
FROM menu_items
WHERE name = 'Ice Scramble'
AND NOT EXISTS (
  SELECT 1 FROM variations 
  WHERE menu_item_id = menu_items.id 
  AND name = 'Large'
);
