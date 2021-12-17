//
//  StringExtension.swift
//  Unico
//
//  Created by alessandro on 15/12/21.
//

import Foundation
import SwiftUI


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
