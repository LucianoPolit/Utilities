//
//  KeyboardLayoutManager.swift
//
//  Created by Luciano Polit on 3/17/18.
//

import Foundation
import UIKit

public class KeyboardLayoutManager {
    
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
    
    public func viewWillAppear(_ animated: Bool) {
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutManager.keyboardWillShow(_:)),
                                       name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutManager.keyboardWillHide(_:)),
                                       name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardLayoutManager.keyboardWillShow(_:)),
                                       name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    public func viewWillDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
}

private extension KeyboardLayoutManager {
    
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

private extension KeyboardLayoutManager {
    
    func update(using notification: Notification) {
        guard let superview = view.superview,
            let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject?,
            let keyboardEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let convertedAnimationCurve = UIViewAnimationOptions(rawValue: animationCurve.uintValue)
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
