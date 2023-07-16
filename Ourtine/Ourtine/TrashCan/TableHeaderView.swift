//
//  TableHeaderView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit

///임시 TableView - tableHeaderView
class TableHeaderView: UIView {
    
    lazy var titleLabel = { () -> UILabel in
        let title = UILabel()
        title.text = "Header Title"
        title.tintColor = .black
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: self.frame.width, height: 50)
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
