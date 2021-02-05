//
//  InfoDialog.swift
//  Rakeb
//
//  Created by prog_zidane on 26/21/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

public class InfoDialog: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitleDescription: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var btnCancel: DesignableButton!
    @IBOutlet weak var btnSubmit: DesignableButton!

    var info: Info!

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        lblTitle.text = info.title
        lblTitle.font = UIFont.localizedFont(size: .size14, weight: .medium)
        
        lblSubtitle.text = info.subtitle
        lblSubtitle.isHidden = info.subtitle == nil
        lblSubtitle.font = UIFont.localizedFont(size: .size11, weight: .medium)

        lblDescription.text = info.description
        lblDescription.isHidden = info.description == nil
        lblDescription.font = UIFont.localizedFont(size: .size16, weight: .medium)

        lblTitleDescription.text = info.descriptionTitle
        lblTitleDescription.isHidden = info.descriptionTitle == nil
        lblTitleDescription.font = UIFont.localizedFont(size: .size48, weight: .bold)
        
        btnSubmit.setTitle(info.submitTitle ?? "Submit".localized, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.localizedFont(size: .size18, weight: .medium)
        btnCancel.setTitle(info.cancelTitle ?? "Cancel".localized, for: .normal)
        btnCancel.titleLabel?.font = UIFont.localizedFont(size: .size18, weight: .medium)
        btnCancel.isHidden = !info.isCancelable
        icon.image = info.icon
        icon.isHidden = info.icon == nil
    }

    @IBAction func submit(_ sender: Any) {
        submit()
    }

    private func submit() {
        info.onSubmit?()
        hide()
    }

    @IBAction func cancel(_ sender: Any) {
        hide()
    }

    
    public func hide() {
        dismiss(animated: false)
        navigationController?.popViewController(animated: false)
    }
    
    public func show() {
        modalPresentationStyle = .overCurrentContext
        UIApplication.getTopViewController()?.present(self, animated: false, completion: nil)
    }

    class Info {
        var title: String? = nil
        var text: String? = nil
        var subtitle: String? = nil
        var placeholder: String? = nil
        var cancelTitle: String? = nil
        var submitTitle: String? = nil
        var description: String? = nil
        var descriptionTitle: String? = nil
        var isCancelable = true
        var onSubmit: (() -> Void)? = nil
        var onCancel: (() -> Void)? = nil
        var icon: UIImage? = nil
    }

    class Builder {
        let info = Info()

        public func title(_ value: String) -> Builder {
            info.title = value
            return self
        }

        public func subtitle(_ value: String) -> Builder {
            info.subtitle = value
            return self
        }

        public func placeholder(_ value: String) -> Builder {
            info.placeholder = value
            return self
        }

        public func cancelTitle(_ value: String) -> Builder {
            info.cancelTitle = value
            return self
        }

        public func submitTitle(_ value: String) -> Builder {
            info.submitTitle = value
            return self
        }

        public func description(_ value: String) -> Builder {
            info.description = value
            return self
        }
        
        public func descriptionTitle(_ value: String) -> Builder {
            info.descriptionTitle = value
            return self
        }

        public func isCancelable(_ value: Bool) -> Builder {
            info.isCancelable = value
            return self
        }

        public func onSubmit(_ value: @escaping () -> Void) -> Builder {
            info.onSubmit = value
            return self
        }
        
        public func onCancel(_ value: @escaping () -> Void) -> Builder {
            info.onCancel = value
            return self
        }

        public func text(_ value: String) -> Builder {
            info.text = value
            return self
        }
        
        public func icon(_ value: UIImage) -> Builder {
            info.icon = value
            return self
        }

        public func show() {
            let vc = InfoDialog.instantiate(storyboard: .infoDialog)
            vc.info = info
            vc.show()
        }
    }
}
