//
//  AppDelegate.swift
//  ModbusClient
//
//  Created by Yanxi on 2022/12/30.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        self.setupMenus()
    }

    func setupMenus() {
        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))

        self.statusItem.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }
}
