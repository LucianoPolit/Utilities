//
//  CompletionExecutor.swift
//
//  Created by Luciano Polit on 3/5/18.
//

import Foundation

public class CompletionExecutor<T> {
    
    private var sender: T
    private var completion: ((T) -> ())?
    
    public init(sender: T, completion: ((T) -> ())?) {
        self.sender = sender
        self.completion = completion
    }
    
    public func execute() {
        completion?(sender)
    }
    
}
