//
//  AlertControllerFactory.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation

public protocol AlertController: class {
    
    init(
        title: String?,
        message: String?
    )
    
}

open class AlertControllerFactory {
    
    public init() { }
    
    open func create<T>(
        type: T.Type = T.self
    ) -> Builder<T> {
        Builder()
    }
    
    open class Builder<T> {
        
        public private(set) var title: String?
        public private(set) var message: String?
        public private(set) var configurations: [((T) -> ())] = []
        
        public init() { }
        
        open func title(
            _ title: String
        ) -> Self {
            self.title = title
            return self
        }
        
        open func message(
            _ message: String
        ) -> Self {
            self.message = message
            return self
        }
        
        open func configure(
            _ configuration: @escaping (T) -> ()
        ) -> Self {
            configurations.append(configuration)
            return self
        }
        
    }
    
}

extension AlertControllerFactory.Builder where T: AlertController {
    
    public func build() -> T {
        let alertController = T(
            title: title,
            message: message
        )
        configurations.forEach {
            $0(alertController)
        }
        return alertController
    }
    
}

extension AlertControllerFactory.Builder where T: AlertController & UIViewController {
    
    @discardableResult
    public func present(
        from viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> ())? = nil
    ) -> T {
        let alertController = build()
        viewController.present(
            alertController,
            animated: animated,
            completion: completion
        )
        return alertController
    }
    
}
