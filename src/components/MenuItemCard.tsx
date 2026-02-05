import React, { useState } from 'react';
import { Plus, Minus, X } from 'lucide-react';
import { MenuItem, Variation, AddOn } from '../types';

interface MenuItemCardProps {
  item: MenuItem;
  onAddToCart: (item: MenuItem, quantity?: number, variation?: Variation, addOns?: AddOn[]) => void;
  quantity: number;
  onUpdateQuantity: (id: string, quantity: number) => void;
}

const MenuItemCard: React.FC<MenuItemCardProps> = ({
  item,
  onAddToCart,
  quantity,
  onUpdateQuantity
}) => {
  const [showCustomization, setShowCustomization] = useState(false);
  const [selectedVariation, setSelectedVariation] = useState<Variation | undefined>(
    item.variations?.[0]
  );
  const [selectedAddOns, setSelectedAddOns] = useState<(AddOn & { quantity: number })[]>([]);

  const calculatePrice = () => {
    let price = item.effectivePrice || item.basePrice;
    if (selectedVariation) {
      price = (item.effectivePrice || item.basePrice) + selectedVariation.price;
    }
    selectedAddOns.forEach(addOn => {
      price += addOn.price * addOn.quantity;
    });
    return price;
  };

  const handleAddToCart = () => {
    if (item.variations?.length || item.addOns?.length) {
      setShowCustomization(true);
    } else {
      onAddToCart(item, 1);
    }
  };

  const handleCustomizedAddToCart = () => {
    const addOnsForCart: AddOn[] = selectedAddOns.flatMap(addOn =>
      Array(addOn.quantity).fill({ ...addOn, quantity: undefined })
    );
    onAddToCart(item, 1, selectedVariation, addOnsForCart);
    setShowCustomization(false);
    setSelectedAddOns([]);
  };

  const handleIncrement = () => {
    onUpdateQuantity(item.id, quantity + 1);
  };

  const handleDecrement = () => {
    if (quantity > 0) {
      onUpdateQuantity(item.id, quantity - 1);
    }
  };

  const updateAddOnQuantity = (addOn: AddOn, quantity: number) => {
    setSelectedAddOns(prev => {
      const existingIndex = prev.findIndex(a => a.id === addOn.id);
      if (quantity === 0) return prev.filter(a => a.id !== addOn.id);
      if (existingIndex >= 0) {
        const updated = [...prev];
        updated[existingIndex] = { ...updated[existingIndex], quantity };
        return updated;
      } else {
        return [...prev, { ...addOn, quantity }];
      }
    });
  };

  const groupedAddOns = item.addOns?.reduce((groups, addOn) => {
    const category = addOn.category;
    if (!groups[category]) groups[category] = [];
    groups[category].push(addOn);
    return groups;
  }, {} as Record<string, AddOn[]>);

  return (
    <>
      <div className={`transition-all duration-300 flex items-center p-2 border-none bg-transparent ${!item.available ? 'opacity-50 grayscale' : ''}`}>


        {/* Product Name and Price */}
        <div className="flex-1 min-w-0 flex items-center justify-between mr-4 md:mr-8 border-b border-white/5 pb-1">
          <h4 className="text-xs md:text-base font-brand font-bold text-white uppercase truncate mr-2">{item.name}</h4>

          <div className="flex-shrink-0 flex items-center">
            {item.isOnDiscount && item.discountPrice ? (
              <div className="flex items-center space-x-2">
                <span className="text-sm md:text-base font-bold text-white font-brand whitespace-nowrap">
                  ₱{item.discountPrice.toFixed(0)}
                </span>
                <span className="text-[8px] md:text-[10px] text-gray-500 line-through whitespace-nowrap">
                  ₱{item.basePrice.toFixed(0)}
                </span>
              </div>
            ) : (
              <span className="text-sm md:text-base font-bold text-white font-brand whitespace-nowrap">
                ₱{item.basePrice.toFixed(0)}
              </span>
            )}
          </div>
        </div>

        {/* Right: Add/Quantity Controls */}
        <div className="ml-2 md:ml-4 flex-shrink-0">
          {!item.available ? (
            <span className="text-[10px] font-bold text-gray-600 uppercase tracking-widest px-1">N/A</span>
          ) : quantity === 0 ? (
            <button
              onClick={handleAddToCart}
              className="bg-razzle-gold text-razzle-dark px-4 py-1.5 md:px-5 md:py-2 rounded-full hover:bg-white transition-all duration-300 font-bold text-[10px] md:text-xs tracking-widest uppercase flex items-center shadow-lg shadow-razzle-gold/10"
            >
              <span className="inline">Add</span>
              <Plus className="h-3 w-3 md:h-4 md:w-4 ml-1.5" />
            </button>
          ) : (
            <div className="flex flex-col items-center space-y-1 md:space-y-0 md:flex-row md:items-center md:space-x-3 bg-white/5 md:bg-white/5 rounded-full md:rounded-full p-1 border border-white/10">
              <button
                onClick={handleDecrement}
                className="p-1 hover:bg-white/10 rounded-full transition-all duration-300 text-razzle-gold"
              >
                <Minus className="h-3 w-3 md:h-4 md:w-4" />
              </button>
              <span className="font-bold text-white text-[10px] md:text-sm min-w-[12px] text-center">{quantity}</span>
              <button
                onClick={handleIncrement}
                className="p-1 hover:bg-white/10 rounded-full transition-all duration-300 text-razzle-gold"
              >
                <Plus className="h-3 w-3 md:h-4 md:w-4" />
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Customization Modal */}
      {showCustomization && (
        <div className="fixed inset-0 bg-razzle-dark/90 backdrop-blur-md flex items-center justify-center z-[100] p-4 animate-fade-in">
          <div className="bg-razzle-surface border border-white/10 rounded-3xl max-w-lg w-full max-h-[90vh] overflow-y-auto shadow-[0_0_100px_rgba(0,0,0,0.8)]">
            <div className="sticky top-0 bg-razzle-surface/80 backdrop-blur-lg border-b border-white/5 p-8 flex items-center justify-between rounded-t-3xl z-20">
              <div className="flex flex-col items-start">
                <span className="text-razzle-gold text-[10px] font-bold tracking-[0.3em] uppercase mb-2">Personalize</span>
                <h3 className="text-2xl font-brand font-bold text-white uppercase tracking-wider">{item.name}</h3>
              </div>
              <button
                onClick={() => setShowCustomization(false)}
                className="p-2.5 hover:bg-white/5 rounded-full transition-all duration-300 text-gray-500 hover:text-white border border-transparent hover:border-white/10"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <div className="p-8">
              {item.variations && item.variations.length > 0 && (
                <div className="mb-10">
                  <h4 className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-6">Select Size</h4>
                  <div className="grid grid-cols-1 gap-3">
                    {item.variations.map((variation) => (
                      <label
                        key={variation.id}
                        className={`flex items-center justify-between p-5 border rounded-2xl cursor-pointer transition-all duration-300 ${selectedVariation?.id === variation.id
                          ? 'border-razzle-gold bg-razzle-gold/5'
                          : 'border-white/5 hover:border-white/20 hover:bg-white/5'
                          }`}
                      >
                        <div className="flex items-center space-x-4">
                          <input
                            type="radio"
                            name="variation"
                            checked={selectedVariation?.id === variation.id}
                            onChange={() => setSelectedVariation(variation)}
                            className="w-5 h-5 accent-razzle-gold"
                          />
                          <span className="text-white font-bold tracking-wide">{variation.name}</span>
                        </div>
                        <span className="text-razzle-gold font-bold">+ ₱{variation.price}</span>
                      </label>
                    ))}
                  </div>
                </div>
              )}

              {groupedAddOns && Object.entries(groupedAddOns).map(([category, addOns]) => (
                <div key={category} className="mb-10 last:mb-0">
                  <h4 className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-6">{category}</h4>
                  <div className="grid grid-cols-1 gap-3">
                    {addOns.map((addOn) => {
                      const selected = selectedAddOns.find(a => a.id === addOn.id);
                      return (
                        <div
                          key={addOn.id}
                          className={`flex items-center justify-between p-5 border rounded-2xl transition-all duration-300 ${selected
                            ? 'border-razzle-gold bg-razzle-gold/5'
                            : 'border-white/5 hover:border-white/20'
                            }`}
                        >
                          <div className="flex flex-col">
                            <span className="text-white font-bold tracking-wide">{addOn.name}</span>
                            <span className="text-razzle-gold/60 text-xs font-bold mt-1">+ ₱{addOn.price}</span>
                          </div>

                          <div className="flex items-center space-x-4">
                            {selected ? (
                              <div className="flex items-center space-x-4 bg-white/5 rounded-xl p-1 border border-white/10">
                                <button
                                  onClick={() => updateAddOnQuantity(addOn, selected.quantity - 1)}
                                  className="p-1.5 hover:bg-white/10 rounded-lg transition-all duration-300 text-razzle-gold"
                                >
                                  <Minus className="h-4 w-4" />
                                </button>
                                <span className="text-white font-bold min-w-[20px] text-center">{selected.quantity}</span>
                                <button
                                  onClick={() => updateAddOnQuantity(addOn, selected.quantity + 1)}
                                  className="p-1.5 hover:bg-white/10 rounded-lg transition-all duration-300 text-razzle-gold"
                                >
                                  <Plus className="h-4 w-4" />
                                </button>
                              </div>
                            ) : (
                              <button
                                onClick={() => updateAddOnQuantity(addOn, 1)}
                                className="px-5 py-2 rounded-xl bg-white/5 hover:bg-white/10 text-white text-xs font-bold uppercase tracking-widest transition-all"
                              >
                                Add
                              </button>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              ))}
            </div>

            <div className="sticky bottom-0 bg-razzle-surface/80 backdrop-blur-lg border-t border-white/5 p-8 flex items-center justify-between z-20">
              <div className="flex flex-col">
                <span className="text-gray-500 text-[10px] font-bold uppercase tracking-widest mb-1">Total Price</span>
                <span className="text-3xl font-brand font-bold text-white">₱{calculatePrice()}</span>
              </div>
              <button
                onClick={handleCustomizedAddToCart}
                className="bg-razzle-gold text-razzle-dark px-10 py-5 rounded-2xl hover:bg-white transition-all duration-500 font-bold text-sm uppercase tracking-widest shadow-2xl shadow-razzle-gold/20"
              >
                Add To Cart
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default MenuItemCard;