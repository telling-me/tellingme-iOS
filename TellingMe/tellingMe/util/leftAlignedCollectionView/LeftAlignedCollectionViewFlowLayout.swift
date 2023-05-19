//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 19.05.23.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.compactMap({ $0.copy() as? UICollectionViewLayoutAttributes }) else {
            return nil
        }

        var leftMargin: CGFloat = 0.0
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {
            guard layoutAttribute.representedElementCategory == .cell else {
                continue
            }

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = 0.0
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}
