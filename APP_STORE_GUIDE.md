# App Store Submission Guide

This guide walks you through publishing your Medicine Button app to the Apple App Store.

## Prerequisites

1. **Apple Developer Account** ($99/year)
   - Sign up at [developer.apple.com](https://developer.apple.com)
   - Enroll in the Apple Developer Program
   - Wait for approval (usually 24-48 hours)

2. **Xcode Project Setup**
   - Ensure your app is in a proper Xcode project (`.xcodeproj`)
   - All source files are added to the project

## Step 1: Configure Your Xcode Project

### 1.1 Set Bundle Identifier
1. Open your project in Xcode
2. Select your project in the navigator
3. Select the **target** (your app)
4. Go to **General** tab
5. Set **Bundle Identifier** to something unique, e.g.:
   - `com.yourname.medicinebutton`
   - `com.yourname.takingmedicine`
   - Must be unique and match your App Store Connect app

### 1.2 Configure Signing & Capabilities
1. Still in the **General** tab
2. Under **Signing & Capabilities**:
   - Check **"Automatically manage signing"**
   - Select your **Team** (your Apple Developer account)
   - Xcode will automatically create provisioning profiles

### 1.3 Set Version and Build Numbers
1. In the **General** tab:
   - **Version**: `1.0.0` (this is what users see)
   - **Build**: `1` (increment this for each upload)
   - Or use **Marketing Version** and **Current Project Version**

### 1.4 Set Deployment Target
- Minimum iOS version (recommended: iOS 15.0 or later for broader compatibility)
- Go to **General** → **Deployment Info** → **iOS Deployment Target**

### 1.5 App Icon
- Ensure all icon sizes are filled in `Assets.xcassets/AppIcon`
- At minimum, you need the 1024×1024 icon for App Store

## Step 2: Prepare App Information

Before submitting, gather:

- **App Name**: (e.g., "Medicine Tracker" or "Daily Dose")
- **Subtitle**: Short description (30 characters)
- **Description**: Full description (up to 4000 characters)
- **Keywords**: Search keywords (up to 100 characters, comma-separated)
- **Support URL**: Your website or support page
- **Privacy Policy URL**: Required for all apps
- **Category**: Health & Fitness or Medical
- **Screenshots**: Required for each device size you support
  - iPhone 6.7" (iPhone 14 Pro Max, 15 Pro Max): 1290×2796
  - iPhone 6.5" (iPhone 11 Pro Max, XS Max): 1242×2688
  - iPhone 5.5" (iPhone 8 Plus): 1242×2208
  - At least 3 screenshots required

## Step 3: Create App in App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Sign in with your Apple Developer account
3. Click **"My Apps"** → **"+"** → **"New App"**
4. Fill in:
   - **Platform**: iOS
   - **Name**: Your app name
   - **Primary Language**: English (or your choice)
   - **Bundle ID**: Select the one matching your Xcode project
   - **SKU**: Unique identifier (e.g., `medicine-button-001`)
   - **User Access**: Full Access (unless using App Store Connect API)

## Step 4: Archive and Upload Your App

### 4.1 Clean and Archive
1. In Xcode, select **"Any iOS Device"** or **"Generic iOS Device"** from the scheme selector
2. Go to **Product** → **Clean Build Folder** (Shift+Cmd+K)
3. Go to **Product** → **Archive**
4. Wait for the archive to complete

### 4.2 Validate Archive
1. The **Organizer** window will open automatically
2. Select your archive
3. Click **"Validate App"**
4. Fix any issues that appear
5. Common issues:
   - Missing app icon
   - Missing privacy policy URL
   - Code signing errors

### 4.3 Distribute to App Store
1. In the Organizer, select your archive
2. Click **"Distribute App"**
3. Select **"App Store Connect"**
4. Choose **"Upload"**
5. Follow the wizard:
   - Select distribution options (usually default)
   - Review app information
   - Upload

### 4.4 Wait for Processing
- Apple processes your upload (usually 10-30 minutes)
- You'll receive an email when processing is complete
- Check App Store Connect → **TestFlight** or **App Store** tab

## Step 5: Complete App Store Listing

1. In App Store Connect, go to your app
2. Fill in all required information:

### App Information
- **Name**: Your app name
- **Subtitle**: Short tagline
- **Category**: Primary and secondary categories
- **Content Rights**: Confirm you have rights to all content

### Pricing and Availability
- Set price (Free or paid)
- Select countries/regions

### App Privacy
- Complete privacy questionnaire
- Provide Privacy Policy URL (required)

### Version Information
- **What's New**: Release notes for version 1.0
- **Description**: Full app description
- **Keywords**: Search keywords
- **Support URL**: Your support page
- **Marketing URL**: (Optional) Your website
- **Promotional Text**: (Optional) Appears above description

### App Review Information
- **Contact Information**: Your contact details
- **Demo Account**: (If needed) Test account credentials
- **Notes**: Any additional info for reviewers

### Screenshots
- Upload screenshots for each required device size
- At least 3 screenshots per device size
- Use actual app screenshots (not mockups)

### App Preview (Optional)
- Video preview of your app (30 seconds max)

## Step 6: Submit for Review

1. In App Store Connect, go to your app version
2. Scroll to **"Build"** section
3. Click **"+"** next to Build
4. Select the build you uploaded
5. Click **"Save"**
6. Review all information
7. Click **"Submit for Review"**
8. Answer export compliance questions (usually "No" for simple apps)

## Step 7: Review Process

- **Initial Review**: 24-48 hours typically
- **Status Updates**: Check App Store Connect dashboard
- **Possible Outcomes**:
  - ✅ **Approved**: App goes live immediately or on scheduled date
  - ⚠️ **Rejected**: Fix issues and resubmit
  - 📝 **In Review**: Still being reviewed

## Common Rejection Reasons

1. **Missing Privacy Policy**: Required for all apps
2. **Incomplete Information**: Missing screenshots or descriptions
3. **Guideline Violations**: Review [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
4. **Technical Issues**: Crashes, broken functionality
5. **Metadata Issues**: Misleading descriptions or keywords

## Quick Checklist

Before submitting, ensure:

- [ ] Apple Developer account is active
- [ ] Bundle identifier is set and unique
- [ ] App is signed with your developer certificate
- [ ] Version and build numbers are set
- [ ] App icon (1024×1024) is included
- [ ] App runs without crashes
- [ ] Privacy Policy URL is provided
- [ ] App description is complete
- [ ] Screenshots are uploaded (at least 3 per device)
- [ ] Support URL is provided
- [ ] App has been tested thoroughly
- [ ] Archive validates successfully
- [ ] Build is uploaded to App Store Connect
- [ ] All App Store Connect fields are filled
- [ ] App is submitted for review

## Privacy Policy Template

Since a Privacy Policy is required, here's a simple template you can use:

```
Privacy Policy for [App Name]

Last updated: [Date]

We respect your privacy. This app stores data locally on your device only.

Data Collection:
- This app does not collect, transmit, or share any personal information.
- All data (medicine intake records) is stored locally on your device using UserDefaults.
- No data is sent to external servers.

Contact:
If you have questions about this privacy policy, contact us at [your email].
```

Host this on a free service like:
- GitHub Pages
- Netlify
- Your own website

## Additional Resources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)

## Need Help?

If you encounter issues:
1. Check Xcode's **Organizer** for detailed error messages
2. Review App Store Connect for status updates
3. Check Apple Developer Forums
4. Contact Apple Developer Support if needed

Good luck with your submission! 🚀

