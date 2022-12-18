//
//  Utility.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import Foundation
import SwiftUI

var colors = [
"blue","green","indigo","orange","pink","red","teal","yellow","magenta"
]


class Utility {
    static func hapticSuccess() {
        let gen = UINotificationFeedbackGenerator()
        gen.notificationOccurred(.success)
    }
    
    static func hapticWarning() {
        let gen = UINotificationFeedbackGenerator()
        gen.notificationOccurred(.warning)
    }
    
}
