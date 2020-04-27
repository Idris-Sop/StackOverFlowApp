//
//  AnswerHeaderView.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/26.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

protocol AnswerHeaderProtocol: class {
    func updateHeightForHeader(_ headerView: AnswerHeaderView, _ textView: UITextView)
}

class AnswerHeaderView: UIView {

    @IBOutlet private var questionTitle: UILabel!
    @IBOutlet private var askedDateLabel: UILabel!
    @IBOutlet private var activeDateLabel: UILabel!
    @IBOutlet private var viewCountLabel: UILabel!
    @IBOutlet private var askedBottomDateLabel: UILabel!
    @IBOutlet private var ownerProfileImageView: UIImageView!
    @IBOutlet private var ownerDisplayNameButton: UIButton!
    @IBOutlet private var ownerReputationLabel: UILabel!
    @IBOutlet private var answersCountLabel: UILabel!
    @IBOutlet private var questionDescriptionTextView: UITextView!
    
    @IBOutlet private var collectionView: UICollectionView! {
           didSet {
               self.collectionView.showsHorizontalScrollIndicator = false
               self.collectionView.register(QuestionTagsCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifiler")
           }
       }
    
    private var view: UIView!
    private var currentOwner: Owner?
    weak var headerViewDelegate: AnswerHeaderProtocol?
    private var questionTags: [String]?
    
    private struct TagDimensions {
        static let cellHeight: CGFloat = 25
        static let cellSpacing: CGFloat = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
    }
    
    func populateViewWith(_ questionTitle: String?,
                          questionDescription: String?,
                          askedDate: Date?,
                          activedDate: Date?,
                          owner: Owner?,
                          answersCount: String?,
                          votesCount: String?,
                          viewsCount: String?,
                          questionTags: [String]?) {
        self.currentOwner = owner
        self.questionTags = questionTags
        self.questionTitle.text = questionTitle
        self.askedDateLabel.text = String(format: "%@", String().convertRelativeDateToString(with: askedDate ?? Date()))
        self.askedBottomDateLabel.text = String(format: "%@ at %@", String().convertDateToStringFullYear(with: askedDate ?? Date()), String().convertDateTimeToString(with: askedDate ?? Date()))
        self.ownerDisplayNameButton.setTitle(owner?.displayName ?? "", for: .normal)
        self.ownerReputationLabel.text = owner?.reputation
        self.ownerProfileImageView.downloaded(from: owner?.profileImageUrl ?? "")
        self.questionDescriptionTextView.attributedText = questionDescription?.htmlAttributed
        self.answersCountLabel.text = String(format: "%@ Answers", answersCount ?? "")
        self.viewCountLabel.text = String(format: "%@ times", viewsCount ?? "")
        self.activeDateLabel.text = String(format: "%@", String().convertRelativeDateToString(with: activedDate ?? Date()))
        headerViewDelegate?.updateHeightForHeader(self, self.questionDescriptionTextView)
    }
}

extension AnswerHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionTags?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifiler", for: indexPath) as? QuestionTagsCollectionViewCell else {
            return QuestionTagsCollectionViewCell()
        }
        cell.populateCellWith(questionTags?[indexPath.row] ?? "")
        return cell
    }
}

extension AnswerHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentLabelText = questionTags?[indexPath.row] ?? ""
        let label = UILabel(frame: CGRect.zero)
        label.text = currentLabelText
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: TagDimensions.cellHeight)
    }
}
