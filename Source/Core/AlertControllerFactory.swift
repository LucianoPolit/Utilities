//
//  AlertControllerFactory.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation
import UIKit

public protocol AlertController: class {
    func addAction(_ action: UIAlertAction)
    func addTextField(configurationHandler: ((UITextField) -> ())?)
    init(title: String?, message: String?, preferredStyle: UIAlertController.Style)
}

public class AlertControllerFactory {
    
    public init() { }
    
    public func create<T: AlertController>(type: T.Type = T.self) -> Builder<T> {
        return Builder()
    }
    
    public class Builder<T: AlertController> {
        
        private var title: String?
        private var message: String?
        private var preferredStyle: UIAlertController.Style = .alert
        private var actions: [UIAlertAction] = []
        private var textFieldConfigurations: [(UITextField) -> ()] = []
        private var customConfiguration: ((T) -> ())?
        
        public func title(_ title: String) -> Self {
            self.title = title
            return self
        }
        
        public func message(_ message: String) -> Self {
            self.message = message
            return self
        }
        
        public func preferredStyle(_ preferredStyle: UIAlertController.Style) -> Self {
            self.preferredStyle = preferredStyle
            return self
        }
        
        public func addAction(title: String?,
                              style: UIAlertAction.Style,
                              handler: ((UIAlertAction) -> ())? = nil) -> Self {
            let action = UIAlertAction(title: title, style: style, handler: handler)
            actions.append(action)
            return self
        }
        
        public func addTextField(_ configuration: @escaping (UITextField) -> () = { _ in }) -> Self {
            textFieldConfigurations.append(configuration)
            return self
        }
        
        public func configure(_ configuration: @escaping (T) -> ()) -> Self {
            customConfiguration = configuration
            return self
        }
        
        public func build() -> T {
            let alertController = T(title: title,
                                    message: message,
                                    preferredStyle: preferredStyle)
            actions.forEach {
                alertController.addAction($0)
            }
            textFieldConfigurations.forEach {
                alertController.addTextField(configurationHandler: $0)
            }
            customConfiguration?(alertController)
            return alertController
        }
        
    }
    
}

extension UIAlertController: AlertController { }

extension AlertControllerFactory {
    
    public func create() -> Builder<UIAlertController> {
        return create(type: UIAlertController.self)
    }
    
}

extension AlertControllerFactory.Builder where T: UIViewController {
    
    @discardableResult
    public func present(from viewController: UIViewController,
                        animated: Bool = true,
                        completion: (() -> ())? = nil) -> T {
        let alertController = build()
        viewController.present(alertController,
                               animated: animated,
                               completion: completion)
        return alertController
    }
    
}
