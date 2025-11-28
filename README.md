## Medicine Button App

This repository contains SwiftUI source files and build notes for a
personal iOS utility whose sole purpose is to record whether a patient
has taken their daily medicine. The UI is intentionally minimal: a
single button that can only be pressed once per day and automatically
resets at midnight.

### Feature goals

- One obvious call-to-action button (defaults to “Mark as Taken”).
- Button becomes disabled immediately after it is pressed.
- State automatically resets at midnight (local time) so the button can
  be used again.
- Persistent storage via `UserDefaults`, so killing the app does not
  clear the record.
- Optional status text showing the last time the patient confirmed
  taking their medicine.

### How it works

The app keeps a single persisted value named `lastTakenDate`. Each time the
view appears or the scene becomes active, we compare today’s date against
that stored value. If they are the same calendar day, the button stays
disabled; otherwise it is re-enabled. A lightweight, repeating timer
fires once per minute to catch the moment midnight passes while the app
is active, ensuring the UI unlocks without requiring a relaunch.

```
DailyDoseTracker.swift
└─ persists the last tap date and exposes helpers for
   determining whether the user can record a dose today.

ContentView.swift
└─ renders the single button, status text, and countdown
   logic. Subscribes to the tracker and refreshes on timers.

MedicineButtonApp.swift
└─ standard SwiftUI App entry point that injects the tracker.
```

### Putting it into a real Xcode project

1. In Xcode, create a new **App** template named `MedicineButton`.
   Use Swift and SwiftUI.
2. Replace the generated `ContentView.swift` and `App.swift` files with
   the sources from this repo.
3. Add `DailyDoseTracker.swift` to the project (any group).
4. Run on an iPhone simulator or device. The build should succeed
   without additional configuration.

### Next ideas (optional)

- Record a full history instead of only the latest date.
- Schedule a local notification at the desired dosing time.
- Add a widget or complication for even faster logging.
- Sync reminders to HealthKit or CloudKit for multi-device support.

For now, the focus remains on the single-button daily confirmation flow.

