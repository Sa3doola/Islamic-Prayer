//
//  SalatTVC.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import UIKit

class SalatTVC: UITableViewCell {
    
    static let id = "SalatTVC"
    
    private var model: IslamicViewModel?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
    }
    
    public func configure(with model: IslamicViewModel) {
        self.model = model
        nameLabel.text = model.name
        timeLabel.text = model.time
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        timeLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        nameLabel.frame = CGRect(x: 5,
                                 y: 5,
                                 width: 100,
                                 height: contentView.height/2)
        timeLabel.frame = CGRect(x: contentView.width - 90,
                                 y: 5,
                                 width: 100,
                                 height: contentView.height/2)
    }
    
}
