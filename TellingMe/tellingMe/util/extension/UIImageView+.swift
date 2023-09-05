//
//  UIImageView+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        let cacheManager = ImageCacheManager.shared
        let imageKey = NSString(string: url)
        guard let imageURL = URL(string: url) else { return }
        if let cachedImage = cacheManager.object(forKey: imageKey) {
            self.image = cachedImage
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            cacheManager.setObject(image, forKey: imageKey)
                        }
                    } else {
                        self?.image = UIImage(named: "Happy")
                    }
                }
            }
        }
    }
}
