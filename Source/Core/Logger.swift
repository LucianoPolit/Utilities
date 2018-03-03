//
//  Logger.swift
//
//  Created by Luciano Polit on 3/3/18.
//

import Foundation

public enum LogFlag {
    case debug
    case info
    case verbose
    case warning
    case error
    case other(Any)
}

public protocol ThirdPartyLogger {
    func log(_ message: String,
             flag: LogFlag,
             file: StaticString,
             function: StaticString,
             line: UInt)
}

public class Printer: ThirdPartyLogger {
    
    public static var isEnabled: Bool = true
    
    public func log(_ message: String,
                    flag: LogFlag,
                    file: StaticString,
                    function: StaticString,
                    line: UInt) {
        guard Printer.isEnabled else { return }
        print("\(flag.description.capitalized): \(message)")
    }
    
}

public class Logger {
    
    public static let shared = Logger()
    
    private var thirdPartyLoggers: [ThirdPartyLogger] = [Printer()]
    
    public func add(thirdPartyLogger: ThirdPartyLogger) {
        thirdPartyLoggers.append(thirdPartyLogger)
    }

    public func log(_ message: String,
                    flag: LogFlag,
                    file: StaticString,
                    function: StaticString,
                    line: UInt) {
        thirdPartyLoggers.forEach {
            $0.log(message,
                   flag: flag,
                   file: file,
                   function: function,
                   line: line)
        }
    }
    
}

extension Logger {
    
    public func logDebug(_ message: String,
                         file: StaticString = #file,
                         function: StaticString = #function,
                         line: UInt = #line) {
        log(message, flag: .debug, file: file, function: function, line: line)
    }
    
    public func logInfo(_ message: String,
                        file: StaticString = #file,
                        function: StaticString = #function,
                        line: UInt = #line) {
        log(message, flag: .info, file: file, function: function, line: line)
    }
    
    public func logVerbose(_ message: String,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        log(message, flag: .verbose, file: file, function: function, line: line)
    }
    
    public func logWarning(_ message: String,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        log(message, flag: .warning, file: file, function: function, line: line)
    }
    
    public func logError(_ message: String,
                         file: StaticString = #file,
                         function: StaticString = #function,
                         line: UInt = #line) {
        log(message, flag: .error, file: file, function: function, line: line)
    }
    
}

extension LogFlag: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .debug: return "Debug"
        case .info: return "Info"
        case .verbose: return "Verbose"
        case .warning: return "Warning"
        case .error: return "Error"
        case .other(let flag):
            if let flag = flag as? CustomStringConvertible {
                return flag.description
            } else {
                return "Other"
            }
        }
    }
    
}
