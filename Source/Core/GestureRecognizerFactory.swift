//
//  GestureRecognizerFactory.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation
import UIKit

public class GestureRecognizerFactory {
    
    public func create<T: UIGestureRecognizer>(type: T.Type = T.self) -> Builder<T> {
        return Builder()
    }
    
    public class Builder<T: UIGestureRecognizer> {
        
        private var configuration: ((T) -> ())?
        private var completion: ((T) -> ())?
        
        public func configure(_ block: @escaping (T) -> ()) -> Self {
            configuration = block
            return self
        }
        
        public func completion(_ completion: @escaping (T) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public func build() -> T {
            let gestureRecognizer = T()
            gestureRecognizer.setCompletion { [completion] gestureRecognizer in
                guard let gestureRecognizer = gestureRecognizer as? T else { return }
                completion?(gestureRecognizer)
            }
            configuration?(gestureRecognizer)
            return gestureRecognizer
        }
        
    }
    
}

extension GestureRecognizerFactory {
    
    public func createTap() -> Builder<UITapGestureRecognizer> {
        return create()
    }
    
    public func createPan() -> Builder<UIPanGestureRecognizer> {
        return create()
    }
    
    public func createPinch() -> Builder<UIPinchGestureRecognizer> {
        return create()
    }
    
    public func createSwipe() -> Builder<UISwipeGestureRecognizer> {
        return create()
    }
    
    public func createRotation() -> Builder<UIRotationGestureRecognizer> {
        return create()
    }
    
    public func createLongPress() -> Builder<UILongPressGestureRecognizer> {
        return create()
    }
    
    public func createScreenEdgePan() -> Builder<UIScreenEdgePanGestureRecognizer> {
        return create()
    }
    
}

extension GestureRecognizerFactory.Builder {
    
    @discardableResult
    public func add(to view: UIView) -> T {
        let gestureRecognizer = build()
        view.addGestureRecognizer(gestureRecognizer)
        return gestureRecognizer
    }
    
}

private extension UIGestureRecognizer {
    
    struct AssociatedKeys {
        static var completion = "completion"
    }
    
    var completion: ((UIGestureRecognizer) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.completion) as? (UIGestureRecognizer) -> ()
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.completion,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setCompletion(_ completion: @escaping (UIGestureRecognizer) -> ()) {
        addTarget(self, action: #selector(handler))
        self.completion = completion
    }
    
    @objc
    func handler(_ gestureRecognizer: UIGestureRecognizer) {
        completion?(gestureRecognizer)
    }
    
}
