//
//  HC_chooseTypeViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

class HabitCreate_chooseTypeViewController: UIViewController {
    
    let HC_chooseTypeView = HabitCreate_chooseTypeView()
    
    /// 선택한 이미지 인덱스
    /// 이미지 선택하면 색이 바뀝니다
    var chosenImageIndex: Int = -1 {
        didSet {
            // private 탭
            if chosenImageIndex == 0 {
                self.HC_chooseTypeView.view_private.backgroundColor = UIColor.app_PrimaryColor
                self.HC_chooseTypeView.view_private.layer.borderColor = UIColor.app_PrimaryColor.cgColor
                self.HC_chooseTypeView.imageView_private.tintColor = .app_BrightnessColor0
                self.HC_chooseTypeView.titleLabel_private.textColor = .app_BrightnessColor0
                
                self.HC_chooseTypeView.view_public.backgroundColor = UIColor.app_BrightnessColor0
                self.HC_chooseTypeView.view_public.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
                self.HC_chooseTypeView.imageView_public.tintColor = .app_SecondaryColor2
                self.HC_chooseTypeView.titleLabel_public.textColor = .app_SecondaryColor2
            }
            // public 탭
            else if chosenImageIndex == 1 {
                self.HC_chooseTypeView.view_public.backgroundColor = UIColor.app_PrimaryColor
                self.HC_chooseTypeView.view_public.layer.borderColor = UIColor.app_PrimaryColor.cgColor
                self.HC_chooseTypeView.imageView_public.tintColor = .app_BrightnessColor0
                self.HC_chooseTypeView.titleLabel_public.textColor = .app_BrightnessColor0
                
                
                self.HC_chooseTypeView.view_private.backgroundColor = UIColor.app_BrightnessColor0
                self.HC_chooseTypeView.view_private.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
                self.HC_chooseTypeView.imageView_private.tintColor = .app_SecondaryColor2
                self.HC_chooseTypeView.titleLabel_private.textColor = .app_SecondaryColor2
            }
            
        }
    }
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseTypeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.HC_chooseTypeView.nextBtn.isEnabled = false
        
        //MARK: - ImageTapGesture setting
        self.HC_chooseTypeView.view_private.isUserInteractionEnabled = true
        self.HC_chooseTypeView.view_public.isUserInteractionEnabled = true
        self.HC_chooseTypeView.view_private.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
        self.HC_chooseTypeView.view_public.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
        
        //MARK: - nextBTN
        self.HC_chooseTypeView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_chooseTypeView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseTypeView.navigationBar.leftButton.target = self
        
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            print("chosen image's tag is \(view.tag)")
            print("button enabled")
            self.chosenImageIndex = view.tag
            print(chosenImageIndex)
            self.HC_chooseTypeView.nextBtn.isEnabled = true
        }
    }
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_chooseCategoryViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

import SwiftUI
struct HabitCreate_chooseType_ViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseTypeViewController()
            return ViewController
        }
    }
}

