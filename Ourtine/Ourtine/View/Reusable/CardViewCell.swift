//
//  CarouselViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/07/28.
//

import UIKit
import SnapKit

class CardViewCell: UICollectionViewCell {
    static let id = "CardCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    private let habitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardView.addSubview(habitImageView)
        habitImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(cardView.snp.height).multipliedBy(0.45)
        }
        
        cardView.addSubview(habitNameLabel)
        habitNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        habitImageView.image = nil
        habitNameLabel.text = nil
    }
    
    func prepare(image: UIImage?, text: String?) {
        habitImageView.image = image
        habitNameLabel.text = text
    }
}
