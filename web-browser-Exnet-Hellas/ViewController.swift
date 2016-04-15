//
//  ViewController.swift
//  web-browser-Exnet-Hellas
//
//  Created by Γιώργος Λυμπερόπουλος on 15/04/16.
//  Copyright © 2016 glympe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    
    //The view that containes the browser
    @IBOutlet weak var webView: UIWebView!
    //The button that is responsible for going one page back
    @IBOutlet weak var backButton: UIBarButtonItem!
    //The button that is responsible for going one page forward
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    //The text area where user enters a url to browse
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.urlTextField.delegate = self
        self.webView.delegate = self
        //Loading google.com by default
        loadRequest("bing.com")
        //Check if buttons should be enabled or not
        checkButtons()
        
    }
    
    //This function leads the webview one page back
    @IBAction func backTapped(sender: AnyObject) {
        self.webView.goBack()
        checkButtons()
        
    }
    
    //This function leads the webview one page forward
    @IBAction func forwardTapped(sender: AnyObject) {
        self.webView.goForward()
        checkButtons()
        
    }
    
    //This function loads the requested url from user
    @IBAction func searchTapped(sender: AnyObject) {
        search()
    }
    
    //This function takes as a parameter a string
    //checks if it containes the "http://" prefix
    //and then loads the requested URL to the webview
    func loadRequest(urlStr: String){
        
        var urlString = ""
        
        if urlStr.hasPrefix("http://") { // true
            urlString = urlStr + "/"
        }else{
            urlString = "http://" + urlStr + "/"
        }
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    //This functions checks if back and forward buttons
    //can actually go back or forward and it enables them
    //or disable them accordingly
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
    
    //This function checks if textfield is empty
    //if empty - loads as default bing.com
    //otherwise loads the requests URL
    func search(){
        if(urlTextField.text == ""){
            loadRequest("bing.com")
        }else{
            loadRequest(urlTextField.text!)
        }
    }
    
    //Check after finishing the page load to see if
    //buttons should be enabled or not
    func webViewDidFinishLoad(webView: UIWebView) {
        urlTextField.text = webView.request!.URL!.absoluteString
        checkButtons()
    }
    
    //if URL is wrong or incomplete, it loads the default "bing.com"
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        loadRequest("bing.com")
    }
    
    //Enable the return key to search inside the textfield
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        search()
        return true
    }
}

