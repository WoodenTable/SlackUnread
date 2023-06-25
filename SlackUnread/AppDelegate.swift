//
//  AppDelegate.swift
//  ModbusClient
//
//  Created by Yanxi on 2022/12/30.
//

import Cocoa
import OSLog
import SwiftyAttributes

let logger = Logger(subsystem: "org.woodentable.SlackUnread", category: "menu-bar")

// https://developer.apple.com/design/human-interface-guidelines/the-menu-bar#Menu-bar-extras

class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        self.setupMenus()
        self.changeStatusBarButton(errorMessage: nil, badgeText: nil)

        AXUIElementHelper.requestPermission()

        self.watchSlackBadgeAndUpdateMenuBar()
    }

    func setupMenus() {
        let menu = NSMenu()

        let errorHandleItem = NSMenuItem(title: "", action: #selector(self.didTapErrorHandleMenuItem), keyEquivalent: "")

        let quitItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "")

        menu.addItem(errorHandleItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quitItem)

        self.statusItem.menu = menu
    }

    private func changeStatusBarButton(errorMessage: String?, badgeText: String?) {
        guard let button = statusItem.button else {
            return
        }

        let slackIcon = NSImage(named: "SlackIcon")!
        slackIcon.isTemplate = true

        button.imagePosition = .imageLeft

        button.appearsDisabled = errorMessage != nil
        button.image = slackIcon

        button.title = (badgeText == "•" ? "●" : badgeText) ?? ""
        button.alignment = .right

        if let errorHandleItem = statusItem.menu?.items.first {
            errorHandleItem.title = errorMessage ?? ""
            errorHandleItem.isHidden = errorMessage == nil
        }
    }

    func watchSlackBadgeAndUpdateMenuBar() {
        var lastBadgeInfo: (error: String?, badge: String?) = (nil, nil)

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            var currentBadgeInfo: (error: String?, badge: String?) = (nil, nil)

            let enabled = AXUIElementHelper.checkPermission()
            if enabled {
                currentBadgeInfo = AXUIElementHelper.badgeLabelOfApplication(appName: "Slack")
            } else {
                currentBadgeInfo = ("no permission", nil)
            }

            if currentBadgeInfo == lastBadgeInfo {
                return
            }
            lastBadgeInfo = currentBadgeInfo

            self.changeStatusBarButton(errorMessage: currentBadgeInfo.error, badgeText: currentBadgeInfo.badge)
        }
    }

    @objc func didTapErrorHandleMenuItem() {
        if !AXUIElementHelper.checkPermission() {
            AXUIElementHelper.requestPermission()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }
}
