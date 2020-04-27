//
//  QuestionsTableViewCell.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {

    @IBOutlet private var questiontitleLabel: UILabel!
    @IBOutlet private var questionDescriptionLabel: UILabel!
    @IBOutlet private var askedDateLabel: UILabel!
    @IBOutlet private var authorButton: UIButton!
    @IBOutlet private var answersLabel: UILabel!
    @IBOutlet private var votesLabel: UILabel!
    @IBOutlet private var viewLabel: UILabel!
    private var currentOwner: Owner?
    
    func populateCellWith(_ questionTitle: String?,
                          questionDescription: String?,
                          askedDate: Date?,
                          owner: Owner?,
                          answersCount: String?,
                          votesCount: String?,
                          viewsCount: String?) {
        self.currentOwner = owner
        self.questiontitleLabel.text = String(format: "Q: %@", questionTitle ?? "")
        self.questionDescriptionLabel.text = questionDescription?.removeSpecialCharactersAndSpace
        self.askedDateLabel.text = String(format: "asked %@ by", String().convertDateToString(with: askedDate ?? Date()))
        self.authorButton.setTitle(owner?.displayName ?? "", for: .normal)
        self.answersLabel.text = String(format: "%@ answers", answersCount ?? "")
        self.votesLabel.text = String(format: "%@ votes", votesCount ?? "")
        self.viewLabel.text = String(format: "%@ views", viewsCount ?? "")
    }
    
    @IBAction func authorNamePressed(_ sender: UIButton) {
        guard let url = URL(string: self.currentOwner?.profileLink ?? "") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}
