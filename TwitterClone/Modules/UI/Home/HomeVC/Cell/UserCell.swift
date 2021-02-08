//
//  UserCell.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import UIKit

class UserCell: ConfigurableCell<TwitterUser> {

    @IBOutlet weak var lbl_Bio: UILabel!
    @IBOutlet weak var lbl_Handle: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var img_Avatar: DesignableImageView!
    
    override func setup(item: TwitterUser) {
        lbl_Bio.text = item.userDescription
        lbl_Name.text = item.name
        lbl_Handle.text = "@\(item.screenName ?? "")"
        img_Avatar.nuke(url: item.profileImageURL)
        img_Avatar.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let avatar = item.profileImageURL, !avatar.isEmpty else {return}
            ZoomHelper.shared.zoomImagesPreview(images: [avatar], startWith: 0, captionText: item.userDescription ?? "", viewController: self.viewContainingController()!)
        }
    }
}
