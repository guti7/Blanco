//
//  AboutViewController.swift
//  Blanco
//
//  Created by Guti on 1/15/17.
//  Copyright © 2017 PielDeJaguar. All rights reserved.
//

/*
 *** Blanco ***
 
 Welcome to the awesome game of Blanco where you try to win points by
 hitting your target.
 Your goal is to place the slider as close as possible to the target value.
 The closer you are, the more points you score. Enjoy!
*/

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!

    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFile = Bundle.main.path(forResource: "Blanco", ofType: "html") {
            if let htmlData = NSData(contentsOfFile: htmlFile) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData as Data, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    // Dissmiss about view back to parent
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
