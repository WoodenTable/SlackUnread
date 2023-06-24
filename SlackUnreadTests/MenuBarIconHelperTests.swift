//
//  MenuBarIconHelperTests.swift
//  SlackUnreadTests
//
//  Created by Yanxi on 2023/6/17.
//

@testable import SlackUnread
import XCTest

final class MenuBarIconHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoBadge() throws {
        let slackIcon = NSImage(named: "SlackIcon")!

        let combinedIcon1 = MenuBarIconHelper.slackIcon(badgeLabel: nil)
        XCTAssertEqual(slackIcon, combinedIcon1)

        let combinedIcon2 = MenuBarIconHelper.slackIcon(badgeLabel: "")
        XCTAssertEqual(slackIcon, combinedIcon2)
    }

    func testWithBadge() throws {
        let slackIcon = NSImage(named: "SlackIcon")!

        let combinedIcon1 = MenuBarIconHelper.slackIcon(badgeLabel: "3")
        XCTAssertGreaterThan(combinedIcon1.size.width, slackIcon.size.width)
    }
}
