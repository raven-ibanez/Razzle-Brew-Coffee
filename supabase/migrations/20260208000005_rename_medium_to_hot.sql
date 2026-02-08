/*
  # Rename 'Medium' Variation to 'Hot'
  
  This migration:
  1. Updates the `variations` table to rename 'Medium' to 'Hot'.
  2. Specifically targets items in 'espresso' and 'non-espresso' categories.
  3. Excludes cold-only categories like juices, shakes, and desserts as requested.
*/

UPDATE variations
SET name = 'Hot'
WHERE name = 'Medium'
AND menu_item_id IN (
  SELECT id FROM menu_items
  WHERE category IN ('espresso', 'non-espresso')
);
