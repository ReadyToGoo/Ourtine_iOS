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
    
    let badgeNum = 5
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
//        view.layer.applyFigmaShadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 20, spread: 0)
        
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
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    // crownBadge
    private let crownBadge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        
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
//            make.height.equalTo(cardView.snp.height).multipliedBy(0.45)
            make.height.equalTo(69.19)
        }
        
        cardView.addSubview(habitNameLabel)
        habitNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13.38)
        }
        
        cardView.addSubview(crownBadge)
        crownBadge.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-27)
            make.bottom.equalTo(habitImageView.snp.bottom).offset(-2.15)
        }
        
        if badgeNum > 0 {
            crownBadge.isHidden = false
            badgeLabel.isHidden = false
        } else {
            crownBadge.isHidden = true
            badgeLabel.isHidden = true
        }
        
        badgeLabel.text = "X\(badgeNum)"
        cardView.addSubview(badgeLabel)
        badgeLabel.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-8.1)
            make.leading.equalTo(crownBadge.snp.trailing).offset(2)
            make.bottom.equalTo(crownBadge.snp.bottom)
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


//import SwiftUI
//struct CardViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            let cell = CardViewCell()
////            cell.prepare(image: UIImage(named: "habitBackgroundExample"), text: "Card")
////            cell.titleLabel.text = "its test"
//            return cell
//        }
//        .previewLayout(.sizeThatFits)
//
//    }
//}
