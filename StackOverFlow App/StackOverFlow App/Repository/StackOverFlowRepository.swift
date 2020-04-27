//
//  StackOverFlowRepository.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

struct Owner {
    let reputation: String?
    let userId: String?
    let userType: String?
    let acceptRate: String?
    let profileImageUrl: String?
    let displayName: String?
    let profileLink: String?
}

typealias FetchSearchedQuestionsCompletionBlock = (_ success: [QuestionModel]) -> Void
typealias FetchAnswersCompletionBlock = (_ success: [AnswersModel]) -> Void
typealias CompletionFailureBlock = (_ error: NSError) -> Void

protocol StackOverFlowRepository: class {

    func fetchSearchedQuestionsFrom(_ searchText: String?,
                               success: @escaping FetchSearchedQuestionsCompletionBlock,
                               failure: @escaping CompletionFailureBlock)
    
    func fetchAnswersFrom(_ questionId: String?,
                          success: @escaping FetchAnswersCompletionBlock,
                          failure: @escaping CompletionFailureBlock)
}
