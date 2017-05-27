//
//  CSParallaxHeaderViewController.swift
//  CSStickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import CSStickyHeaderFlowLayout

private let reuseIdentifier = "Cell"

class CSParallaxHeaderViewController: UICollectionViewController {
    
    let sections: Array<Dictionary<String, String>> = [["Twitter":"http://twitter.com",
                                                "Facebook":"http://facebook.com",
                                                "Tumblr":"http://tumblr.com",
                                                "Pinterest":"http://pinterest.com",
                                                "Instagram":"http://instagram.com",
                                                "Github":"http://github.com"]]
    
    private var layout : CSStickyHeaderFlowLayout? {
        return self.collectionView?.collectionViewLayout as? CSStickyHeaderFlowLayout
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        let headerNib = UINib(nibName: "CSParallaxHeader", bundle: nil)
        self.collectionView?.register(headerNib, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "header")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reloadButtonDidPress(sender: AnyObject) {
        let indexSet = NSIndexSet(indexesIn: NSMakeRange(0, (self.collectionView!.numberOfSections)))
        self.collectionView?.reloadSections(indexSet as IndexSet)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
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
            cell.textLabel.text = obj.keys.first
            return cell
        }
    }
}

