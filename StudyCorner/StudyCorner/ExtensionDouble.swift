//
//  ExtensionDouble.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//

// Reference: https://github.com/pouyasadri/Timer-app-ios/tree/main

import Foundation

extension Double{
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second,.nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
