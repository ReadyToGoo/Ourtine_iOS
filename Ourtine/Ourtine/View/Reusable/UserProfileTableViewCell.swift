//
//  SearchResultTableViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit
import SnapKit

/// 유저 검색 결과를 표시할 테이블뷰 셀
/// 해당 셀은 searchResultTableView안에 표시됩니다.
/// ViewController : SearchResultView
class UserProfileTableViewCell: UITableViewCell {
    
    //셀의 기본 높이와 identifier입니다.
    static let cellHeight:CGFloat = 80
    static let identifier:String = "UserProfileTableViewCell"
    
    // cell data init용
    var userData = UserModel(9999, nil, "DEFAULT", false)
    
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
    
    // following 생성 -> 변경 될 확률 90퍼
    private let followLabel: UILabel = {
        let label = UILabel()
        //label.text = "대충 팔로우"
        label.textColor = UIColor.black
        return label
    }()
    
    // 우측 화살표 버튼 생성
    private let chevronButton: UIButton = {
        let button = UIButton()
        let chevronImg = getResizedSymbolImage(UIImage(systemName: "chevron.right")!, width: 15, height: 25)
        
        button.frame.size = CGSize(width:30, height: 30)
        button.setImage(chevronImg, for: .normal)
    
        button.setTitle(nil, for: .normal)
        button.tintColor = .app_BrightnessColor60
        return button
    }()
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        self.userName.text = self.userData.nickName
        self.userImage.setImage(image: createImageWithColor(color: .app_SecondaryColor, size: CGSize(width: 50, height: 50))) // 나중에 URL로 다시 작업
        if let imageUrl = self.userData.profileImage {
            self.userImage.kf.setImage(with: URL(string: imageUrl), placeholder: createImageWithColor(color: .app_SecondaryColor, size: CGSize(width: 50, height: 50)))
        }
        self.followLabel.text = self.userData.isFollowing ? "v 팔로잉" : "x 팔로잉"
    }
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(chevronButton)
        self.addSubview(followLabel)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        userName.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.centerY.equalTo(userImage.snp.centerY)
        }
        chevronButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
//        followLabel.snp.makeConstraints { make in
//            make.trailing.equalTo(chevronButton.snp.leading)
//            make.centerY.equalTo(chevronButton.snp.centerY)
//        }
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getUserData(data: UserModel) {
        self.userData = data
        self.fetchData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.fetchData()
        self.addViews()
        self.setConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



import SwiftUI // -> View 컴포넌트 하나만 볼 때
import Kingfisher
struct UserProfileTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return UserProfileTableViewCell()
        }
        .previewLayout(.fixed(width: 400, height: UserProfileTableViewCell.cellHeight))

    }
}
