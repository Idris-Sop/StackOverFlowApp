//
//  AnswersViewModel.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class AnswersViewModel: NSObject {

    private weak var delegate: AnswersViewModelDelegate?
    private var repository: StackOverFlowRepository?
    var answersList: [AnswersModel]?
    
    init(with delegate: AnswersViewModelDelegate) {
        self.delegate = delegate
        self.repository = StackOverFlowRepositoryImplementation()
    }
    
    func retreiveAnswersFrom(_ questionId: String) {
        self.repository?.fetchAnswersFrom(questionId,
                                          success: { [weak self](answerListModel) in
                                            self?.answersList = answerListModel
                                            self?.delegate?.refreshContentView()
            }, failure: { [weak self](error) in
                self?.delegate?.showError(with: error.localizedDescription)
        })
    }
}
