//
//  ProfileImages.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit

/// 유저 프로필 이미지 표시를 위한 재사용 뷰입니다
/// 동그란 프로필 이미지
class UserProfileImageView: UIImageView {
    
    /// 유저 프로필 이미지 설정
    func setImage(image: UIImage?) {
//        self.image = image ?? UIImage(systemName: "person.circle")
        self.image = image ?? UIImage(named: "habitBackgroundExample")?.circularCropped()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(image: nil)

        self.contentMode = .scaleAspectFill // 이미지 비율 유지, UIImageView를 꽉 채우도록 이미지가 크롭됩니다.
//        self.layer.cornerRadius = 25 // 이미지 뷰의 모서리를 둥글게 설정
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true // 이미지 뷰의 모서리 둥글게 설정 시 이미지를 잘라내도록 설정
        
        //self.backgroundColor = .app_TestColor2
        //self.layer.borderWidth = 2.0 // 테두리 두께 설정
        //self.layer.borderColor = UIColor.app_TestColor1.cgColor // 테두리 색상 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 습관 프로필 이미지 표시를 위한 재사용 뷰입니다
/// 동글네모 프로필 이미지
class HabitProfileImageView: UIImageView {
    
    // 기본 이미지
    lazy var defaultImage = getResizedSymbolImage(UIImage(systemName: "square.text.square")!, width: 50, height: 50) // 50x50 사이즈로 리사이징한 아이콘 이미지
    
    /// 습관 프로필 이미지 설정
    func setImage(image: UIImage?) {
        self.image = image ?? defaultImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(image: nil)
        //self.backgroundColor = .app_TestColor2
        self.contentMode = .scaleAspectFill // 이미지 비율 유지, UIImageView를 꽉 채우도록 이미지가 크롭됩니다.
        self.layer.cornerRadius = 10.0 // 이미지 뷰의 모서리를 둥글게 설정
        self.clipsToBounds = true // 이미지 뷰의 모서리 둥글게 설정 시 이미지를 잘라내도록 설정
        
        //self.layer.borderWidth = 1.0 // 테두리 두께 설정
        //self.layer.borderColor = UIColor.app_TestColor1.cgColor // 테두리 색상 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct ProfileImageView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = HabitProfileImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            return view
        }
        .previewLayout(.sizeThatFits)
    }
}
