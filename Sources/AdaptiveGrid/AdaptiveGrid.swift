import SwiftUI


public struct AdaptiveGrid<Content: View>: View {
    let dimensions: AdaptiveDimensions
    let content: (Int) -> Content
    
    let column = GridItem(.flexible(minimum: 10, maximum: .infinity), spacing: 0, alignment: .center)
    
    public init(_ longSide: Int, _ shortSide: Int, @ViewBuilder content: @escaping (Int) -> Content) {
        self.init(AdaptiveDimensions(longSide, shortSide), content: content)
    }
    
    public init(_ dimensions: AdaptiveDimensions, @ViewBuilder content: @escaping (Int) -> Content) {
        self.dimensions = dimensions
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let columns = isLandscape ? dimensions.longSide : dimensions.shortSide
            let rows = isLandscape ? dimensions.shortSide : dimensions.longSide
            
            let gridcolumns: [GridItem] = .init(repeating: column, count: columns)
            let rowheight = geometry.size.height / CGFloat(rows)
            Inner(dimensions: dimensions, columns: gridcolumns, rowheight: rowheight, content: content)
        }
    }
}


fileprivate struct Inner<Content: View>: View {
    let dimensions: AdaptiveDimensions
    let columns: [GridItem]
    let rowheight: CGFloat
    let content: (Int) -> Content
    
    init(dimensions: AdaptiveDimensions, columns: [GridItem], rowheight: CGFloat, @ViewBuilder content: @escaping (Int) -> Content) {
        self.dimensions = dimensions
        self.columns = columns
        self.rowheight = rowheight
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<dimensions.count, id: \.self) { index in
                content(index)
                    .frame(height: rowheight)
                    .id(index)
            }
        }
    }
}

#Preview("4x3") {
    NavigationView {
        AdaptiveGrid(4, 3) { index in
            Color.red
                .padding(4)
        }
    }
}

#Preview("6x4") {
    AdaptiveGrid(6, 4) { index in
        ZStack {
            Color.red
                .padding(4)
            Text("\(index)")
                .foregroundStyle(.white)
        }
    }
}

#Preview("3x3") {
    AdaptiveGrid(3, 3) { index in
        Color.red
            .padding(4)
    }
}

#Preview("3x2") {
    AdaptiveGrid(3, 2) { index in
        Color.red
            .padding(4)
    }
}

#Preview("8x8") {
    AdaptiveGrid(8, 8) { index in
        Color.red
            .padding(4)
    }
}
