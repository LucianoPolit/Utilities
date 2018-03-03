//
//  TimerFactory.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation

public class TimerFactory {
    
    public func create() -> Builder {
        return Builder()
    }
    
    public class Builder {
        
        private var timeInterval: TimeInterval?
        private var repeats: Bool = false
        private var completion: ((Timer) -> ())?
        
        public func timeInterval(_ timeInterval: TimeInterval) -> Self {
            self.timeInterval = timeInterval
            return self
        }
        
        public func repeats(_ repeats: Bool) -> Self {
            self.repeats = repeats
            return self
        }
        
        public func completion(_ completion: @escaping (Timer) -> ()) -> Self {
            self.completion = completion
            return self
        }
        
        public func build() -> Timer {
            guard let timeInterval = timeInterval, let completion = completion
                else { fatalError("Utilities -> TimerFactory -> Incomplete building") }
            let timerHandler = TimerHandler(completion: completion)
            return .scheduledTimer(timeInterval: timeInterval,
                                   target: timerHandler,
                                   selector: #selector(TimerHandler.handler),
                                   userInfo: nil,
                                   repeats: repeats)
        }
        
    }
    
}

private class TimerHandler {
    
    let completion: (Timer) -> ()
    
    init(completion: @escaping (Timer) -> ()) {
        self.completion = completion
    }
    
    @objc
    func handler(_ timer: Timer) {
        completion(timer)
    }
    
}
