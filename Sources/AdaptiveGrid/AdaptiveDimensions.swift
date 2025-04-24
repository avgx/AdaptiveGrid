import Foundation
import UIKit

public struct AdaptiveDimensions: Codable, Hashable, Sendable {
    public let longSide: Int
    public let shortSide: Int
    
    public var count: Int {
        longSide*shortSide
    }
    
    public var aspect: Double {
        Double(longSide)/Double(shortSide)
    }
    
    public init(_ longSide: Int, _ shortSide: Int) {
        self.longSide = longSide
        self.shortSide = shortSide
    }
}

extension AdaptiveDimensions: Identifiable, CustomStringConvertible {
    public var description: String {
        id
    }
    
    public var id: String {
        "\(longSide)x\(shortSide)"
    }
}

extension AdaptiveDimensions {
    public static var phone: [AdaptiveDimensions] {
        [
            .init(2,1),
            .init(3,1),
            .init(2,2),
            .init(3,2),
            .init(4,2),
            .init(5,2),
            .init(6,3),
            .init(7,4),
            .init(9,5)
        ]
    }
    
    public static var pad: [AdaptiveDimensions] {
        [
            .init(2,1),
            .init(2,2),
            .init(3,2),
            .init(4,2),
            .init(3,3),
            .init(4,3),
            .init(5,4),
            .init(6,4),
            .init(7,5),
            .init(8,6)
        ]
    }
    
    public static var recommended: [AdaptiveDimensions] {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            phone
        case .pad:
            pad
        case .tv:
            pad
        default:
            pad
        }
    }
}
