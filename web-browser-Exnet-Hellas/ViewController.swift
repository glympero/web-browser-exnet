//
//  ViewController.swift
//  web-browser-Exnet-Hellas
//
//  Created by Γιώργος Λυμπερόπουλος on 15/04/16.
//  Copyright © 2016 glympe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.webView.delegate = self
        loadRequest("http://www.google.com")
        checkButtons()
        
    }

    @IBAction func backTapped(sender: AnyObject) {
        self.webView.goBack()
        checkButtons()
    }

    @IBAction func forwardTapped(sender: AnyObject) {
        self.webView.goForward()
        checkButtons()
    }
    
    func loadRequest(urlStr: String){
        let urlStr = urlStr
        let url = NSURL(string: urlStr)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }
    
    func checkButtons(){
        if self.webView.canGoBack{
            self.backButton.enabled = true
        }else{
            self.backButton.enabled = false

        }
        
        if self.webView.canGoForward{
            self.forwardButton.enabled = true
        }else{
            self.forwardButton.enabled = false
            
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        checkButtons()
    }
}

