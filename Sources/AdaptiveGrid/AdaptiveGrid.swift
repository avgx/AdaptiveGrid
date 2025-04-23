import SwiftUI

public enum AdaptiveGrid { }

extension AdaptiveGrid {
    public struct Constants {
        public static var LongSide:  [Int] {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                [1, 2, 3, 2, 3, 4, 5, 6, 7, 9]
            case .pad:
                [1, 2, 3, 2, 3, 4, 3, 5, 4, 4, 5, 5]
            default:
                [1, 2, 3, 2, 3, 4, 5, 6, 7, 9]
            }
        }
        public static var ShortSide: [Int] {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                [1, 1, 1, 2, 2, 2, 2, 3, 4, 5]
            case .pad:
                [1, 1, 1, 2, 2, 2, 3, 2, 3, 4, 4, 5]
            default:
                [1, 1, 1, 2, 2, 2, 2, 3, 4, 5]
            }
            
        }
        
        public static var Count: [Int] {
            zip(LongSide, ShortSide).map({ x, y in x*y })
        }
    }
}

extension AdaptiveGrid {
    public struct Grid<Content: View>: View {
        let count: Int
        let content: (Int) -> Content
        
        public init(count: Int, @ViewBuilder content: @escaping (Int) -> Content) {
            self.count = count
            self.content = content
        }
        
        public var body: some View {
            GeometryReader { geometry in
                let i = Constants.Count.firstIndex(where: { $0 >= count }) ?? Constants.Count.last ?? 0
                
                let C = Constants.LongSide[i]
                let R = Constants.ShortSide[i]
                
                let isLandscape = geometry.size.width > geometry.size.height
                let columns = isLandscape ? C : R
                let rows = isLandscape ? R : C
                
                let column = GridItem(.flexible(minimum: 10, maximum: .infinity), spacing: 0, alignment: .center)
                let gridcolumns: [GridItem] = .init(repeating: column, count: columns)
                let rowheight = geometry.size.height / CGFloat(rows)
                Inner(count: count, columns: gridcolumns, rowheight: rowheight, content: content)
            }
        }
    }
}

fileprivate struct Inner<Content: View>: View {
    let count: Int
    let columns: [GridItem]
    let rowheight: CGFloat
    let content: (Int) -> Content
    
    init(count: Int, columns: [GridItem], rowheight: CGFloat, @ViewBuilder content: @escaping (Int) -> Content) {
        self.count = count
        self.columns = columns
        self.rowheight = rowheight
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<count, id: \.self) { index in
                content(index)
                    .frame(height: rowheight)
                    .id(index)
            }
        }
    }
}

#Preview("3") {
    NavigationView {
        AdaptiveGrid.Grid(count: 3) { index in
            Color.red
                .padding(4)
        }
    }
}

#Preview("6") {
    AdaptiveGrid.Grid(count: 6) { index in
        Color.red
            .padding(4)
    }
}

#Preview("9") {
    AdaptiveGrid.Grid(count: 9) { index in
        Color.red
            .padding(4)
    }
}

#Preview("24") {
    AdaptiveGrid.Grid(count: 24) { index in
        Color.red
            .padding(4)
    }
}
