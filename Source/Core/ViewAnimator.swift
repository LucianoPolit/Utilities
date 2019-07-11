//
//  ViewAnimator.swift
//
//  Created by Luciano Polit on 3/2/18.
//

import Foundation
import UIKit

public class ViewAnimator {
    
    public func begin() -> Animation {
        return Animation().begin()
    }
    
    public class Animation {
        
        private var isCommitted = false
        private var duration: TimeInterval?
        private var delay: TimeInterval = 0
        private var options: UIView.AnimationOptions = []
        private var first: (() -> ())?
        private var animations: (() -> ())?
        private var completion: ((Bool) -> ())?
        
        public func begin() -> Self {
            return self
        }
        
        public func duration(_ duration: TimeInterval) -> Self {
            self.duration = duration
            return self
        }
        
        public func delay(_ delay: TimeInterval) -> Self {
            self.delay = delay
            return self
        }
        
        public func options(_ options: UIView.AnimationOptions) -> Self {
            self.options = options
            return self
        }
        
        public func before(_ execution: @escaping () -> ()) -> Self {
            self.first = execution
            return self
        }
        
        public func animations(_ animations: @escaping () -> ()) -> Self {
            self.animations = animations
            return self
        }
        
        public func completion(_ completion: @escaping (Bool) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public func commit() {
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
