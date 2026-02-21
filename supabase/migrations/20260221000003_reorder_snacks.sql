/*
  # Reorder Snacks category

  Sets explicit sort_order for snack items so related items are grouped together:
    1. Hashbrown
    2. Fries
    3. Churros with Dip
    4. Churro Split
    5. Nachos Cheesy
    6. Nachos Beefy
    7. Poutine Fries Cheesy
    8. Poutine Fries Beefy
*/

UPDATE menu_items SET sort_order = 1 WHERE name = 'Hashbrown'          AND category = 'snacks';
UPDATE menu_items SET sort_order = 2 WHERE name = 'Fries'              AND category = 'snacks';
UPDATE menu_items SET sort_order = 3 WHERE name = 'Churros with Dip'  AND category = 'snacks';
UPDATE menu_items SET sort_order = 4 WHERE name = 'Churro Split'       AND category = 'snacks';
UPDATE menu_items SET sort_order = 5 WHERE name = 'Nachos Cheesy'      AND category = 'snacks';
UPDATE menu_items SET sort_order = 6 WHERE name = 'Nachos Beefy'       AND category = 'snacks';
UPDATE menu_items SET sort_order = 7 WHERE name = 'Poutine Fries Cheesy' AND category = 'snacks';
UPDATE menu_items SET sort_order = 8 WHERE name = 'Poutine Fries Beefy'  AND category = 'snacks';
