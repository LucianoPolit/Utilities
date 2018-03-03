//
//  MockQueueDispatcher.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation

public class MockQueueDispatcher: QueueDispatcher {
    
    public private(set) var asyncCalled = false
    public private(set) var asyncParameterDeadline: DispatchTime?
    public private(set) var asyncParameterBlock: (() -> ())?
    
    public override func async(after deadline: DispatchTime,
                               execute block: @escaping () -> ()) {
        asyncCalled = true
        asyncParameterDeadline = deadline
        asyncParameterBlock = block
    }
    
    public func reset() {
        asyncCalled = false
        asyncParameterDeadline = nil
        asyncParameterBlock = nil
    }
    
}
