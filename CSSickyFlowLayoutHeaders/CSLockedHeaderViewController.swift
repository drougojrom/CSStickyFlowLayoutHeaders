//
//  CSLockedHeaderViewController.swift
//  CSStickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CSLockedHeaderViewController: UICollectionViewController {

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
        
        let headerNib = UINib(nibName: "CSSearchBarHeader", bundle: nil)
        self.collectionView?.register(headerNib, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "header")
        self.layout?.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 40)

        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0)
        
    }
    
    func add() {
        
        self.collectionView?.performBatchUpdates({ 
            let new: Dictionary<String, String> = ["Twitter":"http://twitter.com",
                                                           "Facebook":"http://facebook.com",
                                                           "Tumblr":"http://tumblr.com",
                                                           "Pinterest":"http://pinterest.com",
                                                           "Instagram":"http://instagram.com",
                                                           "Github":"http://github.com"]
            
            //self.sections = new
            let set = NSMutableIndexSet()
            let indexPaths = NSMutableArray(array: [])
            
            let startIndex = 0
            
            for (index, value) in new.enumerated() {
                let indexPath = IndexPath(item: 0, section: index + startIndex)
                indexPaths.add(indexPath)
                set.add(startIndex + index)
            }
            self.collectionView?.insertSections(set as IndexSet)
            self.collectionView?.insertItems(at: indexPaths as! [IndexPath])
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        } else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! CSSectionHeader
            let obj = Array(self.sections)[indexPath.section]
            cell.text?.text = obj.key
            return cell
        }
    }
}
