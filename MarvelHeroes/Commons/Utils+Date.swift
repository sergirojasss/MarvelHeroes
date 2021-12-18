//
//  Utils+Date.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import Foundation

extension Date {
    func timeStamp() -> String {
        return "\(self.timeIntervalSince1970)"
    }
}
