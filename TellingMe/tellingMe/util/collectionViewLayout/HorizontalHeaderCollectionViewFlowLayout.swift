//
//  HorizontalHeaderCollectionViewFlowLayout.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import Foundation
import UIKit

class HorizontalHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in originalAttributes {
            allAttributes.append(attributes.copy() as! UICollectionViewLayoutAttributes)
        }

        for attributes in allAttributes {
            if let kind = attributes.representedElementKind,
               kind == UICollectionView.elementKindSectionHeader {
                
                var frame = attributes.frame
                if let cellAttrs = super.layoutAttributesForItem(at: attributes.indexPath) {
                    frame.origin.x = frame.origin.x
                    frame.size.height = sectionInset.top
                    frame.size.width = cellAttrs.frame.size.width
                    attributes.frame = frame
                }
            }
        }

        return allAttributes
    }
}
