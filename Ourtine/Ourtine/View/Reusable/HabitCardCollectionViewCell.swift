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
    
    //셀의 기본 크기와 identifier입니다.
    static let cellHeight = 240.0
    static let cellWidth = 200.0
    
    static let identifier:String = "HabitCardCollectionViewCell"
    
    var cardData = HabitCardModel(nil, "카테고리", "습관명", "유저 닉네임")
    
    // 셀 그림자 색 구현을 위한 전체 포함 뷰
    lazy var cellContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // 셀 배경 흰색
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // 상단 카테고리 커스텀 라벨
    lazy var habitCategoryLabel: HabitDescriptionView = {
        let test = HabitDescriptionView()
        test.titleLabel.text = "독서"
        test.configureTitle()
        return test
    }()
    
    // 셀 이미지
    lazy var frontImage: UIImageView = {
        let view = UIImageView()
        //view.image = getResizedSymbolImage(UIImage(systemName: "square.text.square")!, width: HabitCardCollectionViewCell.cellWidth, height: HabitCardCollectionViewCell.cellHeight)
        view.image = createImageWithColor(color: .app_SecondaryColor, size: CGSize(width: 50, height: 50))
        //view.layer.opacity = 0.3
        return view
    }()
    
    // 이미지 아래 텍스트 들어갈 흰색 뷰
    lazy var frontView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 습관 이름
    lazy var habitName: UILabel = {
        let label = UILabel()
        label.text = "습관명"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // 사용자 이미지
    lazy var userImage: UserProfileImageView = {
        let image = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.setImage(image: createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 50, height: 50)))
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1.0
        return image
    }()
    
    // 사용자 이름
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    // 하단 카테고리 요일 라벨
    lazy var habitDateLabel: HabitDescriptionView = {
        let test = HabitDescriptionView()
        test.titleLabel.text = "월요일"
        test.titleImage.image = UIImage(systemName: "calendar")
        return test
    }()
    
    // 하단 카테고리 시간 라벨
    lazy var habitTimeLabel: HabitDescriptionView = {
        let test = HabitDescriptionView()
        test.titleLabel.text = "0600~0900"
        test.titleImage.image = UIImage(systemName: "clock")
        return test
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        cellContentView.addSubview(frontImage)
        cellContentView.addSubview(frontView)
        cellContentView.addSubview(habitCategoryLabel)
        cellContentView.addSubview(userImage)
        cellContentView.addSubview(habitName)
        cellContentView.addSubview(userName)
        cellContentView.addSubview(habitDateLabel)
        cellContentView.addSubview(habitTimeLabel)
        self.addSubview(cellContentView)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        
        
        cellContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 사진 뷰는 기본적으로 정사각형으로 만듭니다.
        frontImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(frontImage.snp.width)
        }
        
        habitCategoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }

        frontView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
            //$0.top.equalTo(frontImage.snp.bottom)
        }

        userImage.snp.makeConstraints {
            $0.centerY.equalTo(frontView.snp.top)
            $0.leading.equalToSuperview().offset(10)
        }

        habitName.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(5)
            $0.leading.equalTo(userImage)
        }

        userName.snp.makeConstraints {
            $0.top.equalTo(frontView).offset(5)
            $0.leading.equalTo(userImage.snp.trailing).offset(5)
        }
        
        habitDateLabel.snp.makeConstraints {
            $0.top.equalTo(habitName.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        habitTimeLabel.snp.makeConstraints {
            $0.top.equalTo(habitName.snp.bottom).offset(10)
            $0.leading.equalTo(self.cellContentView.snp.centerX).offset(-15)
            $0.bottom.equalToSuperview().offset(-5)
//            $0.leading.equalTo(habitDateLabel.snp.trailing).offset(10)
            
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
        self.habitCategoryLabel.titleLabel.text = self.cardData.title
        self.habitName.text = self.cardData.habitName
        self.userName.text = self.cardData.userName
       // self.userImage.setImage(image: <#T##UIImage?#>)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // CollectionView에서 봤을때, Cell의 음영 효과를 주기 위해 추가합니다.
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        
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
            cell.getHabitsData(data:HabitCardModel(nil, "독서", "아침마다 책읽기", "minseo00"))
            return cell
        }
        .previewLayout(.fixed(width: HabitCardCollectionViewCell.cellWidth, height: CGFloat(HabitCardCollectionViewCell.cellHeight)))
        
    }
}
