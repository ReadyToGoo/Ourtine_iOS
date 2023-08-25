//
//  NonInteractiveStarRateView.swift
//  Ourtine
//
//  Created by eunji on 2023/08/14.
//

import UIKit

class StaticStarRateView: UIView {
    var currentStar: Int = 0 {
        didSet { updateStars() }
    }

    private var starStackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        createStarStackView()
        setConstraints()
    }

    private func createStarStackView() {
        starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.alignment = .center
        starStackView.spacing = 8 // Adjust spacing as needed

        for _ in 0..<5 {
            let starView = UIImageView()
            starView.contentMode = .scaleAspectFit
            starStackView.addArrangedSubview(starView)
        }

        addSubview(starStackView)
    }

    private func setConstraints() {
        starStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateStars() {
        for (index, arrangedSubview) in starStackView.arrangedSubviews.enumerated() {
            if let starView = arrangedSubview as? UIImageView {
                starView.image = index < currentStar ? starFillImage : starEmptyImage
            }
        }
    }

    lazy var starFillImage: UIImage? = {
        var image = UIImage(named: "starFilled")
        return image
    }()

    lazy var starEmptyImage: UIImage? = {
        var image = UIImage(named: "star")
        return image
    }()
}
