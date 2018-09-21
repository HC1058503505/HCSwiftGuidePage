//
//  Tools.swift
//  HCSwiftGuidePage
//
//  Created by cgtn on 2018/9/21.
//

import Foundation

func HCPrint<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("[\(method)]/[\(line)]: \(message)")
    #endif
}


extension DispatchQueue {
    fileprivate static var _onceToken = [String]()
    static func once(token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }
}
