/*
  # Rename Ice Scramble add-on category from 'Toppings' to 'Extras'
*/

UPDATE add_ons
SET category = 'Extras'
WHERE category = 'Toppings'
AND menu_item_id IN (
  SELECT id FROM menu_items WHERE name = 'Ice Scramble'
);
