//
//  CSParallaxHeaderViewController.swift
//  CSStickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CSParallaxHeaderViewController: UICollectionViewController {
    
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

        let headerNib = UINib(nibName: "CSParallaxHeader", bundle: nil)
        self.collectionView?.register(headerNib, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "header")
        
        self.layout?.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 100)

        
        self.collectionView?.register(UINib(nibName: "CSCell", bundle: nil), forCellWithReuseIdentifier: "cell")

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
        return self.sections.count
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
            cell.text?.text = obj.value
            return cell
        }
        
        return UICollectionReusableView()
    }
}

