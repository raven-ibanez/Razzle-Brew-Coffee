import React from 'react';
import { ShoppingCart } from 'lucide-react';

interface FloatingCartButtonProps {
  itemCount: number;
  onCartClick: () => void;
}

const FloatingCartButton: React.FC<FloatingCartButtonProps> = ({ itemCount, onCartClick }) => {
  if (itemCount === 0) return null;

  return (
    <button
      onClick={onCartClick}
      className="fixed bottom-6 right-6 bg-razzle-gold text-razzle-dark p-4 rounded-2xl shadow-[0_10px_30px_rgba(212,196,145,0.3)] hover:bg-white hover:scale-110 active:scale-95 transition-all duration-300 z-40 md:hidden animate-bounce-gentle"
    >
      <div className="relative">
        <ShoppingCart className="h-6 w-6" />
        <span className="absolute -top-6 -right-6 bg-white text-razzle-dark text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-bold border-2 border-razzle-gold shadow-lg">
          {itemCount}
        </span>
      </div>
    </button>
  );
};

export default FloatingCartButton;