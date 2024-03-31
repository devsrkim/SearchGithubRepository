//
//  WebViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/31.
//

import UIKit
import WebKit
import SnapKit
import Then

final class WebViewController: BaseViewController {
    private lazy var webView = WKWebView().then {
        $0.allowsBackForwardNavigationGestures = true
        $0.navigationDelegate = self
    }
    
    private let loadURL: String
    
    private let indicator = UIActivityIndicatorView()
    
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
        
        setupUI()
        loadRequest()
    }
}

extension WebViewController {
    private func setupUI() {
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    private func loadRequest() {
        guard let url = URL(string: loadURL) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}
