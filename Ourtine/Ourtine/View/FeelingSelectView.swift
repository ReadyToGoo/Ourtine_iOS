//
//  FeelingSelectView.swift
//  Ourtine
//
//  Created by eunji on 2023/08/14.
//

import UIKit
import SnapKit

class FeelingSelectView: UIView {

    var selectedFeelingCellIndex: Int?

    private var feelingCells: [WeeklyFeelingStackCell] = []

    lazy var feelingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    func configure() {
        addSubviews()
        setConstraints()
        setupFeelingCells()
    }

    private func addSubviews() {
        addSubview(feelingStackView)
    }

    private func setConstraints() {
        feelingStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupFeelingCells() {
        let feelingData: [(UIImage, String, Int)] = [
            (UIImage(named: "feeling1") ?? UIImage(), "매우 좋아요", 0),
            (UIImage(named: "feeling2") ?? UIImage(), "좋아요", 0),
            (UIImage(named: "feeling3") ?? UIImage(), "괜찮아요", 4),
            (UIImage(named: "feeling4") ?? UIImage(), "별로에요", 2),
            (UIImage(named: "feeling5") ?? UIImage(), "매우 별로에요", 0)
        ]

        for (index, data) in feelingData.enumerated() {
            let cell = WeeklyFeelingStackCell()
            cell.adjustCellAppearanceForReview()
            cell.getCellData(image: data.0, text: data.1, count: data.2)
            feelingCells.append(cell)
            feelingStackView.addArrangedSubview(cell)

            cell.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            cell.tag = index
            cell.addGestureRecognizer(tapGestureRecognizer)
        }
    }

//    @objc private func cellTapped(_ sender: UITapGestureRecognizer) {
//        print("Tapped")
//        guard let cellIndex = sender.view?.tag else { return }
//
//        let selectedCell = feelingCells[cellIndex]
//        selectedCell.gotChosen.toggle()
//        updateCellState(isSelected: selectedCell.gotChosen, excludingIndex: cellIndex)
//    }
    @objc private func cellTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped")
        
        if let cellIndex = sender.view?.tag {
            print("Cell Index:", cellIndex)
            
            let selectedCell = feelingCells[cellIndex]
            selectedCell.gotChosen.toggle()
            updateCellState(isSelected: selectedCell.gotChosen, excludingIndex: cellIndex)
        } else {
            print("Failed to get cell index.")
        }
    }


    private func updateCellState(isSelected: Bool, excludingIndex exclude: Int) {
        for (index, cell) in feelingCells.enumerated() {
            if index != exclude {
                cell.updateCellState(isSelected: false)
            }
        }
    }
}
