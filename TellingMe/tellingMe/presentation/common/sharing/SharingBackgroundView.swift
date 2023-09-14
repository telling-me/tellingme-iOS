//
//  SharingBackgroundView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/12.
//

import UIKit

import SnapKit
import Then

final class SharingBackgroundView: UIView {

    private var shadowView = UIView()
    private var addedView = UIImageView()
    private var stickerView = UIImageView()
    private var addingImage = UIImage()
    
    init(frame: CGRect, sharingImage: UIImage, signatureImage: UIImage?) {
        self.addedView.image = sharingImage
        self.addingImage = sharingImage
        self.stickerView.image = signatureImage
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SharingBackgroundView {
    
    private func setStyles() {
        addedView.contentMode = .scaleAspectFit
        stickerView.contentMode = .scaleAspectFit
    }
    
    private func setLayout() {
        self.addSubviews(shadowView, addedView, stickerView)
    }
}

extension SharingBackgroundView {
    func setInsetForImage() {
        addedView.contentMode = .scaleAspectFill
        addedView.image = addingImage.withInset(UIEdgeInsets(top: 160, left: 100, bottom: 160, right: 100))
    }
    
    func moveSignatureViewToCenter(image: UIImage?) {
        stickerView.image = image
    }
}
