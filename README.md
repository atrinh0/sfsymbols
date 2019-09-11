<p align="center"><img src="images/sfsymbols-logo.png"></p>

# SF Symbols - SwiftUI App

> Experimenting with SwiftUI whilst creating a practical app to browse the SF Symbols via an iOS app.

<center>
### List all SF Symbols
![](./images/list.png)

### Dark/Light toggle
![](./images/list-dark.png)

### Sort
![](./images/sort.png)

### Filter
![](./images/filter.png)

### Symbol details
Showcase the symbol in the navigation bar, tab bar, etc
![](./images/details.png)

### Show symbol weights
![](./images/details-dark.png)
</center>


### Known issues

- SwiftUI does not handle dynamically filtering a list of 1600+ items, 100% CPU for 8 seconds (I capped the results to filter the first 50 symbols and exposed a `See all` option as a workaround)
- iPad master/detail view
- The symbols are copied from the SF Symbols beta mac app (this is a manual process)
- There are a handful of icons that no longer exist in Xcode 11 GM Seed (but still exist on the SF Symbols mac app)

### Disclaimer

> All content copyright of Apple