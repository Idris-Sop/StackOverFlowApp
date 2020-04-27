//
//  AnswersViewController.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class AnswersViewController: BaseViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 150
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var selectedQuestion: QuestionModel?
    lazy private var viewModel = AnswersViewModel(with: self)
    private var headerView: AnswerHeaderView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showLoadingIndicator(true)
        viewModel.retreiveAnswersFrom(selectedQuestion?.questionId ?? "")
        headerView?.headerViewDelegate = self
        headerView?.populateViewWith(selectedQuestion?.questionTitle,
                                     questionDescription: selectedQuestion?.questionBody,
                                     askedDate: selectedQuestion?.creationDate,
                                     activedDate: selectedQuestion?.protectedDate,
                                     owner: selectedQuestion?.owner,
                                     answersCount: selectedQuestion?.answerCount,
                                     votesCount: selectedQuestion?.score,
                                     viewsCount: selectedQuestion?.viewCount,
                                     questionTags: selectedQuestion?.tags)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AnswersTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AnswersCellIdentifier")
        headerView = AnswerHeaderView(frame: .zero)
        tableView.tableHeaderView = headerView ?? AnswerHeaderView()
    }
    
    func setupViewWith(_ selectedQuestion: QuestionModel?) {
        self.selectedQuestion = selectedQuestion
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFooterViewHeight(for: tableView.tableHeaderView)
    }

    func updateFooterViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = tableView.sectionHeaderHeight
    }
}

extension AnswersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.answersList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "AnswersCellIdentifier", for: indexPath) as? AnswersTableViewCell
        customCell?.cellDelegate = self
        let currentQuestion = viewModel.answersList?[indexPath.row]
        customCell?.populateCellWith(currentQuestion?.answerBody,
                                     askedDate: currentQuestion?.creationDate,
                                     owner: currentQuestion?.owner,
                                     votesCount: String(format: "%d", currentQuestion?.score ?? 0),
                                     isAnswerAccepted: currentQuestion?.isAccepted ?? false)
        return customCell ?? QuestionsTableViewCell()
    }
}

extension AnswersViewController: AnswersViewModelDelegate {
    func refreshContentView() {
        showLoadingIndicator(false)
        self.tableView.reloadData()
    }
    
    func showError(with message: String) {
        showLoadingIndicator(false)
        self.showErrorMessage(errorMessage: message)
    }
}

extension AnswersViewController: AnswersCellProtocol {
    
    func updateHeightOfRow(_ cell: AnswersTableViewCell, _ textView: UITextView) {
        let sizeThatShouldFitTheContent = textView.sizeThatFits(textView.frame.size)
        let newSize = tableView.sizeThatFits(CGSize(width: tableView.frame.size.width,
                                      height: (sizeThatShouldFitTheContent.height + 100.0)))
        if sizeThatShouldFitTheContent.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}

extension AnswersViewController: AnswerHeaderProtocol {
    
    func updateHeightForHeader(_ headerView: AnswerHeaderView, _ textView: UITextView) {
        let sizeThatShouldFitTheContent = textView.sizeThatFits(textView.frame.size)
        let newSize = tableView.sizeThatFits(CGSize(width: tableView.frame.size.width,
                                      height: (sizeThatShouldFitTheContent.height + 320.0)))
        if sizeThatShouldFitTheContent.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
        tableView.sectionHeaderHeight = sizeThatShouldFitTheContent.height + 320.0
    }
}
