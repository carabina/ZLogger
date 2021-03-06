//
//  ZLogger.swift
//  PlayerCore
//
//  Created by Zlatan on 12/10/2017.
//  Copyright © 2017 eTF1. All rights reserved.
//

import Foundation

public final class ZLogger {

    static public var filter: LogEvent? {
        get {
            return ZLogger.severity.first // Not for use but required to compile
        }

        set(newValue) {
            if let newValue = newValue {
                ZLogger.severity = newValue.severity
            }
        }
    }
    static private var severity: [LogEvent] = LogEvent.info.severity

    static private let dateFormat = "yyyy-MM-dd hh:mm:ssSSS"

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }

    static public func log(message: String,
                           event: LogEvent,
                           fileName: String = #file,
                           line: Int = #line,
                           column: Int = #column,
                           funcName: String = #function) {

        #if DEBUG
            if ZLogger.severity.contains(event) {
                print("\(ZLogger.dateFormatter.string(from: Date())) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
            }
        #endif
    }

}
