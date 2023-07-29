//
//  HabitCollectionViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

/// HabitCardCollectionView에 표시될 cell입니다.
/// ViewController : HabitDiscoverViewController
class HabitCardCollectionViewCell: UICollectionViewCell {
    
    static let cellHeight = 200.0
    static let cellWidth = 200.0
    
    static let identifier:String = "HabitCardCollectionViewCell"
    
    var cardData = HabitCardModel(nil, "카테고리", "습관명", "유저 닉네임")
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var frontImage: UIImageView = {
        let view = UIImageView()
        view.image = getResizedSymbolImage(UIImage(systemName: "square.text.square")!, width: HabitCardCollectionViewCell.cellWidth, height: HabitCardCollectionViewCell.cellHeight)
        view.layer.opacity = 0.3
        return view
    }()
    
    lazy var habitName: UILabel = {
        let label = UILabel()
        label.text = "습관명"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.addSubview(frontImage)
        self.addSubview(titleLabel)
        self.addSubview(habitName)
        self.addSubview(userName)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        
        frontImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        habitName.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalTo(titleLabel)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(habitName.snp.bottom)
            $0.leading.equalTo(habitName)
        }
        
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getHabitsData(data: HabitCardModel) {
                self.cardData = data
                self.fetchData()
    }
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        //self.frontImage.image = self.cardData.image
        self.titleLabel.text = self.cardData.title
        self.habitName.text = self.cardData.habitName
        self.userName.text = self.cardData.userName
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
struct HabitCardCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = HabitCardCollectionViewCell()
            //cell.getMemberData(data: MemberModel("Crown", nil, "Test"))
            cell.getHabitsData(data: Dummy_habitCards[0])
            return cell
        }
        .previewLayout(.fixed(width: HabitCardCollectionViewCell.cellWidth, height: CGFloat(HabitCardCollectionViewCell.cellHeight)))

    }
}
