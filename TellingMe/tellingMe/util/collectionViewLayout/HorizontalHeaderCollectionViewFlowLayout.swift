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
                    // 헤더와 셀들을 같은 수평에 배치
                    frame.origin.y = cellAttrs.frame.origin.y
                    frame.size.width = 33
                    frame.size.height = 40
                    attributes.frame = frame
                }
            }
        }

        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        
        // 첫 번째 셀의 x좌표를 헤더의 너비와 간격만큼 더한 값으로 설정
        if indexPath.item > 0 {
            let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            if let previousAttributes = super.layoutAttributesForItem(at: previousIndexPath) {
                let x = previousAttributes.frame.origin.x + previousAttributes.frame.size.width + 24
                attributes?.frame.origin.x = x
            }
        } else if let headerAttributes = super.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
            let x = headerAttributes.frame.size.width + 24
            attributes?.frame.origin.x = x
        }

        return attributes
    }
}
