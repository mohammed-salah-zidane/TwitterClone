//
//  ZoomHelper.swift
//  AlaDerbi
//
//  Created by prog_zidane on 3/25/20.
//  Copyright © 2020 Fraag. All rights reserved.
//

import Foundation
import Lightbox
import UIKit
import Nuke
import Core

public class ZoomHelper{
    
    static public let shared = ZoomHelper()
    
    private init(){
        setUpPreviewImagesConfig()
    }
    
    
    public func zoomImagesPreview(images:[String]?,startWith indexPath :Int,captionText : String,viewController:UIViewController){
        
        // Create an array of images.
        var photos = [LightboxImage]()
        
        // photos.removeAll()
        images?.forEach({ (imageUrl) in
            let image = LightboxImage(imageURL: URL(string:imageUrl.trimmed)!,text: captionText)
            photos.append(image)
        })
        
    
        let previewController = LightboxController(images: photos,startIndex: indexPath)
        
        // Use dynamic background.
        previewController.dynamicBackground = true
        previewController.modalPresentationStyle = .fullScreen
        
        viewController.present(previewController, animated: true, completion: nil)
    }
    
    public func setUpPreviewImagesConfig(){
        LightboxConfig.InfoLabel.ellipsisText = "Show More".localized
        LightboxConfig.InfoLabel.ellipsisColor = Colors.primary.color
        LightboxConfig.CloseButton.text = "Close".localized
        LightboxConfig.loadImage = { imageView, url, completion in
            Nuke.loadImage(with: ImageRequest(url: url), options: ImageLoadingOptions(), into: imageView, progress: nil, completion: { (result) in
                switch result {
                case .success:
                    if let image = try? result.get() {
                        completion!(image.image)
                    }
                case .failure:
                    completion!(nil)
                    imageView.image = #imageLiteral(resourceName: "boxIcon")
                    break
                }
                
            })
        }
    }
    
    
}
