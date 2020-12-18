//
//  Base.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/1/4.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public let kScreenH = UIScreen.main.bounds.height
public let kScreenW = UIScreen.main.bounds.width
public let keyWindow = UIApplication.shared.keyWindow!
public var kNaviBarH: CGFloat {
    get {
        if UIDevice.isFringeScreen() { return 88 }
        return 64
    }
}
public var kTabBarH: CGFloat {
    get {
        if UIDevice.isFringeScreen() { return 83 }
        return 49
    }
}

public func bk_font(_ size: CGFloat) -> CGFloat {
    if UIDevice.currentSize() == .iPhone5 || UIDevice.currentSize() == .iPhone4 {
        return size - 2
    }
    return size
}

public let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
public let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
public let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
public let tempPath = NSTemporaryDirectory()


public func printLog<T>(_ message: T,
                 logError: Bool = false,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}

public func BKDeviceID() -> String {
    return "暂时此方法无效"
}

public let BKUserAgent: String = {
    if let info = Bundle.main.infoDictionary {
        let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
        let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
        let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
        let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
        
        let osNameVersion: String = {
            let version = ProcessInfo.processInfo.operatingSystemVersion
            let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
            
            let osName: String = {
                #if os(iOS)
                    return "iOS"
                #elseif os(watchOS)
                    return "watchOS"
                #elseif os(tvOS)
                    return "tvOS"
                #elseif os(macOS)
                    return "OS X"
                #elseif os(Linux)
                    return "Linux"
                #else
                    return "Unknown"
                #endif
            }()
            
            return "\(osName) \(versionString)"
        }()
        
        return "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion))"
    }
    
    return "RMBaseKit"
}()

