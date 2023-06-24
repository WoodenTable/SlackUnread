//
//  AXUIElement+GetValue.swift
//  SlackUnread
//
//  Created by Yanxi on 2023/6/11.
//

import Cocoa
import Foundation

public extension AXUIElement {

    var children: [AXUIElement] {
        var count: Int = 0
        var error = AXUIElementGetAttributeValueCount(self, kAXChildrenAttribute as CFString, &count)

        if error == .attributeUnsupported || error == .illegalArgument {
            return []
        }

        guard error == .success else {
            return []
        }

        var values: CFArray?

        error = AXUIElementCopyAttributeValues(self, kAXChildrenAttribute as CFString, 0, count, &values)

        if error == .attributeUnsupported || error == .noValue {
            return []
        }

        guard error == .success else {
            return []
        }

        return values as! [AXUIElement] // swiftlint:disable:this force_cast
    }

    func getAttributeStringValue(_ attribute: String) throws -> String? {
        var value: AnyObject?
        let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &value)

        if error == .noValue {
            return ""
        }

        guard error == .success else {
            return nil
        }

        guard let unpackedValue = value as? String else {
            return nil
        }

        return unpackedValue
    }
}
