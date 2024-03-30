//
//  WebViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/31.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    private let webView = WKWebView().then {
        $0.allowsBackForwardNavigationGestures = true
    }
    
    private let loadURL: String
    
    init(loadURL: String) {
        self.loadURL = loadURL
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = webView
        
        guard let url = URL(string: loadURL) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
