//
//  FirstViewController.swift
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var view_:UIView? = UIView(frame: CGRectMake(5, 50, 300, 40));
        self.view.addSubview(view_!);
        
        ShowEmojiView.showEmojiText("f01f02f01f02f01f02f01f02f01f02f01f02f01f02f01f02",
            font:UIFont(name:"Helvetica", size: 13),
            superView:view_);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

