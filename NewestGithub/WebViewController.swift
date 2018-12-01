//
//  WebViewController.swift
//  NewestGithub
//
//  Created by Mark Meretzky on 11/30/18.
//  Copyright © 2018 New York University School of Professional Studies. All rights reserved.
//

import UIKit;
import WebKit;

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!;
    var name: String?;   //set by the prepare method of the TableViewController

    //Called when the user selects a cell in the table view.

    override func loadView() {
        let webConfiguration: WKWebViewConfiguration = WKWebViewConfiguration();
        webView = WKWebView(frame: .zero, configuration: webConfiguration);
        webView.uiDelegate = self;
        view = webView;   //Replace the big white view with a WKWebView object.
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.title = name!;

        // Do any additional setup after loading the view.
        // Display the GitHib project whose name was selected by the user.
        let myURL: URL? = URL(string: "https://github.com/WS18SCA01-" + name! + "/");
        let myRequest: URLRequest = URLRequest(url: myURL!);
        webView.load(myRequest);
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
