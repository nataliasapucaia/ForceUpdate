//
//  AppDelegate.swift
//  ForceUpdate
//
//  Created by Natalia da Rosa Sapucaia on 10/08/22.
//

import UIKit
import FirebaseCore
import FirebaseRemoteConfig

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = ViewController()

        //1
        FirebaseApp.configure()

        return true
    }

    //5
    func applicationDidBecomeActive(_ application: UIApplication) {
        verifyVersion()
    }
}

extension AppDelegate {
    //2
    func setupRemoteConfig(){
        let remoteConfig = RemoteConfig.remoteConfig()

        let defaults : [String : Any] = [
            ForceUpdateChecker.IS_FORCE_UPDATE_REQUIRED : false,
            ForceUpdateChecker.FORCE_UPDATE_CURRENT_VERSION : "1.0.0(1)",
            ForceUpdateChecker.FORCE_UPDATE_STORE_URL : "https://itunes.apple.com/br/app/myapp/id1234567"
        ]

        let expirationDuration = 0

        remoteConfig.setDefaults(defaults as? [String : NSObject])

        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) in
            if status == .success {
                remoteConfig.activate()
            } else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }

    //3
    func goToAppStore(action: UIAlertAction) {
        let appId = "1234567"
        UIApplication.shared.openAppStore(for: appId)
    }

    //4
    func verifyVersion() {
        setupRemoteConfig()

        if ForceUpdateChecker().check() == .shouldUpdate {
            let alert = UIAlertController(title: "New version avaiable",
                                          message: "There are new features avaiable, please update your app",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Update", style: .default, handler: goToAppStore)
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: true)
        }
    }
}
