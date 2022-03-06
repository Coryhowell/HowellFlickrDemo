//
//  Extensions.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/5/22.
//

import Foundation

extension String {
    /// Handle ISO dates with or without fractional seconds.....ZZZZZZZZ
    func convertISODate() -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoDateFormatter.date(from: self) else {
            isoDateFormatter.formatOptions = [.withInternetDateTime]
            return isoDateFormatter.date(from: self)
        }
        return date
    }
}

extension Date {
    /// Format Date and convert to string for display
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yyyy, h:mm a"
        return dateFormatter.string(from: self )
    }
}
