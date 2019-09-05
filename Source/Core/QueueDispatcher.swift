//
//  QueueDispatcher.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation

open class QueueDispatcher {
    
    public let queue: DispatchQueue
    
    public init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
    open func sync(execute block: () -> ()) {
        queue.sync(execute: block)
    }
    
    open func async(after deadline: DispatchTime = .now(),
                      execute block: @escaping () -> ()) {
        queue.asyncAfter(deadline: deadline, execute: block)
    }
    
}
