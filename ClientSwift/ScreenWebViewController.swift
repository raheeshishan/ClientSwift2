//
//  ScreenWebViewController.swift
//  ClientSwift
//
//  Created by RAHEESH ET on 13/10/20.
//  Copyright © 2020 ceino. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class ScreenWebViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var webView:WKWebView!

    
   var strUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false

        
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = ""
        
        webView.navigationDelegate = self as WKNavigationDelegate

        //webView.navigationDelegate = self as? WKNavigationDelegate

        sendRequest(urlString: strUrl)

       
       

        // Do any additional setup after loading the view.
    }
    // MARK: - WkWebview Delegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("Finished navigating to url \(String(describing: webView.url))")
        
               MBProgressHUD.hide(for: self.view, animated: true)


    }
    private func sendRequest(urlString: String) {
       let myURL = URL(string: urlString)
       let myRequest = URLRequest(url: myURL!)
       webView.load(myRequest)
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
