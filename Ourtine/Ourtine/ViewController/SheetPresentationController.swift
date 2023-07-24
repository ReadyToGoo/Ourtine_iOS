//
//  SheetPresentationController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/22.
//

import UIKit

/// 바텀 시트 컨트롤러 입니다.
class SheetPresentationController: UIViewController {
    
    // View 등록
    let searchFilterOptionsView: BottomSheetView = {
        let searchFilterOptionsView = BottomSheetView()
        searchFilterOptionsView.setContents(title: "정렬 기준", options: ["습관 개설 순","모집 중","시작일 순"])
        return searchFilterOptionsView
    }()
    
    // view 로드할 때 가져오기
    override func loadView() {
        super.loadView()
        view = searchFilterOptionsView
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        //지원할 크기 지정
        self.sheetPresentationController?.detents = [.medium()]
        //시트 상단에 그래버 표시 (기본 값은 false)
        self.sheetPresentationController?.prefersGrabberVisible = true
        
        //처음 크기 지정 (기본 값은 가장 작은 크기)
        //sheet.selectedDetentIdentifier = .large
        
        //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
        //sheet.largestUndimmedDetentIdentifier = .medium
        
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
