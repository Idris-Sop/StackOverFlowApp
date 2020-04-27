//
//  SearchQuestionViewModelDelegate.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

protocol SearchQuestionViewModelDelegate: class {
    func refreshContentView()
    func showError(with message: String)
}
