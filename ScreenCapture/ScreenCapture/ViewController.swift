//
//  ViewController.swift
//  ScreenCapture
//
//  Created by corepress on 2018/9/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBAction func captureSrceen(_ sender: Any) {
        
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        
        //获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        //将layer渲染到上下文
        view.window?.layer.render(in: ctx!)
        
        //获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        let data = image?.jpegData(compressionQuality: 1.0)
        
        (data! as NSData).write(toFile: "/Users/corepress/Desktop/TLTestLable/TLTestLable/view.jpg", atomically: true)
        
        
    }
    
}

