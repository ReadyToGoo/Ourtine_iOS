//
//  HabitDescView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/02.
//

import UIKit
import SnapKit

/// HabitCardCollectionViewCell에 표시될 view입니다.
/// 글자에 맞추어 라벨 사이즈가 조절됩니다.
class HabitDescriptionView: UIView {
    
    // 컨테이너뷰
    lazy var titleLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .app_TertiaryColor
        view.clipsToBounds = false
        return view
    }()
    
    // 좌측 이미지
    lazy var titleImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "book")
        view.contentMode = .scaleAspectFit
        view.tintColor = .app_BrightnessColor80
        return view
    }()
    
    // 라벨
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .app_BrightnessColor80
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    /// 라벨이 대문용 라벨일 경우 속성값을 대문용으로 바꿔주는 함수입니다.
    func configureTitle() {
        self.titleLabel.font = .systemFont(ofSize: 16)
        
        self.titleImage.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(8)
        }
        
        self.titleLabelView.snp.updateConstraints {
            $0.height.equalTo(titleLabel.frame.height + 16)
        }
        
        self.titleLabel.snp.updateConstraints {
            $0.trailing.equalToSuperview().offset(-8)
        }
        
    }
    
    // 라벨 안 이미지가 필요없을 경우 제거하는 함수입니다.
    func removeImage() {
        self.titleImage.snp.updateConstraints {
            $0.width.equalTo(0)
            $0.leading.equalToSuperview().offset(0)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
        
        titleLabelView.addSubview(titleImage)
        titleLabelView.addSubview(titleLabel)
        self.addSubview(titleLabelView)
        
        titleLabelView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.height.equalTo(titleLabel.frame.height + 10)
        }
        
        titleImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.size.equalTo(titleLabel.snp.height)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleImage.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-5) // 이거 괜찮을지도
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct HabitDescriptionView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = HabitDescriptionView()
            return cell
        }
        //.previewLayout(.fixed(width: HabitCardCollectionViewCell.cellWidth, height: CGFloat(HabitCardCollectionViewCell.cellHeight)))
        .previewLayout(.sizeThatFits)
    }
}
