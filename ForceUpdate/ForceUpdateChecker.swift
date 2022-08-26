//
//  ForceUpdateChecker.swift
//  ForceUpdate
//
//  Created by Natalia da Rosa Sapucaia on 10/08/22.
//

import Foundation
import UIKit
import Firebase

class ForceUpdateChecker {

    //1
    enum UpdateStatus {
        case shouldUpdate
        case noUpdate
    }

    //2
    static let TAG = "ForceUpdateChecker"
    static let FORCE_UPDATE_STORE_URL = "force_update_store_url"
    static let FORCE_UPDATE_CURRENT_VERSION = "force_update_current_version"
    static let IS_FORCE_UPDATE_REQUIRED = "is_force_update_required"

    //3
    func getAppVersion() -> String {
        let version = "\(Bundle.appVersionBundle)(\(Bundle.appBuildBundle))"
        return version
    }

    //4
    func check() -> UpdateStatus {
        let remoteConfig = RemoteConfig.remoteConfig()
        let forceRequired = remoteConfig[ForceUpdateChecker.IS_FORCE_UPDATE_REQUIRED].boolValue

        if(forceRequired == true){
            guard let currentAppStoreVersion = remoteConfig[ForceUpdateChecker.FORCE_UPDATE_CURRENT_VERSION].stringValue else {
                return .noUpdate
            }

            let appVersion = getAppVersion()

            if(currentAppStoreVersion > appVersion){
                let url = remoteConfig[ForceUpdateChecker.FORCE_UPDATE_STORE_URL].stringValue
                if(url != nil){
                    return .shouldUpdate
                }
            }
        }
        return .noUpdate
    }

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
}
