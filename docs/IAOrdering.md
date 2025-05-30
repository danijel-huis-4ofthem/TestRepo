# IAOrdering

Contains features related to cart, checkout, payment and thank you page:

*   **Empty cart screen:** When cart is empty it shows recommended products and products of the month. It allows user to add products and prescriptions.
    
*   **Cart screen:** Overview of all products and prescriptions in the cart, including cost section.
    
*   **Checkout screen:** Delivery and payment options, product overview, prescription overview and cost section.
    
*   **PayPal payment:** In-App PayPal integration.
    
*   **Thank You page:** Overview of the order, users can provide their own thank you page (in future).
    

# Cart

`IACartScreen` is the starting point of a **Cart** feature. It handles all flows automatically (cart, checkout, payment, thank you). Currently this is the only class that `IAOrdering` exposes.

### **Notes**

*   `IACartScreen` is a SwiftUI view that you can e.g., put in a tab view or present it. By default it is embedded into a navigation bar and handles its own navigation.
    
*   It uses pharmacy identifier from prerequisites flow.
    
*   It is reactive and communicates with other products, e.g., adding product from **Product Search** feature will automatically add it to cart.
    

### Integration with other products

*   **IAOverTheCounter**: Product recommendations.
    
*   **IARX**: Scan prescriptions.
    

### Example

`IACartScreen` inside a SwiftUI TabView. This is all you need to call (other than setup code and prerequisites).

```javascript
TabView {   
    IACartScreen()
        .tabItem { Text("Search") }
}

```

# To be implemented

*   Thank you page: Users will be able to use their own.
