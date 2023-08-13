//
//  WeeklyFeelingCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/11.
//

import UIKit
import SnapKit

class WeeklyFeelingStackCell: UIView {
    
    // 셀 내부에서 사용되는 gotChosen 속성 - 해당 셀이 선택되었는지
    var gotChosen: Bool = false {
        didSet {
            updateCellState(isSelected: gotChosen)
        }
    }
    
    // 감정 이미지
    lazy var feelingImage: UIImageView = {
        let view = UIImageView()
        view.image = createImageWithColor(color: .app_BrightnessColor40, size: CGSize(width: 30, height: 30))?.circularCropped()
        view.tintColor = .app_BrightnessColor40
        return view
    }()
    
    // 설명 라벨
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "매우 좋아요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .app_BrightnessColor40
        return label
    }()
    
    // 숫자 라벨
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textAlignment = .center
        label.textColor = .app_BrightnessColor100
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    func adjustCellAppearanceForReview() {
        countLabel.isHidden = true
        descLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        feelingImage.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        [
            feelingImage,
            descLabel,
            countLabel
        ].forEach { self.addSubview($0) }
        
        self.backgroundColor = .white // 셀 배경 흰색
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        feelingImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(feelingImage.snp.width)
        }
        
        descLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(feelingImage.snp.bottom).offset(8)
            $0.width.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    /// Cell data 페칭을 위한 함수
    func getCellData(image: UIImage, text: String, count: Int) {
        self.feelingImage.image = image
        self.descLabel.text = text
        self.countLabel.text = String(count)
    }
    
    func updateCellState(isSelected: Bool) {
        if isSelected {
            self.feelingImage.tintColor = .app_PrimaryColor
            self.descLabel.textColor = .app_PrimaryColor
            self.countLabel.textColor = .app_PrimaryColor
            self.countLabel.text = String(Int(self.countLabel.text!)! + 1)
        }
        else {
            self.feelingImage.tintColor = .app_BrightnessColor40
            self.descLabel.textColor = .app_BrightnessColor40
            self.countLabel.textColor = .app_BrightnessColor100
            self.countLabel.text = String(Int(self.countLabel.text!)! - 1)
        }
        self.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct WeeklyFeelingStackCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = WeeklyFeelingStackCell()
            return cell
        }
        .previewLayout(.fixed(width: 60, height: 150))

    }
}
