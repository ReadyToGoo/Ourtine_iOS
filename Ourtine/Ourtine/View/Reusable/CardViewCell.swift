//
//  CarouselViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/07/28.
//

import UIKit
import SnapKit
import Kingfisher

class CardViewCell: UICollectionViewCell {
    static let id = "CardCell"
    
    var badgeNum = 0
    
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
        let label = PaddingLabel(withInsets: 6, 6, 8, 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
//        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        label.backgroundColor = .white.withAlphaComponent(0.2)
        label.layer.masksToBounds = true
        label.numberOfLines = 2
        label.layer.cornerRadius = 16
        
        
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
    
    var circularProgressView: CircularProgressView = {
        let progressView = CircularProgressView()

        // Set the desired frame for the view
//        let viewWidth: CGFloat = 63.65
//        let viewHeight: CGFloat = 63.65
//        let xPos: CGFloat = (progressView.bounds.width - viewWidth) / 2
//        let yPos: CGFloat = (progressView.bounds.height - viewHeight) / 2
//        progressView.frame = CGRect(x: xPos, y: yPos, width: viewWidth, height: viewHeight)

        progressView.progressColor = UIColor.orange
        progressView.trackColor = UIColor.orange.withAlphaComponent(0.2)
        
        progressView.updateProgress(to: 0.5)

        return progressView
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
            make.height.equalTo(72)
        }
        
        cardView.addSubview(habitNameLabel)
        habitNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(95)
            make.top.equalToSuperview().offset(8)
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
        
        cardView.addSubview(circularProgressView)

        circularProgressView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview() // Center horizontally
//            make.leading.equalTo(habitImageView.center)
//            make.centerY.equalTo(habitImageView.snp.bottom).offset(8) // Center vertically
//            make.height.width.equalTo(60)
//            make.center.equalTo(cardView)
//            make.leading.equalToSuperview().offset(62.18)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8.35)
            make.size.equalTo(60)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        habitImageView.image = nil
        habitNameLabel.text = nil
        badgeNum = 0
    }
    
    func prepare(image: String?, text: String?, badgeNum: Int?, rate: Int?) {
        habitImageView.kf.setImage(with: URL(string: image!), placeholder: createImageWithColor(color: .app_SecondaryColor, size: CGSize(width: 50, height: 50)))
        habitNameLabel.text = text
        self.badgeNum = badgeNum ?? 0
        
        if let p_rate = rate {
            let attributedString = NSMutableAttributedString(string: "\(p_rate)%")
            let bigFont = UIFont.systemFont(ofSize: 22, weight: .medium)
            attributedString.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedString.length))
            let smallFont = UIFont.systemFont(ofSize: 12, weight: .medium)
            attributedString.addAttribute(.font, value: smallFont, range: NSRange(location: attributedString.length-1, length: 1))

            self.circularProgressView.percentLabel.attributedText = attributedString
            self.circularProgressView.percentLabel.textColor = .orange
            self.circularProgressView.updateProgress(to: CGFloat(p_rate) * 0.01)
        }
        
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
