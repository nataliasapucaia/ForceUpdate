//
//  Extension+UIApplication.swift
//  ForceUpdate
//
//  Created by Natalia da Rosa Sapucaia on 10/08/22.
//

import UIKit

extension UIApplication {
    func openAppStore(for appID: String) {
        let appStoreURL = "https://itunes.apple.com/app"
        guard let url = URL(string: appStoreURL) else {
            return
        }

        DispatchQueue.main.async {
            if self.canOpenURL(url) {
                self.open(url)
            }
        }
    }
}
