//Copyright HitchHiker© 2017. All rights reserved.

import UIKit

public final class KeyboardManager {
    let scrollView: UIScrollView

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        registerToKeyboardNotifications()
    }

    deinit {
        deregisterFromKeyboardNotifications()
    }
}

// MARK: - Actions
extension KeyboardManager {
    @IBAction fileprivate func keyboardWillShow(_ notification: NSNotification) {
        adjustingHeight(notification, show: true)
    }

    @IBAction fileprivate func keyboardWillDisappear(_ notification: NSNotification) {
        adjustingHeight(notification, show: false)
    }

    fileprivate func adjustingHeight(_ notification: NSNotification, show: Bool) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: animationDuration) {
            let contentBottomInset = !show ? 0 : keyboardFrame.height + 75
            let scrollIndicatorBottomInset = !show ? 0 : keyboardFrame.height
            self.scrollView.contentInset.bottom = contentBottomInset
            self.scrollView.scrollIndicatorInsets.bottom = scrollIndicatorBottomInset
        }
    }
}

// MARK: - Private methods
extension KeyboardManager {
    fileprivate func registerToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    fileprivate func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
