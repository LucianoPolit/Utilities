//
//  MockTimerFactory.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import AwesomeUtilities

public class MockTimerFactory: TimerFactory {
    
    public private(set) var builders: [MockBuilder] = []
    public var completionExecutors: [CompletionExecutor<Timer>] {
        return builders.compactMap { $0.completionExecutor }
    }
    
    public override func create() -> Builder {
        let builder = MockBuilder()
        builders.append(builder)
        return builder
    }
    
    public class MockBuilder: Builder {
        
        public private(set) var timeInterval: TimeInterval?
        public private(set) var repeats: Bool?
        public private(set) var completion: ((Timer) -> ())?
        public private(set) var timer: Timer?
        public private(set) var completionExecutor: CompletionExecutor<Timer>?
        
        public override func timeInterval(_ timeInterval: TimeInterval) -> Self {
            self.timeInterval = timeInterval
            return self
        }
        
        public override func repeats(_ repeats: Bool) -> Self {
            self.repeats = repeats
            return self
        }
        
        public override func completion(_ completion: @escaping (Timer) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public override func build() -> Timer {
            timer = super.build()
            completionExecutor = CompletionExecutor(sender: timer!, completion: completion)
            return timer!
        }
        
    }
    
}
