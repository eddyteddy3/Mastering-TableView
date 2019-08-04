//
//  DetailedViewController.swift
//  Mastering TableView
//
//  Created by Moazzam Tahir on 03/08/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {

    @IBOutlet var websiteView: WKWebView!
    
    var urlString: String?
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        navigationItem.largeTitleDisplayMode = .automatic
        
        
        if let webAddress = urlString{
            let webURL = URL(string: webAddress)
            let webRequest = URLRequest(url: webURL!)
            
            websiteView.load(webRequest)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
