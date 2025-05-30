# Prerequisites

Before using any features or displaying them on screen, make sure the following conditions are met. Call the following line of code once your UI is ready:

```swift
try await IAIntegrationsSDK.Prerequisites.runPrerequisites(isAnimated: false)
```

This will present a screen consisting of three steps:

*   **Legal Opt-In (mandatory):** The user must opt in to use the SDK.
    
*   **Onboarding (optional):** An introductory onboarding screen shown only once.
    
*   **Pharmacy (mandatory):** Most products require a pharmacy to be set. You can either:
    
    *   Manually provide a pharmacy identifier to the IA SDK, or
        
    *   If you’re using the IAPharmacy product, allow users to search for pharmacies via the **Pharmacy Finder** feature. You will have to call `IAPharmacySDK.setup()` in your SDK setup.
        

To skip certain steps, use the following code:

```swift
// Marks the legal step as completed so it won't be shown again.
IAIntegrationsSDK.Prerequisites.setIsLegalDisclaimerShown(true)

// Marks the onboarding step as completed so it won't be shown again.
IAIntegrationsSDK.Prerequisites.setIsOnboardingShown(true)

// Manually sets the pharmacy ID. Pass `nil` to clear it.
IASDK.Pharmacy.setPharmacyID(12345)
```
