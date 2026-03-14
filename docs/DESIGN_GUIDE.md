# Stylo Design Specifications Form

## Part 1: Brand Identity & Vibe

- **App Name:** Stylo
- **Target Market:** Indonesia (Gen Z & Millennials)
- **Brand Personality:** [ ] Highly Premium [ ] Affordable [X] Modern Tech-Chic
- **Core Value Proposition:** Increase confidence through AI Virtual Try-On.
- **Tone of Voice:** (e.g., Conversational, Friendly, Professional): Conversational, Enthusiastic, Trusted.

## Part 2: Visual Style & Themes

- **Primary Design Aesthetic:** [ ] Maximalist [ ] Traditional [X] Modern Minimalist (ASOS/Zara feel)
- **UI Elements Style:** [ ] Flat [X] Clean/Rounded (Shadcn style) [X] Subtle Glassmorphism (For AI features)
- **Whitespace Approach:** [ ] Dense [X] Airy (High negative space)

## Part 3: Color Palette (Hex Codes)

| Role                    | Color Name      | Hex Code  | Dark Mode Alternative (Optional) | Check to Confrm |
| ----------------------- | --------------- | --------- | -------------------------------- | --------------- |
| **Primary (AI/Tech)**   | Electric Violet | `#6366F1` | `N/A (Keep for consistency)`     | [ ]             |
| **Secondary (Accent)**  | Charcoal Black  | `#1A1A1B` | `#F9FAFB`                        | [ ]             |
| **App Background**      | Pure White      | `#FFFFFF` | `#1A1A1B` (For true dark mode)   | [ ]             |
| **Success/Trust**       | Emerald Green   | `#10B981` | `#10B981`                        | [ ]             |
| **Text (Body)**         | Slate Gray      | `#475569` | `#F1F5F9`                        | [ ]             |
| **Text (Labels/Small)** | Light Gray      | `#94A3B8` | `#94A3B8`                        | [ ]             |

## Part 4: Typography

This is a strict font pairing strategy.

#### Part 4a: Headings (Fashion & Editorial Vibe)

- **Font Family:** **Playfair Display** (or similar sophisticated Serif)
- **License Check:** (e.g., Open Source/Paid): Open Source (Google Fonts)
- **Weight Usage:** Bold (700) or Semi-Bold (600) only.

#### Part 4b: Body & UI (Tech-Chic & Readability)

- **Font Family (Recommended):** **Inter** (Sans-Serif)
- **License Check:** Open Source (Google Fonts)
- **Variable Font Supported?** [X] Yes [ ] No (Variable font is preferred for performance).
- **Justification:** High legibility at small sizes, professional "tech" feel, complements the serif heading.

#### Part 4c: Type Scale (Mobile)

| Level                  | Size (px) | Weight    | Font Family      | Usage                           | Check |
| ---------------------- | --------- | --------- | ---------------- | ------------------------------- | ----- |
| **H1**                 | 28px      | Bold      | Playfair Display | Product Title, Brand Title      | [ ]   |
| **H2**                 | 22px      | Semi-Bold | Playfair Display | Section Header                  | [ ]   |
| **H3**                 | 18px      | Medium    | Inter            | Card Title, Highlighting info   | [ ]   |
| **Body (Main)**        | 14px      | Regular   | **Inter**        | Descriptions, Reviews           | [X]   |
| **Interface (Labels)** | 12px      | Medium    | **Inter**        | Button text, Sizes, Cart labels | [X]   |
| **Price**              | 18px      | Bold      | Inter            | Rupiah price display            | [X]   |

## Part 5: UI/UX Component Specifications

- **Default Corner Radius (e.g., Buttons, Inputs):** 8px (`rounded-md` in Tailwind)
- **Large Corner Radius (e.g., Cards, Panels):** 12px (`rounded-lg`)
- **Transitions (ease/duration):** Subtle (`duration-200 ease-in-out`)
- **Haptic Feedback Enabled?** [X] Yes [ ] No (Crucial for the "try on processed" moment)
- **Localizations Required:** [X] Rupiah (Rp) [X] Indonesian Size Charts (Standard Indo sizes) [X] Local Payment Icons (QRIS, GoPay)
