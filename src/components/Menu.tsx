import React from 'react';
import { MenuItem, CartItem } from '../types';
import { useCategories } from '../hooks/useCategories';
import MenuItemCard from './MenuItemCard';

// Preload images for better performance
const preloadImages = (items: MenuItem[]) => {
  items.forEach(item => {
    if (item.image) {
      const img = new Image();
      img.src = item.image;
    }
  });
};

interface MenuProps {
  menuItems: MenuItem[];
  addToCart: (item: MenuItem, quantity?: number, variation?: any, addOns?: any[]) => void;
  cartItems: CartItem[];
  updateQuantity: (id: string, quantity: number) => void;
}

const Menu: React.FC<MenuProps> = ({ menuItems, addToCart, cartItems, updateQuantity }) => {
  const { categories } = useCategories();
  const [activeCategory, setActiveCategory] = React.useState('hot-coffee');

  // Preload images when menu items change
  React.useEffect(() => {
    if (menuItems.length > 0) {
      // Preload images for visible category first
      const visibleItems = menuItems.filter(item => item.category === activeCategory);
      preloadImages(visibleItems);

      // Then preload other images after a short delay
      setTimeout(() => {
        const otherItems = menuItems.filter(item => item.category !== activeCategory);
        preloadImages(otherItems);
      }, 1000);
    }
  }, [menuItems, activeCategory]);

  React.useEffect(() => {
    if (categories.length > 0) {
      // Set default to hot-coffee if it exists, otherwise first category
      const defaultCategory = categories.find(cat => cat.id === 'hot-coffee') || categories[0];
      if (!categories.find(cat => cat.id === activeCategory)) {
        setActiveCategory(defaultCategory.id);
      }
    }
  }, [categories, activeCategory]);

  React.useEffect(() => {
    const handleScroll = () => {
      const sections = categories.map(cat => document.getElementById(cat.id)).filter(Boolean);
      const scrollPosition = window.scrollY + 200;

      for (let i = sections.length - 1; i >= 0; i--) {
        const section = sections[i];
        if (section && section.offsetTop <= scrollPosition) {
          setActiveCategory(categories[i].id);
          break;
        }
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);


  return (
    <>
      <main id="menu" className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
        <div className="text-center mb-20 pointer-events-none">
          <h2 className="text-4xl font-brand font-bold text-white mb-6 logo-tracking animate-fade-in">
            THE SELECTION
          </h2>
          <div className="h-1 w-16 bg-razzle-gold mx-auto rounded-full opacity-50 mb-8" />
          <p className="text-gray-500 max-w-2xl mx-auto font-medium tracking-wide">
            Discover our curated selection of
            premium coffee beverages and handcrafted treats.
          </p>
        </div>

        {categories.map((category) => {
          const categoryItems = menuItems.filter(item => item.category === category.id);

          if (categoryItems.length === 0) return null;

          return (
            <section key={category.id} id={category.id} className="mb-24 last:mb-0">
              <div className="flex flex-col items-center mb-12">
                <div className="flex items-center space-x-3 mb-2">
                  <h3 className="text-2xl font-brand font-bold text-razzle-gold uppercase tracking-[0.2em]">{category.name}</h3>
                </div>
                <div className="h-px w-32 bg-gradient-to-r from-transparent via-razzle-gold/30 to-transparent" />
              </div>

              <div className="grid grid-cols-1 gap-0 max-w-2xl mx-auto">
                {categoryItems.map((item) => {
                  const cartItem = cartItems.find(cartItem => cartItem.id === item.id);
                  return (
                    <MenuItemCard
                      key={item.id}
                      item={item}
                      onAddToCart={addToCart}
                      quantity={cartItem?.quantity || 0}
                      onUpdateQuantity={updateQuantity}
                    />
                  );
                })}
              </div>
            </section>
          );
        })}
      </main>
    </>
  );
};

export default Menu;