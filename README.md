# Requirements

*   iOS 15 or above
    
*   API key
    

# API Key

In order to use IA SDK you will need API key with proper entitlements. Your API key is tied to your bundle ID(s).

@TODO where to get it.

# Installation

To add the IA SDK to your Xcode project, follow these steps:

1.  Open your Xcode `project` or `workspace`, then go to **File > Add Package Dependencies**…
    
2.  In the **Search or Enter Package URL** field, enter [https://github.com/ihreapotheken/IA-SDK-iOS](https://github.com/ihreapotheken/IA-SDK-iOS).
    
3.  Specify the version you want to use and click **Add Package**. We recommend selecting **Exact Version** at this time.  
    ![](docs/resources/installation_1.png)
    
4.  Choose the package products you need, assign them to your app target, and click **Add Package**.
    
    > ⚠️ Make sure your API key includes all the products you select.

    ![](docs/resources/installation_2.png)
    

# Initial setup and configuration
1. **Import the required products**  
`IAOverTheCounter` is selected because we want **Search** feature in our example app. `IAOrdering` is selected because we want **Cart** feature. `IACore` is always needed. `IAIntegrations` is needed to handle prerequisites.

   ```swift
   import IACore
   import IAIntegrations
   import IAOverTheCounter
   import IAOrdering
   ```

2. **Initialize the SDK**  
   At the starting point of your app, call `IASDK.setup` and provide your API key.  
   > ⚠️ Ensure the API key matches your app’s bundle ID.

   ```swift
   try await IASDK.setup(
       apiKey: "YOUR_API_KEY_HERE",
       loadRemoteConfiguration: false
   )
   ```

3. **Set up the product SDKs**  
   Next, call the `setup()` method for each product you plan to use. This step is required because products can be interconnected.  
   For example, calling `IAOrderingSDK.setup()` makes the **Cart** feature (from `IAOrdering`) internally available to the **Search** feature (from `IAOverTheCounter`), enabling features like a cart button on the search screen.

   You can call these immediately after `IASDK.setup`:

   ```swift
   try await IAOverTheCounterSDK.setup()
   try await IAOrderingSDK.setup()
   ```

# Prerequisites

Before using any SDK features, you must ensure that required conditions are met. Call the following line once your UI is ready:

```swift
try await IAIntegrationsSDK.Prerequisites.runPrerequisites(isAnimated: false)

```

This will present a screen consisting of three steps:

*   **Legal Opt-In (mandatory):** The user must opt in to use the SDK.
    
*   **Onboarding (optional):** An introductory onboarding screen shown only once.
    
*   **Pharmacy (mandatory):** Most products require a pharmacy to be set. You can either:
    
    *   Manually provide a pharmacy identifier to the IA SDK, or
        
    *   If you’re using the IAPharmacy product, allow users to search for pharmacies via the **Pharmacy Finder** feature. You will have to call `IAPharmacySDK.setup()` in your SDK setup.
        

To skip certain steps, see [Prerequisites](./docs/Prerequisites.md).

# Features

[Prerequisites](./docs/Prerequisites.md)  

[IAOverTheCounter](./docs/IAOverTheCounter.md)  

[IAOrdering](./docs/IAOrdering.md)  

[Style Configuration](./docs/StyleConfiguration.md)  


# Example
This is full code for example app that has **Search** feature on one tab and **Cart** feature on another. These two features will internally communicate, e.g. when you add some product from search or any other screen, it will be added to cart.

```swift
import SwiftUI
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering

@main
struct OverTheCounterExampleApp: App {
    @State private var isLoaded = false
    
    var body: some Scene {
        WindowGroup {
            TabView {   
                if isLoaded {
                    IAProductSearchScreen()
                        .tabItem { Text("Search") }
                    
                    IACartScreen()
                        .tabItem { Text("Cart") }
                }
            }
            .onFirstAppear {
                await setupSDK()
                await runPrerequisites()
                isLoaded = true
            }
        }
    }
}

extension OverTheCounterExampleApp {
    private func setupSDK() async {
        do {
            try await IASDK.setup(apiKey: "YOUR_API_KEY_HERE, loadRemoteConfiguration: false)
            try await IAOverTheCounterSDK.setup()
            try await IAOrderingSDK.setup()
        } catch {
            print(">>> Error \(error)")
        }
    }
    
    private func runPrerequisites() async {
        do {
            _ = try await IAIntegrationsSDK.Prerequisites.runPrerequisites(isAnimated: false)
        } catch {
            print(">>> Error \(error)")
        }
    }
}

```
