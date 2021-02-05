//
//  Created by prog_zidane on 11/24/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

public class InputDialog: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var tf: UITextField!
    @IBOutlet var btnCancel: DesignableButton!
    @IBOutlet var btnSubmit: DesignableButton!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet private weak var dismissButton: UIButton!

    var info: Info!

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        lblTitle.text = info.title
        lblSubtitle.text = info.subtitle
        lblSubtitle.isHidden = info.subtitle == nil
        tf.text = info.text
        tf.placeholder = info.placeholder
        tf.delegate = self
        btnSubmit.setTitle(info.submitTitle ?? "Submit".localized, for: .normal)
        btnCancel.setTitle(info.cancelTitle ?? "Cancel".localized, for: .normal)
        btnCancel.isHidden = !info.isCancelable
        self.dismissButton.addTapGestureRecognizer { [weak self] in
            self?.dismiss(animated: false, completion: nil)
            self?.navigationController?.popViewController(animated: false)
        }
        
    }

    // TODO: encapsulate in extension
    private func addTextFieldBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: tf.frame.origin.x, y: tf.frame.height - 1, width: tf.bounds.width, height: 0.3)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        tf.borderStyle = .none
        tf.layer.addSublayer(bottomLine)
    }

    @IBAction func submit(_ sender: Any) {
        guard let onValidate = info.onValidate else {
            submit()
            return
        }
        guard let error = onValidate(tf.text ?? "") else {
            submit()
            return
        }
        NotifiyMessage.shared.toast(toastMessage: error)
    }

    private func submit() {
        info.onSubmit?(tf.text ?? "")
        dismiss(animated: false)
        navigationController?.popViewController(animated: false)
        
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false)
        navigationController?.popViewController(animated: false)
    }

    public func show() {
        modalPresentationStyle = .overCurrentContext
        UIApplication.getTopViewController()?.present(self, animated: false, completion: nil)
    }

    
}

extension InputDialog {
    class Info {
        var title: String? = nil
        var text: String? = nil
        var subtitle: String? = nil
        var placeholder: String? = nil
        var cancelTitle: String? = nil
        var submitTitle: String? = nil
        var isCancelable = true
        var onSubmit: ((String) -> Void)? = nil
        var onValidate: ((String) -> String?)? = nil
        var maxInputChars : Int? = nil
    }

    class Builder {
        let info = Info()

        func title(_ value: String) -> Builder {
            info.title = value
            return self
        }

        func subtitle(_ value: String) -> Builder {
            info.subtitle = value
            return self
        }

        func placeholder(_ value: String) -> Builder {
            info.placeholder = value
            return self
        }

        func cancelTitle(_ value: String) -> Builder {
            info.cancelTitle = value
            return self
        }

        func submitTitle(_ value: String) -> Builder {
            info.submitTitle = value
            return self
        }

        func isCancelable(_ value: Bool) -> Builder {
            info.isCancelable = value
            return self
        }

        func onSubmit(_ value: @escaping (String) -> Void) -> Builder {
            info.onSubmit = value
            return self
        }

        func onValidate(_ value: @escaping (String) -> String?) -> Builder {
            info.onValidate = value
            return self
        }

        func text(_ value: String) -> Builder {
            info.text = value
            return self
        }
        
        func maxInputChars(_ value: Int) -> Builder {
            info.maxInputChars = value
            return self
        }

        func show() {
            let vc = InputDialog.instantiate(storyboard: .inputDialog)
            vc.info = info
            vc.show()
        }
    }
}

extension InputDialog: UITextFieldDelegate{
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
    
        guard textField == tf else {
            return true
        }

        guard let maxLength = info.maxInputChars else {
            return true
        }

        guard let currentString: NSString = tf.text as NSString? else {
            return true
        }
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString

        guard newString.length <= maxLength else {
            NotifiyMessage.shared.toast(toastMessage: "Maximum character is".localized + " \(maxLength) ",position: .top)
            return false
        }

        return true
    }
}
