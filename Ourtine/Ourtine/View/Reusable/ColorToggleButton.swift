//
//  ColorToggleBtn.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/06.
//

import Foundation
import UIKit

/// 습관 개설 탭의 날짜선택 버튼양식입니다
/// 탭할 때마다 내부의 isOn 변수와 함께 컬러가 바뀝니다
/// 클래스 내부에서는 isOff가 isOn과 같으나, 클래스 외부에서는 isOn 처럼 작동하는 사유로, 이름을 isOff로 했습니다.
class ColorToggleButton: UIButton {
    
    ///선택되었을때 true인 변수입니다
    var isOn: Bool = false
    ///평소 버튼색
    var normalColor:UIColor = .app_BrightnessColor0
    ///선택 후 버튼색
    var selectedColor:UIColor = .app_PrimaryColor
    
    /// 이미지 있을 때 true 설정하는 변수입니다.
    lazy var isImageIn: Bool = false
    /// 평소 이미지
    lazy var normalImage = UIImage()
    /// 선택후 버튼 이미지
    lazy var selectedImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.app_BrightnessColor100, for: .normal)
        self.setBackgroundColor(.app_BrightnessColor0, for: .normal)
        
        self.addTarget(self, action: #selector(toggleColor), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleColor() {
        
        if self.isOn == true {
            // 선택 취소할 때
            self.isOn = false
            self.setBackgroundColor(self.normalColor, for: .normal)
            
            // 이미지 있는 경우
            if self.isImageIn {
                self.setImage(self.normalImage, for: .normal)
            }
        }
        else if self.isOn == false {
            //선택할 때
            self.isOn = true
            self.setBackgroundColor(self.selectedColor, for: .normal)
            
            // 이미지 있는 경우
            if self.isImageIn {
                self.setImage(self.selectedImage, for: .normal)
            }
        }
    }
    
    func addImage(normal:UIImage?, selected:UIImage?) {
        self.isImageIn = true
        self.normalImage = normal ?? UIImage()
        self.selectedImage = selected ?? UIImage()
        self.setImage(self.normalImage, for: .normal)
    }
}
