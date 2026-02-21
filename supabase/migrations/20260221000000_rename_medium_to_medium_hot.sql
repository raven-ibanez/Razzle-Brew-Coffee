/*
  # Rename 'Medium' / 'Hot' Variation to 'Medium (Hot)'

  This migration:
  1. Renames any 'Medium' variation to 'Medium (Hot)' for all menu items
     EXCEPT Ice Scramble.
  2. Renames any 'Hot' variation to 'Medium (Hot)' for all menu items
     (previously set by the rename_medium_to_hot migration).
*/

-- Rename 'Hot' -> 'Medium (Hot)' for all items
UPDATE variations
SET name = 'Medium (Hot)'
WHERE name = 'Hot';

-- Rename 'Medium' -> 'Medium (Hot)' for all items EXCEPT Ice Scramble
UPDATE variations
SET name = 'Medium (Hot)'
WHERE name = 'Medium'
AND menu_item_id NOT IN (
  SELECT id FROM menu_items WHERE name = 'Ice Scramble'
);
