//
//  MockAlertControllerFactory.swift
//
//  Created by Luciano Polit on 3/4/18.
//

import Foundation
import UIKit

public class MockAlertControllerFactory: AlertControllerFactory {
    
    public override func create<T: AlertController>(type: T.Type) -> Builder<T> {
        return MockBuilder()
    }
    
    public class MockBuilder<T: AlertController>: Builder<T> {
        
        public private(set) var title: String?
        public private(set) var message: String?
        public private(set) var preferredStyle: UIAlertControllerStyle = .alert
        public private(set) var actions: [UIAlertAction] = []
        public private(set) var textFieldConfigurations: [(UITextField) -> ()] = []
        public private(set) var customConfiguration: ((T) -> ())?
        public private(set) var alertController: T?
        
        public override func title(_ title: String) -> Self {
            self.title = title
            return self
        }
        
        public override func message(_ message: String) -> Self {
            self.message = message
            return self
        }
        
        public override func preferredStyle(_ preferredStyle: UIAlertControllerStyle) -> Self {
            self.preferredStyle = preferredStyle
            return self
        }
        
        public override func addAction(title: String?,
                                       style: UIAlertActionStyle,
                                       handler: ((UIAlertAction) -> ())? = nil) -> Self {
            let action = UIAlertAction(title: title, style: style, handler: handler)
            actions.append(action)
            return self
        }
        
        public override func addTextField(_ configuration: @escaping (UITextField) -> () = { _ in }) -> Self {
            textFieldConfigurations.append(configuration)
            return self
        }
        
        public override func configure(_ configuration: @escaping (T) -> ()) -> Self {
            customConfiguration = configuration
            return self
        }
        
        public override func build() -> T {
            alertController = super.build()
            return alertController!
        }
        
    }
    
}
