//
//  NibLoadable.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation
import UIKit

public protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable {
    
    public static var nibName: String {
        return String(describing: self).components(separatedBy: ".").first!
    }
    
}

extension NibLoadable where Self: UIView {
    
    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    public static func loadFromNib(bundle: Bundle = .main) -> Self {
        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self
            else { fatalError("Utilities -> NibLoadable -> Impossible to load \(Self.nibName)") }
        return view
    }
    
}

extension UITableView {
    
    public func register<T: UITableViewCell & NibLoadable>(cellType: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.nibName)
    }
    
    public func dequeueReusableCell<T: UITableViewCell & NibLoadable>(of type: T.Type,
                                                                      for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as! T
    }
    
}

extension UICollectionView {
    
    public func register<T: UICollectionViewCell & NibLoadable>(cellType: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.nibName)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell & NibLoadable>(of type: T.Type,
                                                                           for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as! T
    }
    
}
