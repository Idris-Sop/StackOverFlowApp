//
//  QuestionTagsCollectionViewCell.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/27.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class QuestionTagsCollectionViewCell: UICollectionViewCell {
    
    private var containerView: UIView!
    private var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.containerView = UIView(frame: .zero)
        self.containerView.alpha = 1
        self.containerView.layer.cornerRadius = 5
        self.containerView.backgroundColor = UIColor(displayP3Red: 241.0/255.0, green: 136.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        contentView.addSubview(self.containerView)
        
        self.textLabel = UILabel(frame: .zero)
        self.textLabel.textColor = .white
        self.textLabel.font = UIFont.systemFont(ofSize: 14)
        self.textLabel.translatesAutoresizingMaskIntoConstraints = true
        self.textLabel.alpha = 1
        self.textLabel.textAlignment = .center
        self.containerView.addSubview(self.textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func populateCellWith(_ tagName: String) {
        self.textLabel.text = tagName.capitalized
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.textLabel.frame = self.containerView.frame
    }
}
