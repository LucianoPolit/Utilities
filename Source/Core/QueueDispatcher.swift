//
//  QueueDispatcher.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation

public class QueueDispatcher {
    
    public var queue: DispatchQueue = .main
    
    public func sync(execute block: () -> ()) {
        queue.sync(execute: block)
    }
    
    public func async(after deadline: DispatchTime = .now(),
                      execute block: @escaping () -> ()) {
        queue.asyncAfter(deadline: deadline, execute: block)
    }
    
}
