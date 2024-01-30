//
//  AlertControllerFactory+Utils.swift
//  AwesomeUtilities
//
//  Created by Luciano Polit on 1/26/24.
//

import Foundation
import UIKit

public protocol CanAddAlertAction {
    
    func addAction(
        _ action: UIAlertAction
    )
    
}

extension AlertControllerFactory.Builder where T: CanAddAlertAction {
    
    public func addAction(
        title: String?,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> ())? = nil
    ) -> Self {
        configure { alertController in
            alertController.addAction(
                UIAlertAction(
                    title: title,
                    style: style,
                    handler: handler
                )
            )
        }
    }
    
}

public protocol CanAddTextField {
    
    func addTextField(
        configurationHandler: ((UITextField) -> ())?
    )
    
}

extension AlertControllerFactory.Builder where T: CanAddTextField {
    
    public func addTextField(
        _ configuration: @escaping (UITextField) -> () = { _ in }
    ) -> Self {
        configure { alertController in
            alertController.addTextField(
                configurationHandler: configuration
            )
        }
    }
    
}
