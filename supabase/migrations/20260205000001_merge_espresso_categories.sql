/*
  # Merge Espresso Categories
  
  Consolidates 'espresso-americano' and 'espresso-latte' into a single 'espresso' category.
*/

-- 1. Create the new consolidated category
INSERT INTO categories (id, name, icon, sort_order, active)
VALUES ('espresso', 'ESPRESSO', '☕', 10, true)
ON CONFLICT (id) DO UPDATE SET name = 'ESPRESSO';

-- 2. Update existing menu items to the new category
UPDATE menu_items 
SET category = 'espresso'
WHERE category IN ('espresso-americano', 'espresso-latte');

-- 3. Update any references in add_ons (if any explicitly use category strings)
-- Note: Most add_ons in this project are linked via menu_item_id, 
-- but we should ensure any manual filters are updated if they exist.

-- 4. Delete the old categories
DELETE FROM categories 
WHERE id IN ('espresso-americano', 'espresso-latte');
