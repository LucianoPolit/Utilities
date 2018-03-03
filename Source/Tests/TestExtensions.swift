//
//  TestExtensions.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import UIKit

extension ViewController {
    
    public var mockViewAnimator: MockViewAnimator {
        return viewAnimator as! MockViewAnimator
    }
    public var mockQueueDispatcher: MockQueueDispatcher {
        return queueDispatcher as! MockQueueDispatcher
    }
    public var mockTimerFactory: MockTimerFactory {
        return timerFactory as! MockTimerFactory
    }
    public var mockAlertControllerFactory: MockAlertControllerFactory {
        return alertControllerFactory as! MockAlertControllerFactory
    }
    public var mockGestureRecognizerFactory: MockGestureRecognizerFactory {
        return gestureRecognizerFactory as! MockGestureRecognizerFactory
    }
    
    public func mockUtilities() {
        viewAnimator = MockViewAnimator()
        queueDispatcher = MockQueueDispatcher()
        timerFactory = MockTimerFactory()
        alertControllerFactory = MockAlertControllerFactory()
        gestureRecognizerFactory = MockGestureRecognizerFactory()
    }
    
}

extension UIView {
    
    public func find<T: UIView>(type: T.Type = T.self) -> [T] {
        var views: [T] = []
        
        subviews.forEach {
            if let view = $0 as? T {
                views.append(view)
            }
            views.append(contentsOf: $0.find() as [T])
        }
        
        return views
    }
    
    public func findFirst<T: UIView>(type: T.Type = T.self) -> T? {
        return find().first
    }
    
}
