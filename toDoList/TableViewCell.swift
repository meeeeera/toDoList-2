//
//  TableViewCell.swift
//  toDoList
//
//  Created by Мира Зейнурова on 10.02.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    let actionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.shadowColor = UIColor(red: 0.947, green: 0.964, blue: 0.979, alpha: 1)
        return label
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.shadowColor = UIColor(red: 0.947, green: 0.964, blue: 0.979, alpha: 1)
        return label
    }()
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            self.addSubview(actionLabel)
            actionLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
            }
    
            self.addSubview(deadlineLabel)
            deadlineLabel.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
            }

        }

}
