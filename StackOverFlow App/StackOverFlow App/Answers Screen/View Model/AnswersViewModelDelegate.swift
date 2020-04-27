//
//  AnswersViewModelDelegate.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

protocol AnswersViewModelDelegate: class {
    func refreshContentView()
    func showError(with message: String)
}
