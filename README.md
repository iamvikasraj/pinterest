

https://github.com/user-attachments/assets/32775551-b357-47a9-8fc1-c06b294e8879

# Pinterest iOS App

A Pinterest-style iOS app built with SwiftUI using MVVM architecture.

## Why This Project

Most design work stops at mockups. This project is a deliberate counter-example: a Pinterest-style app built as a **native SwiftUI prototype that behaves like a real product** — real physics, real haptics, and real motion (via Rive) — so ideas can be validated before any production code is written.

It reflects a way of working where the line between prototype and production has blurred: not just prototyping in code, but shipping it. Native gestures, animated pin-to-detail transitions, a Rive-powered splash, and a centralized design system stand in for the philosophy behind it — faster ships, fewer surprises at handoff.

## Who It's For

This project is built to be useful from both sides of the design–engineering line.

**For designers**
- Feel a real Pinterest-style app — masonry scroll, pin-to-detail transitions, bottom sheets, and a Rive-powered splash — running natively instead of as a flat mockup.
- Use it as a live reference for motion, haptics, and spacing driven by a shared design system, so you can judge how timing and easing actually land on a device.
- Open it in Xcode, press run, and interact with real gestures and physics — no prototyping tool in between.

**For developers**
- A clean, readable SwiftUI + MVVM codebase to learn from or fork, with screens, view models, models, and reusable components cleanly separated.
- Practical patterns worth borrowing: type-safe navigation, shared element transitions between a card and its detail sheet, and Rive integration for the launch animation.
- Open `pinterest.xcodeproj` in Xcode and run on a simulator or device — no extra setup or dependencies to configure.

## Key Features

- **MVVM Architecture** — Clean separation of concerns
- **Masonry Layout** — Pinterest-style grid with randomized aspect ratios
- **Rive Splash Animation** — Animated launch screen using Rive
- **Bottom Sheet Navigation** — Smooth sheet transitions
- **Design System** — Centralized typography & spacing (4pt grid)
- **Type-Safe Navigation** — Route enum for navigation
- **Animated Transitions** — Pin card to detail sheet, animated tab underlines
- **Profile Paging** — TabView paging with search/filter bars and tags
- **Create Overlay** — Slide-up create sheet as an overlay

## About the Author

Built by **Vikas Raj Yadav**, a mobile-first design technologist with a computer science background and 10+ years in Indian fintech (Paytm, HDFC Bank, ET Money), currently Staff Product Designer at Loop Health — where he scaled Paytm Postpaid to 1M+ users in six months and led design systems and UX across heavily regulated fintech products.

Self-taught in product design since 2016, he's run through nearly every prototype-test loop there is (Sketch, Principle, Flinto, Framer X, Figma, After Effects, production code), and since 2021–22 has been building native iOS in real SwiftUI. Motion is second nature, but it's one lever inside a full product design practice — not the whole job.

He's also a Rive Ambassador and is building [designengineer.ing](https://designengineer.ing), a home for designers who code.
