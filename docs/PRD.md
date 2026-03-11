# Product Requirements Document (PRD): Stylo

**Status:** Draft / Version 1.0

**Author:** FX Kennard Sugirotok

**Target Market:** Indonesia (Gen Z & Millennials)

**Core Value Proposition:** Eliminating "Expectation vs. Reality" in Indonesian fashion e-commerce through high-fidelity AI Virtual Try-On.

---

## 1. Product Overview

**Stylo** is a premium fashion e-commerce platform that integrates Generative AI to allow users to visualize how garments fit their specific body types. By bridging the gap between digital browsing and physical fitting, Stylo aims to reduce return rates and increase purchase confidence in the Indonesian market.

---

## 2. Target Audience & User Personas

- **The Trendsetter (Gen Z):** Urban dwellers in Jakarta/Bekasi who value "vibes" and social media aesthetics. They want to know if a "Modern Batik" fits their specific style.
- **The Busy Professional (Millennials):** Needs efficiency. They hate the hassle of returning items that don't fit and rely on quick, trusted payment methods (QRIS/GoPay).
- **The Modest Fashionista:** Users looking for hijab-friendly styling who need to see how layers and silhouettes interact.

---

## 3. Key Features & Functional Requirements

### 3.1 Core E-Commerce Engine

- **Product Discovery:** Infinite scroll feed, category filtering (Batik, Streetwear, Modest, etc.), and AI-powered search.
- **Localized Checkout:** \* **Payments:** Integration with Midtrans or Xendit (QRIS, GoPay, OVO, ShopeePay, Virtual Accounts).
- **Logistics:** Integration with RajaOngkir for local couriers (JNE, J&T, SiCepat, Paxel).

- **User Profiles:** Order history, saved addresses, and "Style Preferences."

### 3.2 The "Stylo AI" Suite (Hero Feature)

- **AI Virtual Try-On (VTO):**
- **Input:** User uploads a full-body photo or selects a pre-set "Body Avatar."
- **Processing:** AI overlays the selected garment onto the user's photo, maintaining fabric texture, drape, and lighting.
- **Side-by-Side Comparison:** Toggle between the professional model and the user's AI render.

- **My Fit Profile:** \* Users can save their measurements (Height, Weight, Chest, Waist, Hips).
- AI suggests the best size (S/M/L/XL) based on the brand's specific size chart.

- **Magic Mirror (AR):** (Phase 2) Real-time AR overlay using the smartphone camera for accessories and outerwear.

### 3.3 Social & Community (The "Style Feed")

- **Lookbook:** Users can post their AI Try-On results to a community feed.
- **Affiliate Integration:** Users can earn "Stylo Points" when others buy items from their Lookbook.

---

## 4. User Experience (UX) & Design

- **Theme:** Modern Minimalist Tech-Chic.
- **Design Language:** Tailwind CSS + Shadcn UI.
- **Key Interaction:** The "Stylo AI" toggle must be globally recognized across all Product Detail Pages (PDP).
- **Accessibility:** Support for Dark Mode and optimized for mid-range Android devices (high market share in Indonesia).

---

## 5. Technical Requirements

### 5.1 Tech Stack (Proposed)

- **Frontend:** Next.js (Web) / Flutter (Mobile).
- **Styling:** Tailwind CSS (Web).
- **Backend:** Node.js (Nest.js) or Python (FastAPI) for AI model orchestration.
- **AI Engine:** Stable Diffusion (ControlNet/In-Painting) or specialized VTO APIs (e.g., VTON models).
- **Database:** PostgreSQL (Supabase) for user data; Pinecone for vector-based style recommendations.

### 5.2 Performance Metrics

- **AI Render Time:** < 5 seconds for a Virtual Try-On result.
- **App Load Time:** < 2 seconds on a 4G connection.
- **Success Rate:** > 90% accuracy in garment-to-body alignment.

---

## 6. Roadmap & MVP (Minimum Viable Product)

| Phase             | Focus            | Key Deliverables                                                 |
| ----------------- | ---------------- | ---------------------------------------------------------------- |
| **Phase 1 (MVP)** | Core VTO & E-com | Basic shop, QRIS payment, Static Image AI Try-On.                |
| **Phase 2**       | Optimization     | Size recommendation engine, Paxel integration, "My Fit" profile. |
| **Phase 3**       | Social & AR      | Community Style Feed, AR accessories, Video Try-On.              |

---

## 7. Risks & Mitigations

- **Risk:** AI hallucinations (garment looks different than reality).
- **Mitigation:** Include a "Disclaimer: AI-generated image for visualization only" and high-quality 360° product videos.
- **Risk:** High server costs for AI GPU rendering.
- **Mitigation:** Implement client-side caching for common body-type renders and use a tiered processing queue.

---

**Would you like me to expand on the "Technical Architecture" section—specifically how you would handle the AI image processing flow using Next.js and a Python backend?**
