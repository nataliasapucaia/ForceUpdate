//
//  Extension+Bundle.swift
//  ForceUpdate
//
//  Created by Natalia da Rosa Sapucaia on 11/08/22.
//

import Foundation

extension Bundle {
    //1
    static var appVersionBundle: String {
        guard
            let info = Bundle.main.infoDictionary,
            let version = info["CFBundleShortVersionString"] as? String
            else { return "" }
        return version
    }

    //2
    static var appBuildBundle: String {
        guard
            let info = Bundle.main.infoDictionary,
            let version = info["CFBundleVersion"] as? String
            else { return "" }
        return version
    }
}
