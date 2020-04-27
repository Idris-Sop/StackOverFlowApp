//
//  AnswersTableViewCell.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

protocol AnswersCellProtocol: class {
    func updateHeightOfRow(_ cell: AnswersTableViewCell, _ textView: UITextView)
}

class AnswersTableViewCell: UITableViewCell {

    @IBOutlet private var voteLabel: UILabel!
    @IBOutlet private var answerDescriptionTextView: UITextView!
    @IBOutlet private var askedDateLabel: UILabel!
    @IBOutlet private var ownerProfileImageView: UIImageView!
    @IBOutlet private var ownerDisplayNameButton: UIButton!
    @IBOutlet private var ownerReputationLabel: UILabel!
    @IBOutlet private var checkImageView: UIImageView!
    
    private var currentOwner: Owner?
    weak var cellDelegate: AnswersCellProtocol?
    
    func populateCellWith(_ answerDescription: String?,
                          askedDate: Date?,
                          owner: Owner?,
                          votesCount: String?,
                          isAnswerAccepted: Bool) {
        self.currentOwner = owner
        self.voteLabel.text = String(format: "%@ Votes", votesCount ?? "")
        self.answerDescriptionTextView.attributedText = answerDescription?.htmlAttributed
        self.askedDateLabel.text = String(format: "%@ at %@", String().convertDateToStringFullYear(with: askedDate ?? Date()), String().convertDateTimeToString(with: askedDate ?? Date()))
        self.ownerDisplayNameButton.setTitle(owner?.displayName ?? "", for: .normal)
        self.ownerReputationLabel.text = owner?.reputation
        self.ownerProfileImageView.downloaded(from: owner?.profileImageUrl ?? "")
        if isAnswerAccepted {
            checkImageView.image = UIImage(named: "check_green")
        } else {
            checkImageView.image = UIImage(named: "check_orange")
        }
        cellDelegate?.updateHeightOfRow(self, self.answerDescriptionTextView)
    }
    
    @IBAction func authorNamePressed(_ sender: UIButton) {
        guard let url = URL(string: self.currentOwner?.profileLink ?? "") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
