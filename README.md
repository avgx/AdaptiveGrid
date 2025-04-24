# AdaptiveGrid

Wrapper around LazyVGrid to fit all subviews without scroll.
  
```swift
    AdaptiveGrid(6, 4) { index in
        ZStack {
            Color.red
                .padding(4)
            Text("\(index)")
                .foregroundStyle(.white)
        }
    }
```

## License

AdaptiveGrid is available under the MIT license. See the LICENSE file for more info.
