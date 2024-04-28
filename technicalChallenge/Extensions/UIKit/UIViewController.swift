//
//  UIViewController.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import UIKit

// MARK: - Keyboard handling

extension UIViewController {
    
    // MARK: - Public
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Override in UIViewController subclasses to react to keyboard changes.
    /// This method will only be called if the view controller has been registered for keyboard notifications via `registerForKeyboardNotifications()`.
    /// The default implementation of this method does nothing.
    @objc func keyboardWillAppear(height: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions) {
    }
    
    /// Override in UIViewController subclasses to react to keyboard changes.
    /// This method will only be called if the view controller has been registered for keyboard notifications via `registerForKeyboardNotifications()`.
    /// The default implementation of this method does nothing.
    @objc func keyboardWillDisappear(duration: TimeInterval, options: UIView.AnimationOptions) {
    }
    
    // MARK: - Private
    
    @objc private func handleKeyboardNotification(notification: Notification) {
        guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve)
        let keyboardScreenEndFrame = keyboardEndFrame.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        switch notification.name {
        case UIResponder.keyboardWillHideNotification:
            keyboardWillDisappear(duration: animationDuration, options: animationOptions)
        case UIResponder.keyboardWillShowNotification:
            let keyboardHeight = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
            keyboardWillAppear(height: keyboardHeight, duration: animationDuration, options: animationOptions)
        default:
            break
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
