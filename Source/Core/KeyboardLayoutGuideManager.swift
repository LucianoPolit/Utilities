//
//  KeyboardLayoutGuideManager.swift
//
//  Created by Luciano Polit on 3/17/18.
//

import Foundation
import UIKit

public class KeyboardLayoutGuideManager {
    
    public var notificationCenter = NotificationCenter.default
    public let view: UIView = UIView()
    fileprivate var bottom: NSLayoutConstraint
    
    public init(view superview: UIView) {
        let left = NSLayoutConstraint(item: view,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: superview,
                                      attribute: .left,
                                      multiplier: 1,
                                      constant: 0)
        let right = NSLayoutConstraint(item: view,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: .right,
                                       multiplier: 1,
                                       constant: 0)
        let height = NSLayoutConstraint(item: view,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 0)
        bottom = NSLayoutConstraint(item: view,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .bottom,
                                    multiplier: 1,
                                    constant: 0)
        superview.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([left, right, height, bottom])
    }
    
    public func registerObservers() {
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutGuideManager.keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutGuideManager.keyboardWillHide(_:)),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutGuideManager.keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    public func unregisterObservers() {
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
}

private extension KeyboardLayoutGuideManager {
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        update(using: notification)
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        update(using: notification)
    }
    
    @objc
    func keyboardWillChangeFrame(_ notification: Notification) {
        update(using: notification)
    }
    
}

private extension KeyboardLayoutGuideManager {
    
    func update(using notification: Notification) {
        guard let superview = view.superview,
            let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject?,
            let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let convertedAnimationCurve = UIView.AnimationOptions(rawValue: animationCurve.uintValue)
        let convertedKeyboardFrame = superview.convert(keyboardEndFrame.cgRectValue, from: UIApplication.shared.keyWindow)
        let keyboardTopOffset = superview.bounds.maxY - convertedKeyboardFrame.minY
        bottom.constant = -keyboardTopOffset
        
        let animations = {
            superview.setNeedsLayout()
            superview.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: animationDuration.doubleValue,
                       delay: 0,
                       options: [.beginFromCurrentState, convertedAnimationCurve],
                       animations: animations,
                       completion: nil)
    }
    
}
