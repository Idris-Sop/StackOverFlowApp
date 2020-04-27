//
//  SearchQuestionViewModel.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class SearchQuestionViewModel {

    private weak var delegate: SearchQuestionViewModelDelegate?
    private var repository: StackOverFlowRepository?
    var questionsList: [QuestionModel]?
    var selectedQuestion: QuestionModel?
    
    init(with delegate: SearchQuestionViewModelDelegate) {
        self.delegate = delegate
        self.repository = StackOverFlowRepositoryImplementation()
    }
    
    func retreiveQuestionsFrom(_ searchText: String) {
        self.repository?.fetchSearchedQuestionsFrom(searchText,
                                                    success: { [weak self](questionsListModel) in
                                                        self?.questionsList = questionsListModel
                                                        self?.delegate?.refreshContentView()
            }, failure: { [weak self](error) in
                self?.delegate?.showError(with: error.localizedDescription)
        })
    }
    
    func questionDidSelectedAtIndexPath(_ row: Int) {
        self.selectedQuestion = questionsList?[row]
    }
}
