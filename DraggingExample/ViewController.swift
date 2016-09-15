//
//  ViewController.swift
//  DraggingExample
//
//  Created by Nadeem Ansari on 9/13/16.
//  Copyright © 2016 Nadeem Ansari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2, self.view.bounds.height / 2, 200, 100))
        
        label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        
        label.text = "Drag ME"
        
        label.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        
        label.addGestureRecognizer(gesture)
        
        label.userInteractionEnabled = true
    }

    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let transalation = gesture.translationInView(self.view)
        
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + transalation.x, y: self.view.bounds.height / 2 + transalation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100/abs(xFromCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if label.center.x < 100 {
                print("Rejected")
            }
            if label.center.x > self.view.bounds.width - 100 {
                print("Accepted")
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

