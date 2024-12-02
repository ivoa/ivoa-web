module.exports = {
  content: [
    "./layouts/**/*.html",
    "./content/**/*.md",
    "./themes/**/layouts/**/*.html",
    "./themes/**/content/**/*.md",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#012647", // Main text and background color
        secondary: "#004d91", // Links and headers
        accent: "#92d5ff", // Footer and sitemap links
        lightGray: "#f2f2f2", // Table row background
        darkGray: "#555", // Figure caption text
        lightBackground: "#eee", // Figure caption background
        white: "#ffffff",
        black: "#000000",
      },
      fontFamily: {
        sans: ["Inter", "sans-serif"], // Default font
        arial: ["Arial", "Helvetica", "sans-serif"], // For table fallback
      },
      fontSize: {
        base: "1rem",
        lg: "1.3rem", // Large text (e.g., header nav links)
        xl: "2rem", // H1 font size in articles
        "2xl": "2.3rem", // Carousel titles
      },
      spacing: {
        1: "0.25rem", // Small padding
        2: "0.5rem", // Small margin
        4: "1rem", // Medium spacing
        8: "2rem", // Large spacing
        16: "4rem", // Extra-large spacing
      },
      maxWidth: {
        content: "80em", // Article max-width
        table: "100%", // Full-width tables
        image: "100%", // Responsive images
      },
      lineHeight: {
        base: "1.5",
        header: "5em", // Header line height
      },
      gridTemplateColumns: {
        asideMainAside: "1fr auto 1fr", // Grid layout with two asides
        mainAside: "1fr auto", // Grid layout with one aside
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
    },
  },
  plugins: [],
};

