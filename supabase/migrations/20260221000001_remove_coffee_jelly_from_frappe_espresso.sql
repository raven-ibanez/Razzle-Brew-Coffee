/*
  # Remove 'Coffee jelly' Add-on from Ice Blended Frappe (Espresso)

  This migration:
  1. Deletes the 'Coffee jelly' add-on from all items in the 'frappe-espresso' category.
*/

DELETE FROM add_ons
WHERE name = 'Coffee jelly'
AND menu_item_id IN (
  SELECT id FROM menu_items WHERE category = 'frappe-espresso'
);
