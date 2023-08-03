//
//  SheetPresentationController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/22.
//

import UIKit

/// 바텀 시트 컨트롤러 입니다.
class SheetPresentationController: UIViewController {
    
    var selectedItem: Int?
    
    /// SheetPresentationController의 selectedItem값을 반환하는 클로저입니다.
    /// 선택한 아이템이 없을 경우 nil을 반환합니다.
    var onItemSelected: ((Int?) -> Void)?
    
    // View 등록
    let searchFilterOptionsView: BottomSheetView = {
        let searchFilterOptionsView = BottomSheetView()
        searchFilterOptionsView.setContents(title: "정렬 기준", optionsName: ["모집 중", "습관 개설 순", "시작일 순"], optionsImage: ["person","pencil","clock"])
        return searchFilterOptionsView
    }()
    
    // view 로드할 때 가져오기
    override func loadView() {
        super.loadView()
        view = searchFilterOptionsView
    }
    
    override func viewDidLoad() {
        //self.view.backgroundColor = .
        
        //지원할 크기 지정
        self.sheetPresentationController?.detents = [.medium()]
        //시트 상단에 그래버 표시 (기본 값은 false)
        self.sheetPresentationController?.prefersGrabberVisible = true
        
        //처음 크기 지정 (기본 값은 가장 작은 크기)
        //sheet.selectedDetentIdentifier = .large
        
        //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
        //sheet.largestUndimmedDetentIdentifier = .medium
        
        // 목록 버튼들 addtarget
        self.searchFilterOptionsView.firstBtn.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        self.searchFilterOptionsView.secondBtn.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        self.searchFilterOptionsView.thirdBtn.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        
    }
    
    /// 버튼을 눌렀을 때 작동할 함수입니다.
    /// 바텀시트 컨트롤러 안의 selectedItem변수에 저장하고, 클로저를 통해 외부 컨트롤러로 반환합니다.
    @objc func tapBtn(_ sender : UIButton) {
        
        switch sender {
        case self.searchFilterOptionsView.firstBtn:
            selectedItem = 1
        case self.searchFilterOptionsView.secondBtn:
            selectedItem = 2
        case self.searchFilterOptionsView.thirdBtn:
            selectedItem = 3
        default:
            print("error")
        }
        
        onItemSelected?(selectedItem)
        dismiss(animated: true)
        
    }
    
    /// 기존 뷰컨트롤러에서 선택된 인덱스를 갖고 옵니다.
    func loadItem(index: Int) {
        
        switch index {
        case 1:
            self.searchFilterOptionsView.firstBtn.tintColor = .app_PrimaryColor
            self.searchFilterOptionsView.firstBtn.setTitleColor(.app_PrimaryColor, for: .normal)
        case 2:
            self.searchFilterOptionsView.secondBtn.tintColor = .app_PrimaryColor
            self.searchFilterOptionsView.secondBtn.setTitleColor(.app_PrimaryColor, for: .normal)
        case 3:
            self.searchFilterOptionsView.thirdBtn.tintColor = .app_PrimaryColor
            self.searchFilterOptionsView.thirdBtn.setTitleColor(.app_PrimaryColor, for: .normal)
        default:
            return
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


import SwiftUI
struct SheetPresentationController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = SheetPresentationController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
