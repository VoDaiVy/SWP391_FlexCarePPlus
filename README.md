# FlexCarePPlus - Pet Care Service Application

## Styling and Design Documentation

This document outlines the styling structure and key design elements of the FlexCarePPlus application.

### Color Scheme

- **Primary Color**: `#6da835` (Green)
- **Primary Hover Color**: `#5a8f2c` (Darker Green)
- **Secondary Color**: `#FFD33C` (Yellow)
- **Light Color**: `#F3F3F3` (Light Gray)
- **Dark Color**: `#212121` (Dark Gray/Black)

### CSS Structure

1. **Base Styling**: `style.css`
   - Contains the core styling for all website components
   - Defines base layout and structural styles

2. **Color Override**: `color-override.css`
   - High-priority stylesheet with `!important` rules
   - Ensures consistent color application across the site
   - Overrides any conflicting Bootstrap styles

### Key UI Elements and Their Styling

#### Navigation Bar
- Sticky navigation with smooth transition on scroll
- Contact button with hover animations and arrow bounce effect
- Menu items with underline animation on hover

#### Buttons
- All buttons have a consistent hover effect with slight elevation
- Primary buttons use the green color scheme
- Outline buttons transform to primary color on hover

#### Cards and Service Items
- Consistent shadow and hover animations
- Transform effect (lifting up) on hover
- Border color changes to primary color on hover

#### Back-to-top Button
- Fixed position in the bottom right corner
- Circular design with shadow effect
- Appears with fade-in animation when scrolling down
- Enhanced with JavaScript for better interactivity

#### Footer
- Clean design with hover effects on links
- Social media buttons with consistent styling

### Responsive Design

The website is fully responsive with special considerations for:
- Mobile navigation
- Card layouts on smaller screens
- Button sizing and positioning
- Text scaling for readability

### JavaScript Enhancements

Several JavaScript features enhance the UI:
- Sticky navbar behavior
- Modal video functionality
- Back-to-top button animations
- Dropdown menu hover effects
- Carousel configurations

### Future Maintenance Notes

When making future styling updates:
1. Check both `style.css` and `color-override.css` for relevant sections
2. Maintain the primary color scheme for consistency
3. Keep hover animations consistent across similar elements
4. Use `!important` in `color-override.css` when Bootstrap is overriding your styles
5. Test on mobile devices to ensure responsive design remains intact

---

Last updated: May 19, 2025
