//
//  UIImageView+Blur.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Nuke

public extension UIImageView
{
    func addBlurEffect(_ blurStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.center = self.center
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

public extension UIImageView
{
    convenience public init(assetName : String, scale : UIView.ContentMode = .scaleAspectFit)
    {
        self.init(image: UIImage(named: assetName))
        contentMode = scale
    }
    
    func nuke(url: String?, imagePlaceholder: UIImage? = nil, placeholder: String = "")
    {
        let options = ImageLoadingOptions(
            placeholder:  imagePlaceholder ?? UIImage(named: placeholder),
            transition: .fadeIn(duration: 0.5),
            contentModes: .init(
                success: .scaleAspectFill,
                failure: .scaleAspectFill,
                placeholder: .scaleAspectFill
            )
        )
        
        if let url = url, let imageURL = URL(string: url)
        {
            DispatchQueue.main.async {
               Nuke.loadImage(with: ImageRequest(url: imageURL),
                              options: options,
                              into: self,
                              progress: nil,
                              completion: nil)
            }
        }
    }
    
    func nuke(url: String?, imagePlaceholder: UIImage? = nil, placeholder: String = "",
              _ completion: @escaping(_ status: Bool) -> ())
    {
        let options = ImageLoadingOptions(
            placeholder:  imagePlaceholder ?? UIImage(named: placeholder),
            transition: .fadeIn(duration: 0.5),
            contentModes: .init(
                success: .scaleAspectFill,
                failure: .scaleAspectFill,
                placeholder: .scaleAspectFill
            )
        )
        
        if let url = url, let imageURL = URL(string: url)
        {
            DispatchQueue.main.async {
                Nuke.loadImage(with: ImageRequest(url: imageURL), options: options, into: self, progress: nil) { (result) in
                    switch result{
                    case .success:
                        completion(true)
                    case .failure:
                        completion(false)
                    }
                }
            }
        }
    }
}

