//
//  AnswersModel.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

struct AnswersModel {
    var questionId: String?
    var answerId: String?
    var answerBody: String?
    var owner: Owner?
    var isAccepted: Bool?
    var score: Int = 0
    var lastActivityDate: Date?
    var creationDate: Date?
}
