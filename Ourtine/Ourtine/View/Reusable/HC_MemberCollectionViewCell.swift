//
//  HC_MemberCollectionViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit
import SnapKit

/// 기본 MemberCollectionViewCell에서 선택시 레이아웃 변경되는 내용 추가한 셀입ㄴ미다.
class HC_MemberCollectionViewCell: UICollectionViewCell {
    
    //셀의 기본 높이와 identifier입니다.
    static let cellHeight = 120.0
    static let identifier:String = "HC_MemberCollectionViewCell"
    
    
    // cell data init용
    var memberData = MemberModel("crown",nil,"what")
    
    // 셀 내부에서 사용되는 gotChosen 속성 - 해당 셀이 선택되었는지
    var gotChosen: Bool = false {
        didSet {
            print(gotChosen)
            updateCellState(isSelected: gotChosen)
        }
    }
    
    func updateCellState(isSelected: Bool) {
        if isSelected {
            //선택했을때
            self.tintView.isHidden = false
            self.userName.textColor = .app_PrimaryColor
        }
        else {
            //취소했을때
            self.tintView.isHidden = true
            self.userName.textColor = .app_BrightnessColor100
        }
        self.layoutIfNeeded()
    }
    
    // userImage 생성 [동그란 이미지]
    private let userImage: UserProfileImageView = {
        let imgView = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.tintColor = .black
        return imgView
    }()
    
    private let tintView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.backgroundColor = .app_BrightnessColor60.withAlphaComponent(0.2)
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.borderWidth = 3
        return view
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
        self.tintView.isHidden = true
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(tintView)
    
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        

        tintView.snp.makeConstraints {
            $0.size.equalTo(userImage)
            $0.center.equalTo(userImage)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom)
            make.centerX.equalToSuperview()
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
struct HC_MemberCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = HC_MemberCollectionViewCell()
            cell.getMemberData(data: MemberModel(nil, nil, "Test"))
            return cell
        }
        .previewLayout(.fixed(width: 80, height: CGFloat(HC_MemberCollectionViewCell.cellHeight)))

    }
}

