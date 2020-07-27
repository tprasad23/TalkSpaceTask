//
//  ColorExtensions.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/26/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import UIKit

extension UIColor {
    // Needed for storing color in JSON Encodable object
    func dataRepresentation() -> Data? {
        do {
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return colorData
        } catch let error {
            print("archiving error is \(error.localizedDescription)")
        }
        return nil
    }
}

extension Data {
    // Needed for determining color for image playback
    func colorRepresentation() -> UIColor? {
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: self)
            return color
        } catch let error {
            print("un archiving error is \(error.localizedDescription)")
        }
        return nil
    }
}
