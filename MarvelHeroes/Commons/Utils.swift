//
//  Utils.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation

public struct Utils {
    
    static func getTimeStamp() -> String {
        return Date().timeStamp()
    }
    
    static func getHash(_ timeStamp: String) -> String {
        return "\(timeStamp)\(Constants.privateKey)\(Constants.publicKey)".md5
    }
}
