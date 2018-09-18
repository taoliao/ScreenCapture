//
//  CaptureImageViewController.swift
//  ScreenCapture
//
//  Created by corepress on 2018/9/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pan: UIPanGestureRecognizer!
    var starA = CGPoint.zero
    var darkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        print(self.view.bounds.size.width,self.view.bounds.size.height)
        print(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height)
    }

    @IBAction func pan(_ sender: Any) {

        if pan.state == .began {
            
            starA = pan.location(in: view)
            
        }else if pan.state == .changed {
            
            let endA = pan.location(in: view)
            let x = starA.x
            let y = starA.y
            let width = endA.x - x
            let height = endA.y - y
            let frame = CGRect(x: x, y: y, width: width, height: height)
            self.darkView.frame = frame
            self.darkView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            view.addSubview(self.darkView)
          
            
        }else if pan.state == .ended {
            
            var navigationH : CGFloat = 0.0;
            
            if UIScreen.main.bounds.height >= 812 {
                navigationH = 88.0
            }else {
                navigationH = 64.0
            }
            
            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 1.0)
        
            //设置裁剪区域
            let rect = CGRect(x: self.darkView.frame.origin.x, y: self.darkView.frame.origin.y-navigationH, width: self.darkView.frame.size.width, height: self.darkView.frame.size.height)
            let path = UIBezierPath.init(rect: rect)
            path.addClip()
            
            let ctx = UIGraphicsGetCurrentContext()
            
             //把控件的内容渲染要上下文
            self.imageView.layer.render(in: ctx!)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            self.imageView.image = image
            
            UIGraphicsEndImageContext()
            
            self.darkView.removeFromSuperview()
        }
        

    }
    
}
