//
//  MenuBarIconHelper.swift
//  SlackUnread
//
//  Created by Yanxi on 2023/6/17.
//

import Cocoa
import Foundation
import SwiftyAttributes

class MenuBarIconHelper {

    static func slackIcon(badgeLabel: String?) -> NSImage {
        let slackIcon = NSImage(named: "SlackIcon")!
        guard let badge = badgeLabel else { return slackIcon }
        if badge.count == 0 {
            return slackIcon
        }

        let attributedText = badge.withAttributes([.font(.preferredFont(forTextStyle: .body))])
        let textSize = attributedText.size()

        let textImage = NSImage(size: textSize, flipped: false) { size in
            attributedText.draw(at: .zero)
            return true
        }

        let space = 8.0
        let combinedSize = NSSize(
            width: slackIcon.size.width + space + textSize.width,
            height: max(slackIcon.size.height, textSize.height)
        )

        let combinedImage = NSImage(size: combinedSize, flipped: false) { rect in

            let iconPoint = CGPoint(x: 0, y: (combinedSize.height - slackIcon.size.height) / 2.0)
            slackIcon.draw(in: NSRect(origin: iconPoint, size: slackIcon.size))

            let textPoint = CGPoint(
                x: slackIcon.size.width + space,
                y: (combinedSize.height - textSize.height) / 2.0
            )
            textImage.draw(in: NSRect(origin: textPoint, size: textSize))
            return true
        }

        return combinedImage
    }
}
