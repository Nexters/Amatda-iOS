//
//  AMMainHeaderLayout.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 08/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

protocol AMMainHeaderDelegate {
    func recognizeHeaderContentOffset( _ : AMMainHeaderLayout, contentOffSetY : CGFloat)
}

class AMMainHeaderLayout: UICollectionViewFlowLayout {
    // we want to modify the attributes of ur header component somehow
    var delegate : AMMainHeaderDelegate?
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader &&
                attributes.indexPath.section == 0{
                
                guard let collectionView = collectionView else { return }
                let contentOffsetY =  collectionView.contentOffset.y
                
                if let delegate = delegate{
                    delegate.recognizeHeaderContentOffset(self, contentOffSetY: contentOffsetY)
                }
                
                if(contentOffsetY > 0){
                    return
                }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY
                
                //header
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
