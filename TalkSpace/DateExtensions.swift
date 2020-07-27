//
//  DateExtensions.swift
//  TalkSpace
//
//  Created by Teju Prasad on 7/25/20.
//  Copyright © 2020 Four Rooms. All rights reserved.
//

import Foundation

typealias DrawingTimeTuple = (min: Int, sec: Int)

extension Date {
    
    func startDateAndTimeString() -> String {
        let dateFormatter = DateFormatter()
        let format = "MMM d h:mm a"
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        
        return dateFormatter.string(from: self)
    }
    
    func timeFromEarlierDate(lhs: Date) -> DrawingTimeTuple? {
        let diffComponents = Calendar.current.dateComponents([.minute, .second], from: lhs, to: self)
        if let minutes = diffComponents.minute, let seconds =  diffComponents.second {
            if minutes >= 0 && seconds >= 0 {
                return DrawingTimeTuple(min: minutes, sec: seconds)
            }
        }
        return nil
    }
}
