//
//  HC_introduceViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

class HabitCreate_introduceViewController: UIViewController {
    
    //HC_introduceViewController의 전체화면 View입니다
    let HC_introduceView = HabitCreate_introduceView()
    // 카메라와 앨범에 사용할 UIImagePickerController입니다
    let imagePickerController = UIImagePickerController()
    
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_introduceView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 다음버튼 비활성화
        self.HC_introduceView.nextBtn.isEnabled = false
        
        // 사진 보관함 여는 Menu UIAction
        let photoLib = UIAction(
            title: "사진 보관함",
            image: UIImage(systemName: "photo.on.rectangle"),
            handler: { _ in
                self.handlePhotoLibrary()
            })
        
        // 카메라 여는 Menu UIAction
        let camera = UIAction(
            title: "사진 찍기",
            image: UIImage(systemName: "camera"),
            handler: { _ in
                self.handleCamera()
            })
        
        // 사진 첨부 버튼에 UIMenu 추가하기
        self.HC_introduceView.addImageButton.menu = UIMenu(
            title: "",
            image: nil,
            identifier: nil,
            options: .displayInline,
            children: [photoLib, camera]
        )
        
        // MARK: - 사진 첨부 버튼 잠깐 눌러도 바로 UIMenu 나오게 -> default는 길게 눌러야함
        self.HC_introduceView.addImageButton.showsMenuAsPrimaryAction = true
        
        // MARK: - 텍스트필드 델레게이트
        self.HC_introduceView.titleTextField.delegate = self
        self.HC_introduceView.hashtagTextField.delegate = self
        
        // MARK: - 텍스트 뷰 델레게이트
        self.HC_introduceView.contentTextView.delegate = self
        
        //MARK: - nextBTN
        self.HC_introduceView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_introduceView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_introduceView.navigationBar.leftButton.target = self
        
    }
    
    /// UIImagePickerController관련 카메라 설정 함수 + 카메라 present
    private func handleCamera() {
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        //self.imagePickerController.allowsEditing = true
        // 카메라 presenting
        present(self.imagePickerController, animated: true)
        
    }
    
    /// UIImagePickerController관련 앨범 설정 함수 + 앨범 present
    private func handlePhotoLibrary() {
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary
        // 앨범 presenting
        present(self.imagePickerController, animated: true)
    }
    
    /// 다음 ViewController 넘어가기
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_chooseTimeViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// 카메라와 앨범 사진 선택, 촬영에 관련된 delegate입니다.
extension HabitCreate_introduceViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    /// 이미지 촬영 or 선택 시
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 이미지 설정하는 코드
            print("이미지 설정")
            self.HC_introduceView.addImageButton.setImage(image, for: .normal)
            self.HC_introduceView.nextBtn.isEnabled = true
        } else {
            print("설정 실패")
        }
        picker.dismiss(animated: true)
    }
    
    /// 취소를 눌렀을 때 - 앨범과 카메라 취소 방식 같음
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("취소")
        picker.dismiss(animated: true)
    }
}

/// 텍스트 필드와 텍스트 뷰에 관련된 delegate입니다
extension HabitCreate_introduceViewController: UITextFieldDelegate, UITextViewDelegate {
    
    /// 텍스트 최대길이 제한 관련 함수입니다
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let count = (textField.text?.count ?? 0) + 1
        
        // 제목 텍스트필드인 경우
        if textField == self.HC_introduceView.titleTextField {
            self.HC_introduceView.textCount1.text = "\(count)/20" // 현재 텍스트 카운트 업데이트
            if count >= 20 {    // 20자가 넘으면
                let maxIndex = (self.HC_introduceView.titleTextField.text?.index(self.HC_introduceView.titleTextField.text!.startIndex, offsetBy: 19))! //최대 인덱스
                let newString = self.HC_introduceView.titleTextField.text?.substring(to: maxIndex) //최대 인덱스 서브스트링
                self.HC_introduceView.textCount1.textColor = .red
                self.HC_introduceView.titleTextField.text = newString
                return true
            }
        }
        
        // 해쉬태그 텍스트필드인 경우
        if textField == self.HC_introduceView.hashtagTextField {
            self.HC_introduceView.textCount2.text = "\(count)/8" // 현재 텍스트 카운트 업데이트
            if count >= 8 {    // 20자가 넘으면
                let maxIndex = (self.HC_introduceView.hashtagTextField.text?.index(self.HC_introduceView.hashtagTextField.text!.startIndex, offsetBy: 7))! //최대 인덱스
                let newString = self.HC_introduceView.hashtagTextField.text?.substring(to: maxIndex) //최대 인덱스 서브스트링
                self.HC_introduceView.textCount2.textColor = .red
                self.HC_introduceView.hashtagTextField.text = newString
                return true
            }
        }
       
        // 각 텍스트 필드에서 최대 조건에 걸리지 않은 경우
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let count = (textView.text?.count ?? 0) + 1
        
        // 해쉬태그 텍스트필드인 경우
        if textView == self.HC_introduceView.contentTextView {
            self.HC_introduceView.textCount3.text = "\(count)/50" // 현재 텍스트 카운트 업데이트
            if count >= 50 {    // 50자가 넘으면
                let maxIndex = (self.HC_introduceView.contentTextView.text?.index(self.HC_introduceView.contentTextView.text!.startIndex, offsetBy: 49))! //최대 인덱스
                let newString = self.HC_introduceView.contentTextView.text?.substring(to: maxIndex) //최대 인덱스 서브스트링
                self.HC_introduceView.textCount3.textColor = .red
                self.HC_introduceView.contentTextView.text = newString
                return true
            }
        }
        
        return true
    }
}

import SwiftUI
struct HabitCreate_introduceViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_introduceViewController()
            return ViewController
        }
    }
}
