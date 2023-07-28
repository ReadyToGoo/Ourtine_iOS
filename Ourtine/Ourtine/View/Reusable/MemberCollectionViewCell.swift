//
//  MemberCollectionViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    static let cellHeight = 120.0
    static let identifier:String = "MemberCollectionViewCell"
        
    
    // cell data init용
    var memberData = MemberModel("crown",nil,"what")
    
    
    // userBadge 생성
    private let userBadge: UIImageView = {
        let imgView = UIImageView()
        imgView.image = getResizedSymbolImage(UIImage(systemName: "crown") ?? UIImage(), width: 20, height: 20)
        //imgView.setImage(image: UIImage(systemName: "crown"))
        imgView.tintColor = .brown
        return imgView
    }()
    
    // userImage 생성
    private let userImage: UserProfileImageView = {
        let imgView = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.tintColor = .black
        return imgView
    }()
        
    // userName 생성
    private let userName: UILabel = {
        let label = UILabel()
        //label.text = "닉네임"
        label.textColor = UIColor.black
        return label
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(userBadge)
    
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        userName.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        userBadge.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(30)
        }
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getMemberData(data: MemberModel) {
        self.memberData = data
        self.fetchData()
    }
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        self.userName.text = self.memberData.name
        self.userImage.setImage(image: nil) // 나중에 URL로 다시 작업
        if self.memberData.badge != nil {
            //badge 이미지 설정해야함
            self.userBadge.isHidden = false
        }
        else if self.memberData.badge == nil{
            self.userBadge.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fetchData()
        self.addViews()
        self.setConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct MemberCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MemberCollectionViewCell()
            cell.getMemberData(data: MemberModel(nil, nil, "Test"))
            return cell
        }
        .previewLayout(.fixed(width: 80, height: CGFloat(MemberCollectionViewCell.cellHeight)))

    }
}

