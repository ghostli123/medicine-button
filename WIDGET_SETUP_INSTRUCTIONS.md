# Widget Setup Instructions

## Step 1: Add Widget Extension in Xcode

1. In Xcode, select your project in the navigator
2. Click the **"+"** button at the bottom of the target list (or File → New → Target)
3. Select **"Widget Extension"**
4. Click **"Next"**
5. Configure:
   - **Product Name**: `MedicineWidget`
   - **Organization Identifier**: (same as your app)
   - **Language**: Swift
   - **Include Configuration Intent**: ❌ Uncheck (we don't need this)
6. Click **"Finish"**
7. When prompted, click **"Activate"** for the scheme

## Step 2: Add Widget Files

1. In the new `MedicineWidget` folder that Xcode created, **delete** the default files:
   - Delete `MedicineWidget.swift` (the default one)
   - Delete `MedicineWidgetBundle.swift` (the default one)

2. **Add the new widget files:**
   - Right-click the `MedicineWidget` folder
   - Select **"Add Files to 'TakingMedicine'..."**
   - Navigate to `TakingMedicine/Widget/` folder
   - Select:
     - `MedicineWidget.swift`
     - `MedicineWidgetBundle.swift`
   - Make sure **"Copy items if needed"** is checked
   - Make sure **"MedicineWidget"** target is checked
   - Click **"Add"**

## Step 3: Share Code Between App and Widget

The widget needs access to `DailyDoseTracker`. You have two options:

### Option A: Add DailyDoseTracker to Widget Target (Recommended)

1. Select `DailyDoseTracker.swift` in the Project Navigator
2. Open the **File Inspector** (right sidebar, first tab)
3. Under **Target Membership**, check **"MedicineWidget"**
4. This allows the widget to use the same tracker class

### Option B: Create Shared Framework (More Complex)

If Option A doesn't work, you may need to create a shared framework, but Option A should work fine.

## Step 4: Update Widget Info.plist

1. In the `MedicineWidget` folder, find `Info.plist`
2. Make sure it has:
   - `NSExtension` → `NSExtensionPointIdentifier`: `com.apple.widgetkit-extension`

## Step 5: Build and Test

1. Select **"MedicineWidget"** scheme from the scheme selector
2. Build (Cmd+B) to check for errors
3. Run on simulator or device
4. Long-press on home screen → Tap **"+"** → Find "Medicine Tracker" → Add widget

## Step 6: Test Widget

1. Add the widget to your home screen
2. Verify it shows:
   - Today's status (Taken/Not Taken)
   - Current streak
   - Total doses (in medium size)
3. Test that it updates when you mark medicine as taken

## Troubleshooting

### Widget doesn't show data
- Make sure `DailyDoseTracker.swift` is added to the widget target
- Check that UserDefaults keys match between app and widget
- Verify widget has permission to access data

### Build errors
- Make sure all files are added to the widget target
- Check that `MedicineWidgetBundle.swift` has `@main` attribute
- Verify widget extension is properly configured

### Widget doesn't update
- Widgets update on a schedule (hourly by default)
- You can force refresh by removing and re-adding the widget
- Check timeline provider is returning correct entries

## Notes

- Widgets have limited functionality (no user interaction in iOS 14+)
- Widgets update on a schedule, not in real-time
- The widget shows read-only information
- For iOS 17+, you can add interactive buttons using App Intents

## Next Steps

Once the widget is working:
1. Test thoroughly
2. Update app description to mention widget
3. Take screenshots showing the widget
4. Resubmit to App Store

Good luck! 🚀

