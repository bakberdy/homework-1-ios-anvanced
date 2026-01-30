# Temperature Converter App

A simple iOS temperature converter application built with UIKit, MVVM architecture, and Combine framework.

## Features

- ✅ User enters temperature in Celsius
- ✅ Fahrenheit value updates automatically using Combine
- ✅ Reset button clears all fields
- ✅ UI updates only via Combine bindings (@Published)
- ✅ Clean MVVM architecture
- ✅ Modern, polished UI design
- ✅ Programmatic UI (No Storyboards)

## Architecture

### MVVM Pattern
- **Model**: Temperature conversion logic
- **ViewModel**: `TemperatureViewModel` - Manages business logic and data binding using Combine
- **View**: `ViewController` - Manages UI and user interactions

### Combine Integration
- `@Published` properties in ViewModel for reactive data flow
- Automatic Fahrenheit calculation when Celsius changes
- No manual UI updates - everything is driven by Combine bindings

## Project Structure

```
homework-1/
├── ViewController.swift          # Main view controller with UI
├── TemperatureViewModel.swift    # ViewModel with Combine bindings
├── SceneDelegate.swift           # Programmatic window setup
├── AppDelegate.swift
└── Assets.xcassets/
```

## Key Implementation Details

### TemperatureViewModel.swift
```swift
class TemperatureViewModel {
    @Published var celsiusText: String = ""
    @Published var fahrenheitText: String = ""
    
    private func setupBindings() {
        $celsiusText
            .map { /* Convert Celsius to Fahrenheit */ }
            .assign(to: &$fahrenheitText)
    }
    
    func reset() {
        celsiusText = ""
        fahrenheitText = ""
    }
}
```

### ViewController.swift
- UI built programmatically using Auto Layout
- Combine publishers bind TextField to ViewModel
- ViewModel publishers update UI automatically
- Reset button clears all fields via ViewModel

### SceneDelegate.swift
- Programmatic window and root view controller setup
- No storyboard dependency

## How to Run

1. Open `homework-1.xcodeproj` in Xcode
2. Select a simulator or device (iOS 13.0+)
3. Press `Cmd + R` to build and run
4. Enter a Celsius temperature and watch Fahrenheit update automatically
5. Tap Reset to clear all fields

## Requirements Met

✅ **Celsius Input**: User can enter temperature in Celsius  
✅ **Auto Fahrenheit Update**: Fahrenheit updates automatically via Combine  
✅ **Reset Button**: Clears all fields  
✅ **Combine Bindings**: All UI updates use @Published and Combine  
✅ **MVVM Architecture**: Clear separation of concerns  
✅ **UIKit**: Built with UIKit (no SwiftUI)  

## Formula

Fahrenheit = (Celsius × 9/5) + 32

## UI Features

- Clean, modern design with shadow effects
- Color-coded UI elements
- Disabled Fahrenheit field (read-only)
- Keyboard dismissal on tap
- Numeric keyboard for temperature input

## Author

Bakberdi Esentai  
Date: January 30, 2026
