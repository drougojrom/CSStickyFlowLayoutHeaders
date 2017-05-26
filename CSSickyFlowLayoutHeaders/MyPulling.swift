//
//  MyPulling.swift
//  CSSickyFlowLayoutHeaders
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class MyPulling: UIView {

    var scrollView: UIScrollView!
    var label: UILabel!
    var originalInsets: UIEdgeInsets!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 54))
        label.text = "pulling"
        
        self.addSubview(label)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        var frame = self.frame
        frame.origin.x = -54
        self.frame = frame
        
        scrollView = newSuperview as! UIScrollView
        scrollView.alwaysBounceVertical = true
        originalInsets = scrollView.contentInset
        
        let options: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old]
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: options, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        
        if keyPath == "contentOffset" {
            self.scrollViewContentOffsetDidChange(change!)
        }
    }
    
    func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]) {
        label.text = NSString.localizedStringWithFormat("%f", scrollView.contentOffset.y) as String
        
        if(scrollView.contentOffset.y >= -100){
            return;
        }
        
        if(scrollView.isDragging){
            return;
        }
        
        self.refresh()
    }
    
    func refresh() {
        
        UIView.animate(withDuration: 0.3, animations: {
            var inset = self.scrollView.contentInset
            inset.top = self.originalInsets.top + self.frame.size.height
            self.scrollView.contentInset = inset
        }, completion: { (finished) in
            
            let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC)))
            
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.scrollView.contentInset = self.originalInsets
                }, completion: nil)
            }

        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}
