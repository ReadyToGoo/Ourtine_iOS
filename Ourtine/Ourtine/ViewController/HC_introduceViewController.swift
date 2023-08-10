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
    
    // 사진 첨부 후 사진을 임시저장하는 변수
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var introductionImage: UIImage?
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_introduceView
        HabitCreateFlowManager.shared.printself()
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
    
    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        
        let titleText = self.HC_introduceView.titleTextField.text
        let hashtagText = self.HC_introduceView.hashtagTextField.text
        let descText = self.HC_introduceView.contentTextView.text
        
        // 텍스트 다 채웠는지 확인
        guard titleText != "" && hashtagText != "" && descText != ""
        else {
            self.HC_introduceView.nextBtn.isEnabled = false
            //print("텍스트가 설정되지 않았습니다.")
            return
        }
        
        // 이미지 설정되었는지 확인
        guard let titleImage = self.introductionImage
        else {
            self.HC_introduceView.nextBtn.isEnabled = false
            //print("이미지가 설정되지 않았습니다.")
            return
        }
        
        self.HC_introduceView.nextBtn.isEnabled = true
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
//        // 습관 생성 플로우의 데이터를 저장
//        let selectedArr = Array(self.selectedCategorySet)
//        HabitCreateFlowManager.shared.habitInformation.habitCategory = selectedArr
        let titleText = self.HC_introduceView.titleTextField.text
        let hashtagText = self.HC_introduceView.hashtagTextField.text
        let descText = self.HC_introduceView.contentTextView.text
        guard let titleImage = self.introductionImage else { return false }
        
        HabitCreateFlowManager.shared.habitInformation.habitIntroduction.title = titleText
        HabitCreateFlowManager.shared.habitInformation.habitIntroduction.hashtag = hashtagText
        HabitCreateFlowManager.shared.habitInformation.habitIntroduction.image = titleImage
        HabitCreateFlowManager.shared.habitInformation.habitIntroduction.description = descText
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard(
            HabitCreateFlowManager.shared.habitInformation.habitIntroduction.title != nil && HabitCreateFlowManager.shared.habitInformation.habitIntroduction.hashtag != nil && HabitCreateFlowManager.shared.habitInformation.habitIntroduction.image != nil && HabitCreateFlowManager.shared.habitInformation.habitIntroduction.description != nil
        ) else {
           print("HabitCreateFlowManager.shared.habitInformation.habitIntroduction에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        return true
    }
    
    /// 다음 ViewController 넘어가기
    @objc func nextVC() {
        // 텍스트 필드,뷰 는 비었을 때 값을 ""로 반환해주네요 nil이 아님
        
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }

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
            // 임시저장 변수에 이미지 저장
            self.introductionImage = image
            self.HC_introduceView.addImageButton.setImage(image, for: .normal)
            checkToGO() // 조건 체크
            
        } else {
            self.introductionImage = nil
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
        
        ///최신 상태의 텍스트
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        let count = (newText?.count ?? 0)
        
        // 제목 텍스트필드인 경우
        if textField == self.HC_introduceView.titleTextField {
            self.HC_introduceView.textCount1.text = "\(count)/20" // 현재 텍스트 카운트 업데이트
            if count >= 20 {    // 20자가 넘으면
                self.HC_introduceView.textCount1.text = "20/20"
                let maxIndex = (newText?.index(newText!.startIndex, offsetBy: 19))! //최대 인덱스
                let newString = newText?.substring(to: maxIndex) //최대 인덱스 서브스트링
                self.HC_introduceView.textCount1.textColor = .red
                self.HC_introduceView.titleTextField.text = newString
                return true
            }
            self.HC_introduceView.textCount1.textColor = .app_BrightnessColor40
        }
        
        // 해쉬태그 텍스트필드인 경우
        if textField == self.HC_introduceView.hashtagTextField {
            self.HC_introduceView.textCount2.text = "\(count)/8" // 현재 텍스트 카운트 업데이트
            if count >= 8 {    // 20자가 넘으면
                self.HC_introduceView.textCount2.text = "8/8"
                let maxIndex = (newText?.index(newText!.startIndex, offsetBy: 7))! //최대 인덱스
                let newString = newText?.substring(to: maxIndex) //최대 인덱스 서브스트링
                self.HC_introduceView.textCount2.textColor = .red
                self.HC_introduceView.hashtagTextField.text = newString
                return true
            }
            self.HC_introduceView.textCount2.textColor = .app_BrightnessColor40
        }
       
        // 각 텍스트 필드에서 최대 조건에 걸리지 않은 경우
        checkToGO() // 조건 체크
        return true
    }
    
    /// 텍스트 최대길이 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        ///최신 상태의 텍스트
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        let count = (newText.count ?? 0)
        
        // 해쉬태그 텍스트필드인 경우
        if textView == self.HC_introduceView.contentTextView {
            self.HC_introduceView.textCount3.text = "\(count)/50" // 현재 텍스트 카운트 업데이트
            if count >= 50 {    // 50자가 넘으면
                self.HC_introduceView.textCount3.text = "50/50"
                let maxIndex = (newText.index(newText.startIndex, offsetBy: 49)) //최대 인덱스
                let newString = newText.substring(to: maxIndex)
                self.HC_introduceView.textCount3.textColor = .red
                self.HC_introduceView.contentTextView.text = newString
                return true
            }
            
            self.HC_introduceView.textCount3.textColor = .app_BrightnessColor40
        }
        
        checkToGO() // 조건 체크
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
