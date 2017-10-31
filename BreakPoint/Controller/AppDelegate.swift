//
//  AppDelegate.swift
//  BreakPoint
//
//  Created by Chris Huang on 30/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		FirebaseApp.configure()
		
		if Auth.auth().currentUser == nil {
			let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
			let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC")
			window?.makeKeyAndVisible()
			window?.rootViewController?.present(authVC, animated: true, completion: nil)
		}
		
		return true
	}

}

