//
//  HomeWritingButton.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

final class HomeWritingButton: BBaseButton {
    
    override func setStyles() {
        self.setImage(ImageLiterals.HomeWriteWingPen, for: .normal)
        self.setRoundShadowWith(backgroundColor: .Side100, shadowColor: .black, radius: 20, shadowRadius: 10, shadowOpacity: 0.1, xShadowOffset: 0, yShadowOffset: 4)
    }
}
