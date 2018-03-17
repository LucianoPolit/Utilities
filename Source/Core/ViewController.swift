//
//  ViewController.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation
import UIKit

open class ViewController: UIViewController {
    
    public lazy var alertControllerFactory = AlertControllerFactory()
    public lazy var queueDispatcher = QueueDispatcher()
    public lazy var timerFactory = TimerFactory()
    public lazy var viewAnimator = ViewAnimator()
    public lazy var keyboardLayoutGuideManager = { [unowned self] in
        return KeyboardLayoutGuideManager(view: self.view)
    }()
    
}
