//
// Created by Shaban Kamel on 13/02/2020.
// Copyright (c) 2020 sha. All rights reserved.
//

import UIKit

protocol NibDefinable {
    func nibName() -> String
}

extension NibDefinable {
    func nibName() -> String {
        String(describing: type(of: self))
    }
}

@IBDesignable
open class NibView: UIView, NibDefinable {

    @IBOutlet public weak var view: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clear

        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }

}