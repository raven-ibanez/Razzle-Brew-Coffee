/*
  # Add sort_order to menu_items and reorder rice meals

  This migration:
  1. Adds a `sort_order` column to `menu_items` (defaults 0, so existing items stay unaffected).
  2. Sets explicit sort_order for rice meal items so all regular items come first,
     then all cheesy items are grouped together.

  Desired order:
    1. Hotdog with Egg
    2. Longganisa with Egg
    3. Spam with Egg
    4. Tocino with Egg
    5. Tapa with Egg
    6. BBQ Pork Belly
    7. Cheesy Beef
    8. Cheesy Hotdog
    9. Cheesy Longganisa
   10. Cheesy Spam
   11. Cheesy Tocino
*/

-- 1. Add sort_order column to menu_items (no-op if already exists)
ALTER TABLE menu_items
  ADD COLUMN IF NOT EXISTS sort_order integer NOT NULL DEFAULT 0;

-- 2. Set sort order for rice meal items
UPDATE menu_items SET sort_order = 1  WHERE name = 'Hotdog with Egg'     AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 2  WHERE name = 'Longganisa with Egg' AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 3  WHERE name = 'Spam with Egg'       AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 4  WHERE name = 'Tocino with Egg'     AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 5  WHERE name = 'Tapa with Egg'       AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 6  WHERE name = 'BBQ Pork Belly'      AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 7  WHERE name = 'Cheesy Beef'         AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 8  WHERE name = 'Cheesy Hotdog'       AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 9  WHERE name = 'Cheesy Longganisa'   AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 10 WHERE name = 'Cheesy Spam'         AND category = 'rice-meals';
UPDATE menu_items SET sort_order = 11 WHERE name = 'Cheesy Tocino'       AND category = 'rice-meals';
