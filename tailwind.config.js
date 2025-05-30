/** tailwind.config.js **/

module.exports = {
  content: [
    "./layouts/**/*.html",
    "./content/**/*.md",
    "./themes/**/layouts/**/*.html",
    "./themes/**/content/**/*.md"
  ],
  theme: {
    colors: {
      primary: "#012647",
      secondary: "#004d91",
      accent: "#92d5ff",
      'accent-hover': "#b3e4ff",
      'light-gray': "#f2f2f2",
      'soft-gray': "#bbb",
      'medium-gray': "#777",
      'dark-gray': "#555",
      'light-bg': "#eee",
      'sky-blue': '#5dbbf5',
      'forest-green': '#399110',
      'brick-red': '#aa3f3f',
      white: "#ffffff",
      black: "#000000",
    },
    extend: {
      fontFamily: {
        sans: ["Inter", "sans-serif"],
        arial: ["Arial", "Helvetica", "sans-serif"],
      },
      fontSize: {
        base: "1rem",
        lg: "1.3rem",
        xl: "2rem",
        "2xl": "2.3rem",
      },
      spacing: {
        1: "0.25rem",
        2: "0.5rem",
        4: "1rem",
        8: "2rem",
        16: "4rem",
      },
      maxWidth: {
        content: "80em",
        table: "100%",
        image: "100%",
      },
      lineHeight: {
        base: "1.5",
        header: "5em",
      },
      gridTemplateColumns: {
        asideMainAside: "1fr auto 1fr",
        mainAside: "1fr auto",
      },
      gridTemplateAreas: {
        full: [
          "header header header",
          "left-aside main right-aside",
          "footer footer footer",
        ],
        rightAside: ["header header", "main right-aside", "footer footer"],
        leftAside: ["header header", "left-aside main", "footer footer"],
      },

      /**
       * Custom table styles for Tailwind Typography
       * so that Markdown tables in .prose have row hovers, etc.
       */
      typography: (theme) => ({
        DEFAULT: {
          css: {
            '--tw-prose-body': theme('colors.black'),
            thead: {
              backgroundColor: theme("colors.light-gray"),
            },
            "thead th": {
              "@apply font-semibold border-b border-soft-gray px-4 py-2": {},
            },
            "tbody tr": {
              // Give rows a subtle bottom border
              borderBottomWidth: "1px",
              borderColor: theme("colors.soft-gray"),
            },
            "tbody td": {
              "@apply px-4 py-2": {},
            },
            "tbody tr:hover": {
              backgroundColor: theme("colors.light-bg"),
            },
          },
        },
      }),
    },
  },
  plugins: [
    require("@tailwindcss/typography"),
  ],
};
