/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Apple Color Palette (exact from Flutter)
        'apple-green': '#34C759',
        'apple-green-secondary': '#30D158',
        'apple-blue': '#007AFF',
        'apple-orange': '#FF9500',
        'apple-red': '#FF3B30',
        'apple-purple': '#AF52DE',
        'apple-pink': '#FF2D92',
        
        // Samsung Color Palette
        'samsung-blue': '#007AFF',
        'samsung-green': '#34C759',
        'samsung-purple': '#9C27B0',
        'samsung-orange': '#FF9800',
        
        // Background Colors
        'bg-light': '#F2F2F7',
        'bg-dark': '#000000',
        'surface-light': '#FFFFFF',
        'surface-dark': '#1C1C1E',
        'surface-secondary-light': '#F2F2F7',
        'surface-secondary-dark': '#2C2C2E',
        
        // Text Colors
        'text-primary-light': '#000000',
        'text-primary-dark': '#FFFFFF',
        'text-secondary-light': '#3C3C43',
        'text-secondary-dark': '#EBEBF5',
      },
      fontFamily: {
        'sf-pro': ['SF Pro Display', 'system-ui', 'sans-serif'],
        'sf-pro-text': ['SF Pro Text', 'system-ui', 'sans-serif'],
        'samsung-sharp': ['SamsungSharpSans', 'system-ui', 'sans-serif'],
        'samsung-one': ['SamsungOne', 'system-ui', 'sans-serif'],
      },
      spacing: {
        'xs': '4px',
        's': '8px',
        'm': '16px',
        'l': '24px',
        'xl': '32px',
        'xxl': '48px',
        'xxxl': '64px',
      },
      borderRadius: {
        'xs': '6px',
        's': '8px',
        'm': '12px',
        'l': '16px',
        'xl': '20px',
        'xxl': '24px',
      },
      boxShadow: {
        'light': '0 2px 10px rgba(0, 0, 0, 0.1)',
        'medium': '0 4px 20px rgba(0, 0, 0, 0.15)',
        'heavy': '0 8px 30px rgba(0, 0, 0, 0.2)',
        'apple-green': '0 20px 40px rgba(52, 199, 89, 0.3), 0 0 0 1px rgba(52, 199, 89, 0.3)',
        'glass': '0 8px 32px rgba(0, 0, 0, 0.1), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        'glass-heavy': '0 20px 60px rgba(0, 0, 0, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
      },
      backdropBlur: {
        'xs': '2px',
        'sm': '4px',
        'md': '8px',
        'lg': '12px',
        'xl': '16px',
        '2xl': '24px',
        '3xl': '40px',
      },
      animation: {
        'fade-in': 'fadeIn 0.6s ease-in-out',
        'slide-up': 'slideUp 0.6s ease-out',
        'slide-down': 'slideDown 0.6s ease-out',
        'scale-in': 'scaleIn 0.3s ease-out',
        'float': 'float 3s ease-in-out infinite',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        slideDown: {
          '0%': { transform: 'translateY(-20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        scaleIn: {
          '0%': { transform: 'scale(0.9)', opacity: '0' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-10px)' },
        },
      },
    },
  },
  plugins: [],
  darkMode: 'class',
}
