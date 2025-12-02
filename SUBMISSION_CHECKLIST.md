# App Store Submission Checklist - Complete Each Item

## ✅ 1. Content Rights Information

**Location:** App Store Connect → Your App → App Information

**Steps:**
1. Go to **App Information** section
2. Find **"Content Rights"** or **"Rights and Pricing"**
3. Check the box: **"I confirm that I have the rights to use all content in this app"**
4. Click **Save**

**What this means:** You're confirming you own/have rights to all code, images, and content in your app. Since you built it yourself, you can check this.

---

## ✅ 2. Privacy Policy URL

**Location:** App Store Connect → Your App → App Privacy

**You need to:**
1. Host your privacy policy on a publicly accessible URL
2. Enter that URL in App Store Connect

### Option A: Use GitHub Pages (Free & Easy)

1. **Create a file in your GitHub repo:**
   - Go to your repo: `https://github.com/ghostli123/medicine-button`
   - Click **"Add file"** → **"Create new file"**
   - Name it: `privacy-policy.html`
   - Copy the content below
   - Commit the file

2. **Enable GitHub Pages:**
   - Go to repo **Settings** → **Pages**
   - Under **Source**, select **"main"** branch and **"/ (root)"**
   - Click **Save**
   - Your privacy policy will be at: `https://ghostli123.github.io/medicine-button/privacy-policy.html`

3. **Enter URL in App Store Connect:**
   - Go to **App Privacy** section
   - Paste: `https://ghostli123.github.io/medicine-button/privacy-policy.html`

### Privacy Policy HTML (copy this):

```html
<!DOCTYPE html>
<html>
<head>
    <title>Privacy Policy - Medicine Tracker</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; line-height: 1.6; }
        h1 { color: #333; }
        h2 { color: #555; margin-top: 30px; }
    </style>
</head>
<body>
    <h1>Privacy Policy for Medicine Tracker</h1>
    <p><strong>Last Updated:</strong> November 30, 2024</p>
    
    <h2>Introduction</h2>
    <p>This Privacy Policy describes how the Medicine Tracker app handles information when you use our application.</p>
    
    <h2>Data Collection and Storage</h2>
    <p><strong>We do not collect, transmit, or share any personal information.</strong></p>
    <ul>
        <li>All data is stored locally on your device only</li>
        <li>Medicine intake records are saved using iOS UserDefaults</li>
        <li>No data is transmitted to external servers</li>
        <li>No analytics or tracking services are used</li>
        <li>No third-party services collect your information</li>
    </ul>
    
    <h2>Information Stored Locally</h2>
    <p>The app stores the following information on your device:</p>
    <ul>
        <li>The date and time when you marked medicine as taken</li>
        <li>This information is used solely to determine if the button can be clicked again on the same day</li>
    </ul>
    
    <h2>Data Security</h2>
    <ul>
        <li>All data remains on your device</li>
        <li>Data is stored using iOS's built-in UserDefaults system</li>
        <li>You can delete the app at any time to remove all stored data</li>
    </ul>
    
    <h2>Children's Privacy</h2>
    <p>This app does not knowingly collect information from children. The app is designed for personal use by adults.</p>
    
    <h2>Changes to This Privacy Policy</h2>
    <p>We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated "Last Updated" date.</p>
    
    <h2>Contact Us</h2>
    <p>If you have any questions about this Privacy Policy, please contact us at:</p>
    <ul>
        <li>GitHub: <a href="https://github.com/ghostli123/medicine-button">https://github.com/ghostli123/medicine-button</a></li>
    </ul>
</body>
</html>
```

### Option B: Use a Simple Text File (GitHub Raw)

1. Add `PRIVACY_POLICY.md` to your repo (already exists)
2. Use this URL: `https://raw.githubusercontent.com/ghostli123/medicine-button/main/PRIVACY_POLICY.md`
3. Note: This shows markdown, but Apple accepts it

---

## ✅ 3. Primary Category

**Location:** App Store Connect → Your App → App Information

**Steps:**
1. Go to **App Information** section
2. Find **"Category"**
3. Select **Primary Category:** **"Health & Fitness"** or **"Medical"**
   - **Recommended:** **"Health & Fitness"** (broader audience)
   - Alternative: **"Medical"** (if you want to be more specific)
4. **Secondary Category (optional):** Leave blank or choose "Utilities"
5. Click **Save**

---

## ✅ 4. Age Rating

**Location:** App Store Connect → Your App → App Information → Age Rating

**Steps:**
1. Go to **App Information** → **Age Rating**
2. Click **"Edit"** or **"Set Up"**
3. Answer each question. For your medicine app, select:

   **Content Descriptions:**
   - **Medical/Treatment Information:** ✅ **Frequent/Intense** (your app tracks medication)
   - **Unrestricted Web Access:** ❌ **None**
   - **Gambling and Contests:** ❌ **None**
   - **Contests:** ❌ **None**
   - **Simulated Gambling:** ❌ **None**
   - **Alcohol, Tobacco, or Drug Use:** ❌ **None** (unless your app promotes drug use, which it doesn't)
   - **Mature/Suggestive Themes:** ❌ **None**
   - **Profanity or Crude Humor:** ❌ **None**
   - **Horror/Fear Themes:** ❌ **None**
   - **Violence:** ❌ **None**
   - **Sexual Content or Nudity:** ❌ **None**

4. After answering, Apple will show: **"4+"** or **"Ages 4+"** rating
5. Click **Save**

**Note:** Since your app tracks medication, it will likely get a 4+ rating (medical content is allowed for all ages if it's informational/tracking).

---

## ✅ 5. App Privacy Practices (Admin Required)

**Location:** App Store Connect → Your App → App Privacy

**IMPORTANT:** This must be completed by an **Admin** account holder.

**Steps:**
1. Go to **App Privacy** section
2. Click **"Get Started"** or **"Edit"**
3. Answer the privacy questions:

   **Data Collection:**
   - **Does your app collect data?** → Select **"No, we do not collect data from this app"**
   
   OR if that option isn't available:
   
   - **Health & Fitness:** Select **"No"** (data is stored locally only)
   - **User Content:** Select **"No"**
   - **Identifiers:** Select **"No"**
   - **Usage Data:** Select **"No"**
   - **Diagnostics:** Select **"No"**
   - **Other Data Types:** Select **"No"**

4. **Privacy Policy URL:** Enter the URL from step 2 above
5. Click **Save**

**If you see "Admin Required":**
- Make sure you're logged in as the account holder (not just a team member)
- If you're part of an organization, the Account Holder must complete this
- Contact Apple Developer Support if you're the account holder but still see this message

---

## ✅ 6. Price Tier

**Location:** App Store Connect → Your App → Pricing and Availability

**Steps:**
1. Go to **Pricing and Availability** section
2. Under **Price Schedule:**
   - Select **"Free"** (recommended for your first app)
   - OR choose a price tier if you want to charge
3. **Availability:** Select countries (default is "All countries or regions")
4. Click **Save**

**Recommendation:** Start with **Free** to get more downloads and reviews. You can change it later if you want.

---

## Quick Reference - Where to Find Each Section:

1. **Content Rights:** App Information → Scroll down → Content Rights checkbox
2. **Privacy Policy URL:** App Privacy → Privacy Policy URL field
3. **Primary Category:** App Information → Category dropdown
4. **Age Rating:** App Information → Age Rating → Edit
5. **App Privacy Practices:** App Privacy → Get Started/Edit
6. **Price Tier:** Pricing and Availability → Price Schedule

---

## After Completing All Items:

1. Go back to your app version
2. Click **"Submit for Review"** again
3. All items should now be checked ✅
4. Complete the export compliance question if prompted
5. Submit!

---

## Need Help?

If you're stuck on any step:
- Take a screenshot of what you see
- Check if you're logged in as the Account Holder (not just a team member)
- Verify your Apple Developer Program membership is active
- Contact Apple Developer Support if needed

