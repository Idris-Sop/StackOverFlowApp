//
//  StringExtension.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

extension String {

    var htmlAttributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var removeSpecialCharactersAndSpace: String? {
        var result = replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "<p>", with: "", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "</p>", with: " ", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "<pre>", with: "", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "</pre>", with: " ", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "<code>", with: "", options: NSString.CompareOptions.literal, range: nil)
        result = result.replacingOccurrences(of: "</code>", with: "", options: NSString.CompareOptions.literal, range: nil)
        return result
    }
    
    func convertDateToString(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "MMM, d yy"
        let myString = formatter.string(from: date)
        return myString
    }
    
    func convertDateToStringFullYear(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "MMM d yyyy"
        let myString = formatter.string(from: date)
        return myString
    }
    
    func convertRelativeDateToString(with date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    func convertDateTimeToString(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "HH:mm"
        let myString = formatter.string(from: date)
        return myString
    }
}
