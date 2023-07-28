//
//  HabitCollectionViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

class HabitCardCollectionViewCell: UICollectionViewCell {
    
    static let cellHeight = 200.0
    static let cellWidth = 200.0
    
    static let identifier:String = "HabitCardCollectionViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        return label
    }()
    
    lazy var frontImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bell")
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var habitName: UILabel = {
        let label = UILabel()
        label.text = "습관명"
        return label
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        return label
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.addSubview(frontImage)
        frontImage.addSubview(titleLabel)
        frontImage.addSubview(habitName)
        frontImage.addSubview(userName)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        
        frontImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        titleLabel.snp.makeConstraints {
//
//        }
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getMemberData(data: MemberModel) {
        //        self.memberData = data
        //        self.fetchData()
    }
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        //        self.userName.text = self.memberData.name
        //        self.userImage.setImage(image: nil) // 나중에 URL로 다시 작업
        //        if self.memberData.badge != nil {
        //            //badge 이미지 설정해야함
        //            self.userBadge.isHidden = false
        //        }
        //        else if self.memberData.badge == nil{
        //            self.userBadge.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            return cell
        }
        .previewLayout(.fixed(width: HabitCardCollectionViewCell.cellWidth, height: CGFloat(HabitCardCollectionViewCell.cellHeight)))

    }
}
