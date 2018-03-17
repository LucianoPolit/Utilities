//
//  ViewController.swift
//  Example
//
//  Created by Luciano Polit on 3/5/18.
//  Copyright © 2018 Luciano Polit. All rights reserved.
//

import UIKit
import AwesomeUtilities

class ViewController: AwesomeUtilities.ViewController {

    var keyboardLayoutGuideView: UIView {
        return keyboardLayoutGuideManager.view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardLayoutGuideManager.registerObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardLayoutGuideManager.unregisterObservers()
    }

}
