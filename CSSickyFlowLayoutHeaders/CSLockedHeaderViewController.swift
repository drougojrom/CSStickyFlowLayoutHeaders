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

    var sections: Array<Dictionary<String, String>> = [["":""]]
    
    private var layout : CSStickyHeaderFlowLayout? {
        return self.collectionView?.collectionViewLayout as? CSStickyHeaderFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: "CSSearchBarHeader", bundle: nil)
        self.collectionView?.register(headerNib, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "header")
        self.layout?.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 100)

        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0)
        let add = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(self.add))
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = add
        self.add()
    }
    
    func add() {
        
        self.collectionView?.performBatchUpdates({ 
            let new: Array<Dictionary<String, String>> = [["Twitter":"http://twitter.com",
                                                           "Facebook":"http://facebook.com",
                                                           "Tumblr":"http://tumblr.com",
                                                           "Pinterest":"http://pinterest.com",
                                                           "Instagram":"http://instagram.com",
                                                           "Github":"http://github.com"]]
            
            self.sections = new
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
        let obj = self.sections[indexPath.section]
        
        cell.textLabel.text = obj.values.first
    
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == CSStickyHeaderParallaxHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return cell
        } else {
            let obj = self.sections[indexPath.section]
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! CSSectionHeader
            //cell.textLabel.text = obj.keys.first
            return cell
        }
    }
}
