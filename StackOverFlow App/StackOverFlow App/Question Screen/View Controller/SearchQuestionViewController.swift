//
//  SearchQuestionViewController.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class SearchQuestionViewController: BaseViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet var stackOverFlowIntroView: UIView!
    @IBOutlet var noResultFoundView: UIView!
    @IBOutlet var searchedWordLabel: UILabel!
    
    lazy private var viewModel = SearchQuestionViewModel(with: self)
    var selectedQuestion: QuestionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noResultFoundView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "QuestionsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "QuestionsCellIdentifier")
    }
    
    private func configureSearchBar() {
        searchBar.becomeFirstResponder()
        searchBar.autocapitalizationType = .words
    }
}

extension SearchQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionsList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "QuestionsCellIdentifier", for: indexPath) as? QuestionsTableViewCell
        let currentQuestion = viewModel.questionsList?[indexPath.row]
        customCell?.populateCellWith(currentQuestion?.questionTitle,
                                     questionDescription: currentQuestion?.questionBody,
                                     askedDate: currentQuestion?.creationDate,
                                     owner: currentQuestion?.owner,
                                     answersCount: currentQuestion?.answerCount,
                                     votesCount: currentQuestion?.score,
                                     viewsCount: currentQuestion?.viewCount)
        return customCell ?? QuestionsTableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.questionDidSelectedAtIndexPath(indexPath.row)
        self.performSegue(withIdentifier: "AnswersSegueIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnswersSegueIdentifier" {
            let answerViewController = segue.destination as? AnswersViewController
            answerViewController?.setupViewWith(self.viewModel.selectedQuestion)
        }
    }
}

extension SearchQuestionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.showLoadingIndicator(true)
        viewModel.retreiveQuestionsFrom(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

extension SearchQuestionViewController: SearchQuestionViewModelDelegate {
    func refreshContentView() {
        self.showLoadingIndicator(false)
        if viewModel.questionsList?.count ?? 0 > 0 {
            self.tableView.reloadData()
            self.stackOverFlowIntroView.isHidden = true
            self.noResultFoundView.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.stackOverFlowIntroView.isHidden = true
            self.noResultFoundView.isHidden = false
            self.searchedWordLabel.text = self.searchBar.text
            self.tableView.isHidden = true
        }
    }
    
    func showError(with message: String) {
        self.showLoadingIndicator(false)
        self.showErrorMessage(errorMessage: message)
    }
}
