# IAOverTheCounter

Contains features related to search and products:

*   **Search screen**: Search bar with list of products, allows filtering and sorting.
    
*   **Product details**: Displays details of a selected product.
    
*   **Product inquiry**: Enables user to send E-Mail to pharmacies and inquiry about the product.
    
*   **Cart integration**: Cart is integrated into list and details if `IAOrdering` module is setup.
    

# Product Search

`IAProductSearchScreen` is the starting point of a **Product Search** feature. It handles all flows automatically (search, details, inquiry, cart). Currently this is the only class that `IAOverTheCounter` exposes.

### **Notes**

*   `IAProductSearchScreen` is a SwiftUI view that you can e.g., put in a tab view or present it. By default it is embedded into a navigation bar and handles its own navigation.
    
*   It uses pharmacy identifier from prerequisites flow.
    

### Integration with other products

*   **Cart**: Cart is integrated into list and details.
    
*   **RX**: Search product by scanning its code.
    

### Example

`IAProductSearchScreen` inside a SwiftUI TabView. This is all you need to call (other than setup code and prerequisites).

```javascript
TabView {   
    IAProductSearchScreen()
        .tabItem { Text("Search") }
}

```

# To be implemented

*   in the future `IAProductSearch` will accept Navigator as argument, this will allow it to be embedded into outside Navigation.
