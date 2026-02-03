import React from 'react';
import { useCategories } from '../hooks/useCategories';

interface SubNavProps {
  selectedCategory: string;
  onCategoryClick: (categoryId: string) => void;
}

const SubNav: React.FC<SubNavProps> = ({ selectedCategory, onCategoryClick }) => {
  const { categories, loading } = useCategories();

  return (
    <div className="sticky top-20 z-40 bg-razzle-dark/95 backdrop-blur-md border-b border-white/5">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center space-x-6 overflow-x-auto py-4 scrollbar-hide">
          {loading ? (
            <div className="flex space-x-6">
              {[1, 2, 3, 4, 5].map(i => (
                <div key={i} className="h-9 w-24 bg-razzle-surface rounded-lg animate-pulse" />
              ))}
            </div>
          ) : (
            <>
              <button
                onClick={() => onCategoryClick('all')}
                className={`px-4 py-2 rounded-lg text-xs font-bold tracking-widest uppercase transition-all duration-300 ${selectedCategory === 'all'
                  ? 'bg-razzle-gold text-razzle-dark shadow-lg shadow-razzle-gold/20'
                  : 'text-gray-500 hover:text-razzle-gold border border-transparent hover:border-razzle-gold/20'
                  }`}
              >
                All
              </button>
              {categories.map((c) => (
                <button
                  key={c.id}
                  onClick={() => onCategoryClick(c.id)}
                  className={`px-4 py-2 rounded-lg text-xs font-bold tracking-widest uppercase transition-all duration-300 whitespace-nowrap flex items-center space-x-2 ${selectedCategory === c.id
                    ? 'bg-razzle-gold text-razzle-dark shadow-lg shadow-razzle-gold/20'
                    : 'text-gray-500 hover:text-razzle-gold border border-transparent hover:border-razzle-gold/20'
                    }`}
                >
                  <span>{c.name}</span>
                </button>
              ))}
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default SubNav;


