//
//  HomeViewText.swift
//  Ourtine
//
//  Created by eunji on 2023/07/27.
//

import SnapKit
import UIKit

class HomeTextBoxView: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.numberOfLines  = 0
        
        return label
    }()
    
    var size: CGSize = CGSize(width: 100, height: 100) {
        didSet {
            updateViewSize()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 16
        backgroundColor = UIColor.white.withAlphaComponent(0.35)
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        updateViewSize()
    }
    
    private func updateViewSize() {
        for constraint in constraints {
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                removeConstraint(constraint)
            }
        }
        
        snp.makeConstraints { make in
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
    
    var text: String? {
        didSet {
            label.text = text
        }
    }

}
