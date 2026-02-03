import React from 'react';

const Hero: React.FC = () => {
  return (
    <section className="relative overflow-hidden bg-razzle-dark py-12 md:py-24 px-4 border-b border-white/5">
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_120%,rgba(212,196,145,0.1),transparent_50%)]" />
      <div className="max-w-4xl mx-auto text-center relative z-10">
        <h1 className="text-4xl md:text-7xl font-brand font-bold text-white mb-6 md:mb-8 animate-fade-in flex flex-col items-center">
          <span className="text-razzle-gold text-[8px] md:text-sm tracking-[0.8em] uppercase mb-2 md:mb-4 opacity-70">Experience the</span>
          <span className="logo-tracking text-3xl md:text-7xl">RAZZLE BREW</span>
          <span className="h-0.5 md:h-1 w-16 md:w-24 bg-razzle-gold mt-4 md:mt-6 rounded-full" />
        </h1>
        <p className="text-base md:text-xl text-gray-400 mb-8 md:mb-12 max-w-2xl mx-auto animate-slide-up font-medium tracking-wide">
          Elevating your daily coffee ritual with premium roasts and artisanal craftsmanship.
        </p>
        <div className="flex justify-center items-center gap-6">
          <a
            href="#menu"
            className="group relative px-10 py-4 bg-razzle-gold text-razzle-dark rounded-full transition-all duration-300 transform hover:scale-105 font-bold tracking-widest text-sm overflow-hidden"
          >
            <span className="relative z-10">BROWSE MENU</span>
            <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-20 transition-opacity" />
          </a>
          <a
            href="#about"
            className="px-10 py-4 border border-razzle-gold/30 text-razzle-gold rounded-full hover:bg-razzle-gold/10 transition-all duration-300 font-bold tracking-widest text-sm"
          >
            OUR STORY
          </a>
        </div>
      </div>
    </section>
  );
};

export default Hero;