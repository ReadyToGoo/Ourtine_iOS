//
//  StarRateView.swift
//  Ourtine
//
//  Created by eunji on 2023/08/13.
//

import UIKit
import SnapKit

class StarRateView: UIView {

    var starNumber: Int = 5 {
        didSet { bind() }
    }
    
    var currentStar: Int = 0

    private var buttons: [UIButton] = []

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill")
    }()

    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        starNumber = 5
        addSubviews()
        setConstraints()
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    func bind() {
        for i in 0..<5 {
            let button = UIButton()
            button.setImage(starEmptyImage, for: .normal)
            button.tag = i
            buttons += [button]
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        }
    }

    @objc private func didTapButton(sender: UIButton) {
        let end = sender.tag

        for i in 0...end {
            buttons[i].setImage(starFillImage, for: .normal)
        }
        for i in end + 1..<starNumber {
            buttons[i].setImage(starEmptyImage, for: .normal)
        }

        currentStar = end + 1
    }
}
