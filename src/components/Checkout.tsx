import React, { useState } from 'react';
import { ArrowLeft, Utensils, Store, Truck, CreditCard, Camera } from 'lucide-react';
import { CartItem, PaymentMethod, ServiceType } from '../types';
import { usePaymentMethods } from '../hooks/usePaymentMethods';

interface CheckoutProps {
  cartItems: CartItem[];
  totalPrice: number;
  onBack: () => void;
}

const Checkout: React.FC<CheckoutProps> = ({ cartItems, totalPrice, onBack }) => {
  const { paymentMethods } = usePaymentMethods();
  const [step, setStep] = useState<'details' | 'payment'>('details');
  const [customerName, setCustomerName] = useState('');
  const [contactNumber, setContactNumber] = useState('');
  const [serviceType, setServiceType] = useState<ServiceType>('dine-in');
  const [address, setAddress] = useState('');
  const [landmark, setLandmark] = useState('');
  const [pickupTime, setPickupTime] = useState('5-10');
  const [customTime, setCustomTime] = useState('');
  const [partySize, setPartySize] = useState(1);
  const [dineInTime, setDineInTime] = useState('');
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('gcash');
  const [notes, setNotes] = useState('');

  React.useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [step]);

  React.useEffect(() => {
    if (paymentMethods.length > 0 && !paymentMethod) {
      setPaymentMethod(paymentMethods[0].id as PaymentMethod);
    }
  }, [paymentMethods, paymentMethod]);

  const selectedPaymentMethod = paymentMethods.find(method => method.id === paymentMethod);

  const handleProceedToPayment = () => {
    setStep('payment');
  };

  const handlePlaceOrder = () => {
    const timeInfo = serviceType === 'pickup'
      ? (pickupTime === 'custom' ? customTime : `${pickupTime} minutes`)
      : '';

    const dineInInfo = serviceType === 'dine-in'
      ? `Party Size: ${partySize} pax\nPreferred Time: ${new Date(dineInTime).toLocaleString('en-US', {
        weekday: 'long',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      })}`
      : '';

    const orderDetails = `
RAZZLE BREW ORDER

CUSTOMER: ${customerName}
CONTACT: ${contactNumber}
SERVICE: ${serviceType.toUpperCase()}
${serviceType === 'delivery' ? `ADDRESS: ${address}${landmark ? `\nLANDMARK: ${landmark}` : ''}` : ''}
${serviceType === 'pickup' ? `PICKUP: ${timeInfo}` : ''}
${serviceType === 'dine-in' ? dineInInfo : ''}

ORDER SELECTION:
${cartItems.map(item => {
      let itemDetails = `- ${item.name.toUpperCase()}`;
      if (item.selectedVariation) {
        itemDetails += ` [${item.selectedVariation.name}]`;
      }
      if (item.selectedAddOns && item.selectedAddOns.length > 0) {
        itemDetails += ` + ${item.selectedAddOns.map(addOn =>
          addOn.quantity && addOn.quantity > 1
            ? `${addOn.name} x${addOn.quantity}`
            : addOn.name
        ).join(', ')}`;
      }
      itemDetails += ` x${item.quantity} - ₱${(item.totalPrice * item.quantity).toFixed(0)}`;
      return itemDetails;
    }).join('\n')}

TOTAL: ₱${totalPrice.toFixed(0)}

PAYMENT: ${selectedPaymentMethod?.name || paymentMethod}
Note: After sending this, please attach a screenshot of your payment receipt.

${notes ? `NOTES: ${notes}` : ''}

Thank you for choosing Razzle Brew! We're preparing your caffeine fix.
    `.trim();

    const encodedMessage = encodeURIComponent(orderDetails);
    const messengerUrl = `https://m.me/100086339664033?text=${encodedMessage}`;

    window.open(messengerUrl, '_blank');
  };

  const isDetailsValid = customerName && contactNumber &&
    (serviceType !== 'delivery' || address) &&
    (serviceType !== 'pickup' || (pickupTime !== 'custom' || customTime)) &&
    (serviceType !== 'dine-in' || (partySize > 0 && dineInTime));

  if (step === 'details') {
    return (
      <div className="max-w-7xl mx-auto px-4 py-12 animate-fade-in">
        <div className="flex items-center mb-12">
          <button
            onClick={onBack}
            className="flex items-center space-x-3 text-gray-500 hover:text-razzle-gold transition-all duration-300 group"
          >
            <div className="p-2.5 rounded-xl bg-white/5 group-hover:bg-razzle-gold/10 transition-colors">
              <ArrowLeft className="h-5 w-5" />
            </div>
            <span className="font-bold text-xs tracking-widest uppercase">Cart</span>
          </button>
          <h1 className="text-3xl font-brand font-bold text-white ml-8 tracking-[0.2em] uppercase">Checkout</h1>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
          {/* Form */}
          <div className="lg:col-span-7 space-y-8">
            <div className="glass-panel border-white/5 rounded-3xl p-8 shadow-2xl">
              <h2 className="text-sm font-bold text-razzle-gold mb-8 tracking-[0.3em] uppercase opacity-60">Personal Details</h2>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-10">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Full Name</label>
                  <input
                    type="text"
                    value={customerName}
                    onChange={(e) => setCustomerName(e.target.value)}
                    className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium"
                    placeholder="Enter full name"
                  />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Contact Number</label>
                  <input
                    type="tel"
                    value={contactNumber}
                    onChange={(e) => setContactNumber(e.target.value)}
                    className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium"
                    placeholder="09XX XXX XXXX"
                  />
                </div>
              </div>

              <h2 className="text-sm font-bold text-razzle-gold mb-6 tracking-[0.3em] uppercase opacity-60">Service Option</h2>
              <div className="grid grid-cols-3 gap-4 mb-10">
                {[
                  { value: 'dine-in', label: 'Dine In', icon: <Utensils className="h-6 w-6" /> },
                  { value: 'pickup', label: 'Pickup', icon: <Store className="h-6 w-6" /> },
                  { value: 'delivery', label: 'Delivery', icon: <Truck className="h-6 w-6" /> }
                ].map((option) => (
                  <button
                    key={option.value}
                    type="button"
                    onClick={() => setServiceType(option.value as ServiceType)}
                    className={`flex flex-col items-center justify-center p-3 md:p-6 rounded-2xl border transition-all duration-300 ${serviceType === option.value
                      ? 'border-razzle-gold bg-razzle-gold/10 text-razzle-gold shadow-lg shadow-razzle-gold/5'
                      : 'border-white/5 bg-white/[0.02] text-gray-500 hover:border-white/20'
                      }`}
                  >
                    <div className="mb-2 md:mb-3">{option.icon}</div>
                    <span className="text-[10px] font-bold tracking-widest uppercase text-center">{option.label}</span>
                  </button>
                ))}
              </div>

              {/* Dynamic Inputs */}
              <div className="space-y-6">
                {serviceType === 'dine-in' && (
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Party Size</label>
                      <div className="flex items-center space-x-4 bg-white/5 rounded-2xl p-2 border border-white/10">
                        <button
                          type="button"
                          onClick={() => setPartySize(Math.max(1, partySize - 1))}
                          className="w-12 h-12 rounded-xl bg-white/5 hover:bg-white/10 flex items-center justify-center text-razzle-gold transition-all"
                        >
                          -
                        </button>
                        <span className="flex-1 text-center text-xl font-bold text-white">{partySize} pax</span>
                        <button
                          type="button"
                          onClick={() => setPartySize(Math.min(20, partySize + 1))}
                          className="w-12 h-12 rounded-xl bg-white/5 hover:bg-white/10 flex items-center justify-center text-razzle-gold transition-all"
                        >
                          +
                        </button>
                      </div>
                    </div>
                    <div className="space-y-2">
                      <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Arrival Time</label>
                      <input
                        type="datetime-local"
                        value={dineInTime}
                        onChange={(e) => setDineInTime(e.target.value)}
                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium h-[60px]"
                      />
                    </div>
                  </div>
                )}

                {serviceType === 'pickup' && (
                  <div className="space-y-6">
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                      {['5-10', '15-20', '25-30', 'custom'].map((val) => (
                        <button
                          key={val}
                          type="button"
                          onClick={() => setPickupTime(val)}
                          className={`p-4 rounded-xl border text-[10px] font-bold tracking-widest uppercase transition-all duration-300 ${pickupTime === val
                            ? 'border-razzle-gold bg-razzle-gold/10 text-razzle-gold'
                            : 'border-white/5 bg-white/[0.02] text-gray-500'
                            }`}
                        >
                          {val === 'custom' ? 'Custom' : `${val} MIN`}
                        </button>
                      ))}
                    </div>
                    {pickupTime === 'custom' && (
                      <input
                        type="text"
                        value={customTime}
                        onChange={(e) => setCustomTime(e.target.value)}
                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium"
                        placeholder="e.g., 2:30 PM"
                      />
                    )}
                  </div>
                )}

                {serviceType === 'delivery' && (
                  <div className="space-y-4">
                    <div className="space-y-2">
                      <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Complete Address</label>
                      <textarea
                        value={address}
                        onChange={(e) => setAddress(e.target.value)}
                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium h-32 resize-none"
                        placeholder="House No., Street, Brgy., City"
                      />
                    </div>
                    <div className="space-y-2">
                      <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Landmark</label>
                      <input
                        type="text"
                        value={landmark}
                        onChange={(e) => setLandmark(e.target.value)}
                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium"
                        placeholder="e.g., Near Church, Blue Gate"
                      />
                    </div>
                  </div>
                )}

                <div className="space-y-2 pt-4">
                  <label className="text-[10px] font-bold text-gray-500 uppercase tracking-widest ml-1">Special Instructions</label>
                  <textarea
                    value={notes}
                    onChange={(e) => setNotes(e.target.value)}
                    className="w-full bg-white/5 border border-white/10 rounded-2xl px-5 py-4 text-white focus:outline-none focus:border-razzle-gold/50 transition-all font-medium h-24 resize-none"
                    placeholder="Anything else we should know?"
                  />
                </div>
              </div>
            </div>
          </div>

          {/* Sidebar */}
          <div className="lg:col-span-5 space-y-8">
            <div className="glass-panel border-white/10 border-t-2 border-t-razzle-gold rounded-3xl p-8 shadow-2xl">
              <h2 className="text-sm font-bold text-white mb-8 tracking-[0.3em] uppercase">Order Selection</h2>

              <div className="space-y-6 mb-10 max-h-[400px] overflow-y-auto pr-2 scrollbar-hide">
                {cartItems.map((item) => (
                  <div key={item.id} className="flex justify-between items-start group">
                    <div className="space-y-1">
                      <h4 className="font-bold text-white text-sm tracking-wide uppercase group-hover:text-razzle-gold transition-colors">{item.name}</h4>
                      <div className="flex flex-wrap gap-2">
                        {item.selectedVariation && (
                          <span className="text-[9px] font-bold text-gray-500 uppercase tracking-widest">{item.selectedVariation.name}</span>
                        )}
                        <span className="text-[9px] font-bold text-razzle-gold uppercase tracking-widest">x{item.quantity}</span>
                      </div>
                    </div>
                    <span className="font-brand font-bold text-white">₱{(item.totalPrice * item.quantity).toFixed(0)}</span>
                  </div>
                ))}
              </div>

              <div className="space-y-4 pt-6 border-t border-white/5">
                <div className="flex justify-between items-center">
                  <span className="text-[10px] font-bold text-gray-500 uppercase tracking-widest">Estimated Subtotal</span>
                  <span className="font-bold text-white">₱{totalPrice.toFixed(0)}</span>
                </div>
                <div className="flex justify-between items-center text-2xl">
                  <span className="font-brand font-bold text-white tracking-widest uppercase text-sm">Amount Due</span>
                  <span className="font-brand font-bold text-razzle-gold">₱{totalPrice.toFixed(0)}</span>
                </div>
              </div>

              <button
                onClick={handleProceedToPayment}
                disabled={!isDetailsValid}
                className={`w-full mt-10 py-5 rounded-2xl font-bold text-sm tracking-[0.3em] transition-all duration-500 transform active:scale-[0.98] uppercase shadow-2xl ${isDetailsValid
                  ? 'bg-razzle-gold text-razzle-dark hover:bg-white shadow-razzle-gold/10'
                  : 'bg-white/5 text-gray-600 cursor-not-allowed border border-white/5'
                  }`}
              >
                Continue to Payment
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-12 animate-fade-in">
      <div className="flex items-center mb-12">
        <button
          onClick={() => setStep('details')}
          className="flex items-center space-x-3 text-gray-500 hover:text-razzle-gold transition-all duration-300 group"
        >
          <div className="p-2.5 rounded-xl bg-white/5 group-hover:bg-razzle-gold/10 transition-colors">
            <ArrowLeft className="h-5 w-5" />
          </div>
          <span className="font-bold text-xs tracking-widest uppercase">Details</span>
        </button>
        <h1 className="text-3xl font-brand font-bold text-white ml-8 tracking-[0.2em] uppercase">Payment</h1>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
        <div className="lg:col-span-12">
          <div className="glass-panel border-white/5 rounded-3xl p-10 shadow-2xl">
            <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
              <div className="lg:col-span-5 space-y-8">
                <h2 className="text-sm font-bold text-razzle-gold tracking-[0.3em] uppercase opacity-60 mb-6">Payment Instruction</h2>
                <div className="space-y-4">
                  {paymentMethods.map((method) => (
                    <button
                      key={method.id}
                      onClick={() => setPaymentMethod(method.id as PaymentMethod)}
                      className={`w-full flex items-center justify-between p-6 rounded-2xl border transition-all duration-300 ${paymentMethod === method.id
                        ? 'border-razzle-gold bg-razzle-gold/10'
                        : 'border-white/5 bg-white/[0.02] hover:border-white/10'
                        }`}
                    >
                      <div className="flex items-center space-x-4">
                        <div className={`p-3 rounded-xl bg-white/5 ${paymentMethod === method.id ? 'text-razzle-gold' : 'text-gray-500'}`}>
                          <CreditCard className="h-5 w-5" />
                        </div>
                        <span className={`text-sm font-bold uppercase tracking-widest ${paymentMethod === method.id ? 'text-white' : 'text-gray-500'}`}>
                          {method.name}
                        </span>
                      </div>
                      {paymentMethod === method.id && (
                        <div className="w-2 h-2 rounded-full bg-razzle-gold shadow-[0_0_10px_rgba(212,196,145,0.5)]" />
                      )}
                    </button>
                  ))}
                </div>

                <div className="bg-white/5 border border-white/10 rounded-2xl p-6 space-y-4 mt-8">
                  <div className="flex items-center space-x-3 text-amber-500">
                    <Camera className="h-5 w-5" />
                    <span className="text-[10px] font-bold tracking-widest uppercase">Important Notice</span>
                  </div>
                  <p className="text-xs text-gray-500 leading-relaxed font-medium">
                    Order confirmation happens in Messenger. Please capture a screenshot of your successful transaction to attach to your message.
                  </p>
                </div>
              </div>

              <div className="lg:col-span-7">
                {selectedPaymentMethod && (
                  <div className="glass-panel bg-white/[0.02] border-white/5 rounded-3xl p-8 h-full flex flex-col items-center justify-center text-center">
                    <div className="relative group mb-8">
                      <div className="absolute -inset-4 bg-razzle-gold/10 rounded-[40px] blur-2xl opacity-0 group-hover:opacity-100 transition-opacity" />
                      <div className="relative p-4 bg-white rounded-3xl overflow-hidden shadow-2xl">
                        <img
                          src={selectedPaymentMethod.qr_code_url}
                          alt="Payment QR"
                          className="w-48 h-48 md:w-64 md:h-64 object-contain"
                          onError={(e) => {
                            e.currentTarget.src = 'https://images.pexels.com/photos/8867482/pexels-photo-8867482.jpeg?auto=compress&cs=tinysrgb&w=300&h=300&fit=crop';
                          }}
                        />
                      </div>
                      <div className="mt-6 space-y-1">
                        <p className="text-xs font-bold text-gray-500 uppercase tracking-[0.2em]">Scan to Pay</p>
                        <p className="text-2xl font-brand font-bold text-razzle-gold tracking-widest uppercase">{selectedPaymentMethod.name}</p>
                      </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 w-full max-w-md">
                      <div className="p-4 bg-white/5 border border-white/5 rounded-xl">
                        <p className="text-[9px] font-bold text-gray-500 uppercase tracking-widest mb-1">Account Name</p>
                        <p className="text-xs font-bold text-white truncate">{selectedPaymentMethod.account_name}</p>
                      </div>
                      <div className="p-4 bg-white/5 border border-white/5 rounded-xl">
                        <p className="text-[9px] font-bold text-gray-500 uppercase tracking-widest mb-1">Account Number</p>
                        <p className="text-xs font-bold text-white font-mono">{selectedPaymentMethod.account_number}</p>
                      </div>
                    </div>

                    <div className="mt-12 w-full max-w-sm space-y-6">
                      <div className="flex justify-between items-center px-4">
                        <span className="text-[10px] font-bold text-gray-500 uppercase tracking-widest">Amount Due</span>
                        <span className="text-4xl font-brand font-bold text-white">₱{totalPrice.toFixed(0)}</span>
                      </div>
                      <button
                        onClick={handlePlaceOrder}
                        className="w-full bg-razzle-gold text-razzle-dark py-6 rounded-2xl hover:bg-white transition-all duration-500 font-bold text-[10px] md:text-sm tracking-widest md:tracking-[0.3em] uppercase shadow-2xl shadow-razzle-gold/20 transform hover:-translate-y-1"
                      >
                        Send Receipt via Messenger
                      </button>
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Checkout;