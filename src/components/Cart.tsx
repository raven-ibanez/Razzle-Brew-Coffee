import React from 'react';
import { Trash2, Plus, Minus, ArrowLeft, ShoppingCart } from 'lucide-react';
import { CartItem } from '../types';

interface CartProps {
  cartItems: CartItem[];
  updateQuantity: (id: string, quantity: number) => void;
  removeFromCart: (id: string) => void;
  clearCart: () => void;
  getTotalPrice: () => number;
  onContinueShopping: () => void;
  onCheckout: () => void;
}

const Cart: React.FC<CartProps> = ({
  cartItems,
  updateQuantity,
  removeFromCart,
  clearCart,
  getTotalPrice,
  onContinueShopping,
  onCheckout
}) => {
  if (cartItems.length === 0) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-24">
        <div className="text-center py-20 glass-panel rounded-3xl border border-white/5">
          <div className="text-7xl mb-6 opacity-20 border-2 border-razzle-gold/20 rounded-full w-24 h-24 mx-auto flex items-center justify-center">
            <ShoppingCart className="w-10 h-10 text-razzle-gold" />
          </div>
          <h2 className="text-2xl font-brand font-bold text-white mb-2 tracking-widest uppercase">Your cart is empty</h2>
          <p className="text-gray-500 mb-10 font-medium">Add some delicious brews to get started!</p>
          <button
            onClick={onContinueShopping}
            className="bg-razzle-gold text-razzle-dark px-10 py-4 rounded-xl hover:bg-white transition-all duration-300 font-bold tracking-widest text-sm uppercase shadow-2xl shadow-razzle-gold/10"
          >
            Browse Menu
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto px-4 py-12 animate-fade-in">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
        <button
          onClick={onContinueShopping}
          className="flex items-center space-x-2 text-gray-500 hover:text-razzle-gold transition-all duration-300 group"
        >
          <div className="p-2 rounded-lg bg-white/5 group-hover:bg-razzle-gold/10 transition-colors">
            <ArrowLeft className="h-5 w-5" />
          </div>
          <span className="font-bold text-xs tracking-widest uppercase">Continue Shopping</span>
        </button>

        <div className="flex items-center space-x-6">
          <h1 className="text-3xl font-brand font-bold text-white tracking-[0.2em] uppercase">Your Order</h1>
          <button
            onClick={clearCart}
            className="text-[10px] font-bold text-red-500 uppercase tracking-widest hover:text-red-400 transition-colors"
          >
            Clear All
          </button>
        </div>
      </div>

      <div className="glass-panel border-white/5 rounded-3xl overflow-hidden mb-8 shadow-2xl">
        {cartItems.map((item, index) => (
          <div key={item.id} className={`p-4 md:p-8 ${index !== cartItems.length - 1 ? 'border-b border-white/5' : ''} group hover:bg-white/[0.02] transition-colors`}>
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 md:gap-6">
              <div className="flex-1">
                <h3 className="text-lg md:text-xl font-brand font-bold text-white mb-1 md:mb-2 tracking-wide uppercase">{item.name}</h3>
                <div className="flex flex-wrap gap-2 mb-3">
                  {item.selectedVariation && (
                    <span className="text-[10px] font-bold bg-razzle-gold/10 text-razzle-gold px-2 py-1 rounded uppercase tracking-wider">
                      {item.selectedVariation.name}
                    </span>
                  )}
                  {item.selectedAddOns && item.selectedAddOns.length > 0 && item.selectedAddOns.map((addOn, i) => (
                    <span key={i} className="text-[10px] font-bold bg-white/5 text-gray-400 px-2 py-1 rounded uppercase tracking-wider">
                      +{addOn.name} {addOn.quantity && addOn.quantity > 1 ? `x${addOn.quantity}` : ''}
                    </span>
                  ))}
                </div>
                <p className="text-lg md:text-xl font-brand font-bold text-razzle-gold">₱{item.totalPrice.toFixed(0)}</p>
              </div>

              <div className="flex items-center justify-between sm:justify-end space-x-4 md:space-x-6">
                <div className="flex items-center space-x-2 md:space-x-4 bg-white/5 rounded-xl p-1 border border-white/10">
                  <button
                    onClick={() => updateQuantity(item.id, item.quantity - 1)}
                    className="p-1.5 md:p-2 hover:bg-white/10 rounded-lg transition-all duration-300 text-razzle-gold"
                  >
                    <Minus className="h-4 w-4" />
                  </button>
                  <span className="font-bold text-white min-w-[20px] text-center text-xs md:text-sm">{item.quantity}</span>
                  <button
                    onClick={() => updateQuantity(item.id, item.quantity + 1)}
                    className="p-1.5 md:p-2 hover:bg-white/10 rounded-lg transition-all duration-300 text-razzle-gold"
                  >
                    <Plus className="h-4 w-4" />
                  </button>
                </div>

                <div className="text-right min-w-[80px] md:min-w-[100px]">
                  <p className="text-xl md:text-2xl font-brand font-bold text-white">₱{(item.totalPrice * item.quantity).toFixed(0)}</p>
                </div>

                <button
                  onClick={() => removeFromCart(item.id)}
                  className="p-2 md:p-3 text-red-500/50 hover:text-red-500 hover:bg-red-500/10 rounded-xl transition-all duration-300"
                >
                  <Trash2 className="h-5 w-5" />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="glass-panel border-white/10 rounded-3xl p-6 md:p-10 shadow-2xl relative overflow-hidden">
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-razzle-gold/50 to-transparent" />
        <div className="flex items-center justify-between mb-8 md:mb-10">
          <div className="flex flex-col">
            <span className="text-gray-500 font-bold uppercase tracking-[0.2em] text-[10px] md:text-xs mb-1">Total Amount</span>
            <span className="text-sm md:text-lg text-razzle-gold font-medium">Including all taxes</span>
          </div>
          <span className="text-3xl md:text-5xl font-brand font-bold text-white">₱{(getTotalPrice() || 0).toFixed(0)}</span>
        </div>

        <button
          onClick={onCheckout}
          className="w-full bg-razzle-gold text-razzle-dark py-6 rounded-2xl hover:bg-white transition-all duration-500 font-bold text-xs md:text-sm uppercase tracking-widest md:tracking-[0.3em] shadow-[0_20px_50px_rgba(212,196,145,0.2)] transform active:scale-[0.98]"
        >
          Proceed to Checkout
        </button>
      </div>
    </div>
  );
};

export default Cart;