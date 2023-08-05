//
//  HC_chooseTypeViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

class HabitCreate_chooseTypeViewController: UIViewController {
    
    let HC_chooseTypeView = HabitCreate_chooseTypeView()
    
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
        self.HC_chooseTypeView.imageView_private.isUserInteractionEnabled = true
        self.HC_chooseTypeView.imageView_public.isUserInteractionEnabled = true
        self.HC_chooseTypeView.imageView_private.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
        self.HC_chooseTypeView.imageView_public.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
        
        //MARK: - nextBTN
        self.HC_chooseTypeView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_chooseTypeView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseTypeView.navigationBar.leftButton.target = self
        
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer) {
        if let imageview = sender.view as? UIImageView {
            print("chosen image's tag is \(imageview.tag)")
            print("button enabled")
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

