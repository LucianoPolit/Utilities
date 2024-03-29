//
//  Extensions.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import UIKit

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func localized(with arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
    
}

extension Collection {
    
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

extension Array {
    
    public mutating func prepend(_ element: Element) {
        insert(element, at: 0)
    }
    
    public mutating func prepend(contentsOf array: [Element]) {
        insert(contentsOf: array, at: 0)
    }
    
}

extension Array where Element: Equatable {
    
    public mutating func remove(_ element: Element) {
        while remove(firstAppearanceOf: element) { }
    }
    
    @discardableResult
    public mutating func remove(firstAppearanceOf element: Element) -> Bool {
        guard let index = firstIndex(of: element) else { return false }
        remove(at: index)
        return true
    }
    
}

extension Array {
    
    public func prepending(
        _ value: Element
    ) -> [Element] {
        var copy = self
        copy.prepend(value)
        return copy
    }
    
    public func prepending(
        contentsOf value: [Element]
    ) -> [Element] {
        var copy = self
        copy.prepend(contentsOf: value)
        return copy
    }
    
    public func inserting(
        _ value: Element,
        at index: Int
    ) -> [Element] {
        var copy = self
        copy.insert(value, at: index)
        return copy
    }
    
    public func inserting(
        contentsOf value: [Element],
        at index: Int
    ) -> [Element] {
        var copy = self
        copy.insert(contentsOf: value, at: index)
        return copy
    }
    
    public func appending(
        _ value: Element
    ) -> [Element] {
        var copy = self
        copy.append(value)
        return copy
    }
    
    public func appending(
        contentsOf value: [Element]
    ) -> [Element] {
        var copy = self
        copy.append(contentsOf: value)
        return copy
    }
    
    public func removing(
        at index: Int
    ) -> [Element] {
        var copy = self
        copy.remove(at: index)
        return copy
    }
    
}

extension Array where Element: Equatable {
    
    public func removing(
        _ value: Element
    ) -> [Element] {
        var copy = self
        while let index = copy.firstIndex(where: { $0 == value }) {
            copy.remove(at: index)
        }
        return copy
    }
    
    public func removing(
        contentsOf value: [Element]
    ) -> [Element] {
        var copy = self
        value.forEach {
            copy = copy.removing($0)
        }
        return copy
    }
    
}

extension UIColor {
    
    public convenience init(hex: String) {
        let str = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: str)
        
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public var hex: String {
        let components = cgColor.components
        let r = components?[safe: 0] ?? 0
        let g = components?[safe: components?.count == 2 ? 0 : 1] ?? 0
        let b = components?[safe: components?.count == 2 ? 0 : 2] ?? 0
        
        return String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
     }
    
}

extension UIView {
    
    public var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }
    
}

extension UIViewController {
    
    public var topViewController: UIViewController {
        let viewController = presentedViewController ?? self
        switch viewController {
        case let navigationController as UINavigationController:
            return (navigationController.viewControllers.last ?? navigationController).topViewController
        case let tabBarController as UITabBarController:
            return (tabBarController.selectedViewController ?? tabBarController).topViewController
        default:
            return viewController
        }
    }
    
}
