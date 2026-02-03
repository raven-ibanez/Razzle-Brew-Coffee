import React from 'react';
import { ShoppingCart } from 'lucide-react';
import { useSiteSettings } from '../hooks/useSiteSettings';

interface HeaderProps {
  cartItemsCount: number;
  onCartClick: () => void;
  onMenuClick: () => void;
}

const Header: React.FC<HeaderProps> = ({ cartItemsCount, onCartClick, onMenuClick }) => {
  const { siteSettings, loading } = useSiteSettings();

  return (
    <header className="sticky top-0 z-50 bg-razzle-dark/80 backdrop-blur-md border-b border-white/5 shadow-lg">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-20">
          <button
            onClick={onMenuClick}
            className="flex items-center space-x-3 text-razzle-gold hover:text-white transition-all duration-300 group"
          >
            {loading ? (
              <div className="w-12 h-12 bg-razzle-surface rounded-lg animate-pulse" />
            ) : (
              <div className="relative overflow-hidden rounded-lg ring-1 ring-razzle-gold/20 group-hover:ring-razzle-gold/50 transition-all">
                <img
                  src={siteSettings?.site_logo || "/logo.jpg"}
                  alt={siteSettings?.site_name || "Razzle Brew"}
                  className="w-12 h-12 object-cover"
                  onError={(e) => {
                    e.currentTarget.src = "/logo.jpg";
                  }}
                />
              </div>
            )}
            <div className="flex flex-col items-start leading-none">
              <span className="text-lg md:text-xl font-brand font-bold logo-tracking">RAZZLE</span>
              <span className="text-[10px] md:text-sm font-brand font-medium text-razzle-gold/60 logo-tracking">BREW</span>
            </div>
          </button>

          <div className="flex items-center space-x-4">
            <button
              onClick={onCartClick}
              className="relative p-2.5 text-razzle-gold hover:text-white hover:bg-white/5 rounded-xl transition-all duration-300"
            >
              <ShoppingCart className="h-6 w-6" />
              {cartItemsCount > 0 && (
                <span className="absolute -top-1 -right-1 bg-razzle-gold text-razzle-dark text-[10px] font-bold rounded-full h-5 w-5 flex items-center justify-center animate-bounce-gentle shadow-lg">
                  {cartItemsCount}
                </span>
              )}
            </button>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;