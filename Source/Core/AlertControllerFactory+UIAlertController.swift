//
//  AlertControllerFactory+UIAlertController.swift
//  AwesomeUtilities
//
//  Created by Luciano Polit on 1/26/24.
//

import Foundation
import UIKit

extension AlertControllerFactory {
    
    open func create() -> UIBuilder {
        UIBuilder()
    }
    
    open class UIBuilder: Builder<UIAlertController> {
        
        public private(set) var preferredStyle: UIAlertController.Style = .alert
        
        open func preferredStyle(
            _ preferredStyle: UIAlertController.Style
        ) -> Self {
            self.preferredStyle = preferredStyle
            return self
        }
        
        open func build() -> UIAlertController {
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle
            )
            configurations.forEach {
                $0(alertController)
            }
            return alertController
        }
        
    }
    
}

extension AlertControllerFactory.UIBuilder {
    
    @discardableResult
    public func present(
        from viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> ())? = nil
    ) -> UIAlertController {
        let alertController = build()
        viewController.present(
            alertController,
            animated: animated,
            completion: completion
        )
        return alertController
    }
    
}

extension UIAlertController: CanAddAlertAction, CanAddTextField { }
