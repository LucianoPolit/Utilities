//
//  MockViewAnimator.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import UIKit
import AwesomeUtilities

public class MockViewAnimator: ViewAnimator {
    
    public var animations: [MockAnimation] = []
    
    public override func begin() -> Animation {
        let animation = MockAnimation()
        animations.append(animation)
        return animation
    }
    
    public class MockAnimation: Animation {
        
        public private(set) var duration: TimeInterval?
        public private(set) var delay: TimeInterval?
        public private(set) var options: UIView.AnimationOptions?
        public private(set) var animations: (() -> ())?
        public private(set) var completion: ((Bool) -> ())?
        public private(set) var commitCalled = false
        
        public override func duration(_ duration: TimeInterval) -> Self {
            self.duration = duration
            return self
        }
        
        public override func delay(_ delay: TimeInterval) -> Self {
            self.delay = delay
            return self
        }
        
        public override func options(_ options: UIView.AnimationOptions) -> Self {
            self.options = options
            return self
        }
        
        public override func animations(_ animations: @escaping () -> ()) -> Self {
            self.animations = animations
            return self
        }
        
        public override func completion(_ completion: @escaping (Bool) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public override func commit() {
            commitCalled = true
        }
        
    }
    
}
