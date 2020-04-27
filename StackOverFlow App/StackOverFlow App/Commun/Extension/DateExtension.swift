//
//  DateExtension.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

extension Date {

    func convertStringToDate(with dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d yyyy"
        let date = formatter.date(from: dateString)
        return date ?? Date()
    }
}
