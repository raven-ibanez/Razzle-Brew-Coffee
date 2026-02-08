/*
  # Cleanup Sandwich Variations
  
  This migration removes the redundant "With Reg Fries" variation from sandwich items,
  leaving only "With Regular Fries" (and "No Fries").
*/

DELETE FROM variations
WHERE name = 'With Reg Fries'
AND menu_item_id IN (
  SELECT id FROM menu_items
  WHERE category = 'sandwich'
);
