//
//  AXUIElementHelper.swift
//  SlackUnread
//
//  Created by Yanxi on 2023/6/11.
//

import Cocoa
import Foundation

let kAXStatusLabelAttribute = "AXStatusLabel"

enum AXUIElementHelper {

    static func checkPermission() -> Bool {
        AXIsProcessTrusted()
    }

    static func requestPermission() {
        let promptKey = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let options = [
            promptKey: true,
        ]
        // Returns TRUE if the current process is a trusted accessibility client, FALSE if it is not.
        AXIsProcessTrustedWithOptions(options as CFDictionary)
    }

    static func badgeLabelOfApplication() -> String? {
        let dockBundleID = "com.apple.dock"
        guard let dockApp = NSRunningApplication.runningApplications(withBundleIdentifier: dockBundleID).first else {
            return nil
        }

        let appElement = AXUIElementCreateApplication(dockApp.processIdentifier)
        guard let dockList = appElement.children.first else {
            return nil
        }

        for dockIcon in dockList.children {

            guard let dockItemTitle = try? dockIcon.getAttributeStringValue(kAXTitleAttribute) else {
                continue
            }
            if dockItemTitle != "Slack" {
                continue
            }

            guard let badgeText = try? dockIcon.getAttributeStringValue(kAXStatusLabelAttribute) else {
                continue
            }
            return badgeText
        }
        return nil
    }
}
