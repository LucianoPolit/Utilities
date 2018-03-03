//
//  MockGestureRecognizerFactory.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import UIKit

public class MockGestureRecognizerFactory: GestureRecognizerFactory {
    
    public var builders: [MockBuilder<UIGestureRecognizer>] = []
    public var targetExecutors: [TargetExecutor<UIGestureRecognizer>] {
        return builders.flatMap { $0.targetExecutor }
    }
    
    public override func create<T: UIGestureRecognizer>(type: T.Type) -> Builder<T> {
        return MockBuilder()
    }
    
    public class MockBuilder<T: UIGestureRecognizer>: Builder<T> {
        
        public private(set) var configuration: ((T) -> ())?
        public private(set) var completion: ((T) -> ())?
        public private(set) var gestureRecognizer: T?
        public private(set) var targetExecutor: TargetExecutor<T>?
        
        public override func configure(_ block: @escaping (T) -> ()) -> Self {
            configuration = block
            return self
        }
        
        public override func completion(_ completion: @escaping (T) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public override func build() -> T {
            gestureRecognizer = super.build()
            targetExecutor = TargetExecutor(sender: gestureRecognizer!, completion: completion)
            return gestureRecognizer!
        }
        
    }
    
}
