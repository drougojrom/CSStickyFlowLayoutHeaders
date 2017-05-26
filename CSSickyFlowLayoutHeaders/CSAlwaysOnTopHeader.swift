//
//  CSAlwaysOnTopHeader.swift
//  CSSickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import CSStickyHeaderFlowLayout

class CSAlwaysOnTopHeader: CSCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func apply(_ layoutAttributes: CSStickyHeaderFlowLayoutAttributes) {
        
        UIView.beginAnimations("", context: nil)
        
        if (layoutAttributes.progressiveness <= 0.58) {
            self.titleLabel.alpha = 1;
        } else {
            self.titleLabel.alpha = 0;
        }
        
        if (layoutAttributes.progressiveness >= 1) {
            self.searchBar.alpha = 1;
        } else {
            self.searchBar.alpha = 0;
        }
        
        UIView.commitAnimations()
    }

}
