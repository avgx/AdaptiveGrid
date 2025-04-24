# AdaptiveGrid

Wrapper around LazyVGrid to fit all subviews without scroll and don't recreate on rotate.
  
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

## Preview

<img width="554" alt="landscape" src="https://github.com/user-attachments/assets/5715959f-75c1-43dc-8b6b-97d50850e57e" />
<br/>
<img width="345" alt="portrait" src="https://github.com/user-attachments/assets/96fc58b4-511f-4177-91fe-3ee1499f0448" />
<br/>

## License

AdaptiveGrid is available under the MIT license. See the LICENSE file for more info.
