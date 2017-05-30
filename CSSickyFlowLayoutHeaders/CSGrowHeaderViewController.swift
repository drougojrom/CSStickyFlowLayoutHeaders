//
//  CSGrowHeaderViewController.swift
//  CSStickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CSGrowHeaderViewController: UICollectionViewController {

    let sections: Dictionary<String, String> = ["Twitter":"http://twitter.com",
                                                "Facebook":"http://facebook.com",
                                                "Tumblr":"http://tumblr.com",
                                                "Pinterest":"http://pinterest.com",
                                                "Instagram":"http://instagram.com",
                                                "Github":"http://github.com"]
    
    
    private var layout : CSStickyHeaderFlowLayout? {
        return self.collectionView?.collectionViewLayout as? CSStickyHeaderFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout?.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 200)

        let headerNib = UINib(nibName: "CSGrowHeader", bundle: nil)
        
        self.collectionView?.register(headerNib, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "header")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CSCell
        let obj = Array(self.sections)[indexPath.section]
        cell.textLabel?.text = obj.value
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == CSStickyHeaderParallaxHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return cell
        } else if kind == UICollectionElementKindSectionHeader {
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! CSSectionHeader
            let obj = Array(self.sections)[indexPath.section]
            cell.text?.text = obj.key
            return cell
        }
        
        return UICollectionReusableView()
    }

}
