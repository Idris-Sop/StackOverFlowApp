//
//  StackOverFlowRepositoryImplementation.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class StackOverFlowRepositoryImplementation: StackOverFlowRepository {

    private let API_END_POINT = "https://api.stackexchange.com/2.2/"
    
    func fetchSearchedQuestionsFrom(_ searchText: String?,
                                    success: @escaping FetchSearchedQuestionsCompletionBlock,
                                    failure: @escaping CompletionFailureBlock) {
        let urlRequestString = String.init(format: API_END_POINT.appending("search/advanced?pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody&title=%@"), searchText ?? "")

        let webServiceManager = WebServicesManager()
         webServiceManager
            .performServerOperationWithURLRequest(with:urlRequestString,
                                                  bodyRequestParameter: nil,
                                                  httpMethod: "GET",
                                                  httpHeaderField: nil,
                                                  success: { (data) in
                                                   do {
                                                       var questionsList = [QuestionModel]()
                                                       
                                                       let jsonResponseObject = try JSONSerialization.jsonObject(with: data! as Data, options: []) as? [String : Any]
                                                       
                                                       if let questionsArrayList = jsonResponseObject?["items"] as? Array<Any> {
                                                           for(_, question) in (questionsArrayList.enumerated()) {
                                                            
                                                            if let currentQuestion = question as? [String : Any] {
                                                                let ownerObject = currentQuestion["owner"] as? [String : Any]
                                                                   
                                                                let currentOwner = Owner(reputation: (NSNumber(value: ownerObject?["reputation"] as? Int ?? 0)).stringValue,
                                                                                         userId: (NSNumber(value: ownerObject?["user_id"] as? Int ?? 0)).stringValue,
                                                                                         userType: ownerObject?["user_type"] as? String,
                                                                                         acceptRate: (NSNumber(value: ownerObject?["accept_rate"] as? Int ?? 0)).stringValue,
                                                                                         profileImageUrl: ownerObject?["profile_image"] as? String,
                                                                                         displayName: ownerObject?["display_name"] as? String,
                                                                                         profileLink: ownerObject?["link"] as? String)
       
                                                                let questionModel = QuestionModel(questionId: (NSNumber(value: currentQuestion["question_id"] as? Int ?? 0)).stringValue,
                                                                                                  questionTitle: currentQuestion["title"] as? String,
                                                                                                  questionLink: currentQuestion["link"] as? String,
                                                                                                  questionBody: currentQuestion["body"] as? String,
                                                                                                  owner: currentOwner,
                                                                                                  isAnswered: currentQuestion["is_answered"] as? Bool,
                                                                                                  viewCount: (NSNumber(value: currentQuestion["view_count"] as? Int ?? 0)).stringValue,
                                                                                                  protectedDate: Date(timeIntervalSince1970: TimeInterval(truncating: currentQuestion["last_activity_date"] as? NSNumber ?? 0)),
                                                                                                  acceptedAnswerId: (NSNumber(value: currentQuestion["accepted_answer_id"] as? Int ?? 0)).stringValue,
                                                                                                  answerCount: (NSNumber(value: currentQuestion["answer_count"] as? Int ?? 0)).stringValue,
                                                                                                  score: (NSNumber(value: currentQuestion["score"] as? Int ?? 0)).stringValue,
                                                                                                  lastActivityDate: Date(timeIntervalSince1970: TimeInterval(truncating: currentQuestion["last_activity_date"] as? NSNumber ?? 0)),
                                                                                                  creationDate: Date(timeIntervalSince1970: TimeInterval(Double(currentQuestion["creation_date"] as? Int ?? 0))),
                                                                                                  lastEditDate: Date(timeIntervalSince1970: TimeInterval(truncating: currentQuestion["last_edit_date"] as? NSNumber ?? 0)),
                                                                                                  tags: currentQuestion["tags"] as? [String])
                                                                questionsList.append(questionModel)
                                                           }
                                                       }
                                                   }
                                                   success(questionsList)
                                               } catch  {
                                                   let dataError = NSError(domain: "The data couldn’t be read due to technical problem.", code: 0, userInfo: nil)
                                                   failure(dataError)
                                               }
                                                                           
           }) { (error) in
               failure(error ?? NSError())
           }
    }
    
    
    func fetchAnswersFrom(_ questionId: String?,
                          success: @escaping FetchAnswersCompletionBlock,
                          failure: @escaping CompletionFailureBlock) {
        
        let urlRequestString = String.init(format: API_END_POINT.appending("questions/%@/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody"), questionId ?? "")

        let webServiceManager = WebServicesManager()
         webServiceManager
            .performServerOperationWithURLRequest(with:urlRequestString,
                                                  bodyRequestParameter: nil,
                                                  httpMethod: "GET",
                                                  httpHeaderField: nil,
                                                  success: { (data) in
                                                   do {
                                                       var answersList = [AnswersModel]()
                                                       
                                                       let jsonResponseObject = try JSONSerialization.jsonObject(with: data! as Data, options: []) as? [String : Any]
                                                       
                                                       if let answersArrayList = jsonResponseObject?["items"] as? Array<Any> {
                                                           for(_, answer) in (answersArrayList.enumerated()) {
                                                            
                                                            if let currentAnswer = answer as? [String : Any] {
                                                                let ownerObject = currentAnswer["owner"] as? [String : Any]
                                                                   
                                                                let currentOwner = Owner(reputation: (NSNumber(value: ownerObject?["reputation"] as? Int ?? 0)).stringValue,
                                                                                         userId: (NSNumber(value: ownerObject?["user_id"] as? Int ?? 0)).stringValue,
                                                                                         userType: ownerObject?["user_type"] as? String,
                                                                                         acceptRate: (NSNumber(value: ownerObject?["accept_rate"] as? Int ?? 0)).stringValue,
                                                                                         profileImageUrl: ownerObject?["profile_image"] as? String,
                                                                                         displayName: ownerObject?["display_name"] as? String,
                                                                                         profileLink: ownerObject?["link"] as? String)
                                      
                                                                let answerModel = AnswersModel(questionId: (NSNumber(value: currentAnswer["question_id"] as? Int ?? 0)).stringValue,
                                                                                               answerId: (NSNumber(value: currentAnswer["answer_id"] as? Int ?? 0)).stringValue,
                                                                                               answerBody: currentAnswer["body"] as? String,
                                                                                               owner: currentOwner,
                                                                                               isAccepted: currentAnswer["is_accepted"] as? Bool,
                                                                                               score: currentAnswer["score"] as? Int ?? 0,
                                                                                               lastActivityDate: Date(timeIntervalSince1970: TimeInterval(truncating: currentAnswer["last_activity_date"] as? NSNumber ?? 0)),
                                                                                               creationDate: Date(timeIntervalSince1970: TimeInterval(truncating: currentAnswer["creation_date"] as? NSNumber ?? 0)))
                                                                
                                                                answersList.append(answerModel)
                                                           }
                                                       }
                                                   }
                                                    answersList.sort(by: { $0.score > $1.score })
                                                   success(answersList)
                                               } catch  {
                                                   let dataError = NSError(domain: "The data couldn’t be read due to technical problem.", code: 0, userInfo: nil)
                                                   failure(dataError)
                                               }
                                                                           
           }) { (error) in
               failure(error ?? NSError())
           }
    }
}
