//
//  SearchViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/13.
//

import Foundation
import UIKit

/// 습관 초기 뷰컨트롤러에서 넘어온 습관 검색 뷰컨트롤러 입니다.
/// 습관 초기 VC(test) -> SearchViewController -> SearchResultViewController
class SearchViewController: UIViewController, UISearchBarDelegate {
    
    // searchView 등록
    let searchView: SearchView = {
        let searchView = SearchView()
        return searchView
    }()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = searchView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //아래의 코드는 네비게이션 루트 VC에 있어야 커스텀 바랑 같이 안보입니다!
        //self.navigationController?.navigationBar.isHidden = true
        
        //MARK: - searchBar
        self.searchView.searchBar.delegate = self
        
        //MARK: - backBTN
        self.searchView.navigationBar.leftButton.action = #selector(popVC)
        self.searchView.navigationBar.leftButton.target = self
        
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// SearchView의 searchBar 컴포넌트에 Action을 추가합니다.
    /// Action :  nextVC로 push (현재) / API에서 데이터 호출 후 nextVC에 전달 (예정)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text {
                // 필요한 처리를 수행합니다.
                // 검색 결과 표시, 서버에 검색 요청 등

                // 반환 값을 사용하거나 다른 함수에 전달합니다.
                let nextVC = SearchResultViewController()
                nextVC.searchResultView.navigationBar.searchBar.text = searchText
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }

}

import SwiftUI
struct SearchViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let TabBarCon = AppTabBarController()
            TabBarCon.selectedIndex = 2
            //let ViewController = SearchViewController()
            return TabBarCon
        }
    }
}
