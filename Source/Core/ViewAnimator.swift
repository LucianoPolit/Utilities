//
//  ViewAnimator.swift
//
//  Created by Luciano Polit on 3/2/18.
//

import Foundation
import UIKit

open class ViewAnimator {
    
    public init() { }
    
    open func begin() -> Animation {
        return Animation()
    }
    
    open class Animation {
        
        private var isCommitted = false
        private var duration: TimeInterval?
        private var delay: TimeInterval = 0
        private var options: UIView.AnimationOptions = []
        private var first: (() -> ())?
        private var animations: (() -> ())?
        private var completion: ((Bool) -> ())?
        
        public init() { }
        
        open func duration(_ duration: TimeInterval) -> Self {
            self.duration = duration
            return self
        }
        
        open func delay(_ delay: TimeInterval) -> Self {
            self.delay = delay
            return self
        }
        
        open func options(_ options: UIView.AnimationOptions) -> Self {
            self.options = options
            return self
        }
        
        open func before(_ execution: @escaping () -> ()) -> Self {
            self.first = execution
            return self
        }
        
        open func animations(_ animations: @escaping () -> ()) -> Self {
            self.animations = animations
            return self
        }
        
        open func completion(_ completion: @escaping (Bool) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        open func completion(_ completion: Animation) -> Self {
            return self.completion { completed in
                guard completed else { return }
                completion.commit()
            }
        }
        
        open func completion(_ completion: [Animation]) -> Self {
            return self.completion { completed in
                guard completed else { return }
                completion.forEach { $0.commit() }
            }
        }
        
        open func commit() {
            guard !isCommitted else { return }
            guard let duration = duration, let animations = animations
                else { fatalError("Utilities -> ViewAnimator -> Incomplete animation") }
            first?()
            UIView.animate(withDuration: duration,
                           delay: delay,
                           options: options,
                           animations: animations,
                           completion: completion)
            isCommitted = true
        }
        
    }
    
}
