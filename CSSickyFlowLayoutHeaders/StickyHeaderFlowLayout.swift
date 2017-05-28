//
//  StickyHeaderFlowLayout.swift
//  CSStickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class StickyHeaderFlowLayout : UICollectionViewFlowLayout {
    
    var parallaxHeaderReferenceSize: CGSize!
    var parallaxHeaderMinimumReferenceSize: CGSize!
    var parallaxHeaderAlwaysOnTop: Bool!
    var disableStickyHeaders: Bool!
    var disableStretching: Bool!
    
    static let CSStickyHeaderParallaxHeader = "CSStickyHeaderParallexHeader"
    
    static let kHeaderZIndex: NSInteger = 1024;
    
    
}
