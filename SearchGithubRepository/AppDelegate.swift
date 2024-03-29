//
//  AppDelegate.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let searchViewController = SearchViewController()
        window?.rootViewController = UINavigationController(rootViewController: searchViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}

