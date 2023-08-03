//
//  HabitDescView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/02.
//

import UIKit
import SnapKit

class HabitDescriptionView: UIView {
    
    // 컨테이너뷰
    lazy var titleLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.clipsToBounds = false
        return view
    }()
    
    // 좌측 이미지
    lazy var titleImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "book")
        view.contentMode = .scaleAspectFit
        view.tintColor = .darkGray
        return view
    }()
    
    // 라벨
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    func configureTitle() {
        self.titleLabel.font = .systemFont(ofSize: 18)
        
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
    
    func removeImage() {
        self.titleImage.snp.updateConstraints {
            $0.width.equalTo(0)
            $0.leading.equalToSuperview().offset(0)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        //self.backgroundColor = .systemGray.withAlphaComponent(0.5)
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
