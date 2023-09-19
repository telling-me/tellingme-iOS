//
//  MetaManager.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/03.
//

import UIKit

final class MetaManager {
    func shareInstagram(sharingView: UIView, scaleOf scale: CGFloat = 4.0) {
        let instagramURL = authenticateForMeta()
        
        if isInstagramInstalled() != false {
            guard let imageData = sharingView.saveUIViewWithScale(with: scale) else { return }
            
            let pasteboardItems: [String: Any] = [
                "com.instagram.sharedSticker.stickerImage": imageData,
                "com.instagram.sharedSticker.backgroundTopColor" : "#F9F9F9",
                "com.instagram.sharedSticker.backgroundBottomColor" : "#F6F6F6"
            ]
            let pasteboardOptions = [
                UIPasteboard.OptionsKey.expirationDate : Date().addingTimeInterval(300)
            ]
            
            UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        } else {
            guard let instagramURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252") else {
                return
            }
            return UIApplication.shared.open(instagramURL)
        }
    }
    
    func shareInstagramWithActivityViewController(sharingView: UIView, scaleOf scale: CGFloat = 4.0) -> UIImage {
        let renderedImage = renderImage(from: sharingView, scaleOf: scale)
        return renderedImage
    }
    
    func saveImage(from view: UIView, scaleOf scale: CGFloat = 4.0) -> UIImage {
        let renderedImageToSave = renderImage(from: view, scaleOf: scale)
        return renderedImageToSave
    }
}

extension MetaManager {
    private func isInstagramInstalled() -> Bool {
        guard let instagramURL = URL(string: "instagram-stories://share") else {
            return false
        }
        return UIApplication.shared.canOpenURL(instagramURL)
    }
    
    private func authenticateForMeta() -> URL {
        let metaKey = Bundle.main.metaShareKey
        guard let instagramURL = URL(string: "instagram-stories://share?source_application=" + "\(metaKey)") else { return URL(string: "")! }
        return instagramURL
    }
    
    private func renderImage(from view: UIView, scaleOf scale: CGFloat = 4.0) -> UIImage {
        guard let imageData = view.saveUIViewWithScale(with: scale) else { return UIImage() }
        guard let renderedImage = UIImage(data: imageData) else { return UIImage() }
        return renderedImage
    }
}
