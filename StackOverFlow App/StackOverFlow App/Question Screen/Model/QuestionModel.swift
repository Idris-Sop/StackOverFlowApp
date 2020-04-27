//
//  QuestionModel.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

struct QuestionModel {
    var questionId: String?
    var questionTitle: String?
    var questionLink: String?
    var questionBody: String?
    var owner: Owner?
    var isAnswered: Bool?
    var viewCount: String?
    var protectedDate: Date?
    var acceptedAnswerId: String?
    var answerCount: String?
    var score: String?
    var lastActivityDate: Date?
    var creationDate: Date?
    var lastEditDate: Date?
    var tags: [String]?
}
