//
//  AboutViewController.swift
//  swift a game
//
//  Created by 张宏毅 on 15/2/11.
//  Copyright (c) 2015年 zhy. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController
{
    @IBOutlet weak var webView: UIWebView!
    @IBAction func close()
    {
        dismissViewControllerAnimated(true,completion: nil);
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html"){
            let htmlData = NSData(contentsOfFile: htmlFile)
            let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }
    
}
