//
//  SearchResultController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit
import SnapKit

/// 습관 검색 뷰컨트롤러에서 넘어온 습관 검색 결과 뷰컨트롤러 입니다.
/// SearchViewController -> SearchResultViewController -> 프로필 뷰 컨트롤러 (예정)
class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISheetPresentationControllerDelegate {
    
    /// TableView 내용 전환을 위한 Index 변수입니다.
    /// segmentControl에 의해 변경됩니다.
    private var tableViewIndex: Int = 0
    
    // View 등록
    let searchResultView: SearchResultView = {
        let searchResultView = SearchResultView()
        return searchResultView
    }()
    
    // View 불러올 때 searchResultView로 로드
    override func loadView() {
        super.loadView()
        view = searchResultView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        //UI Component에 타겟 연결 등 여러 action 해주세요
        
        //MARK: - segmentControl action추가 - tableView 내용 변경
        self.searchResultView.segmentControl.addTarget(self, action: #selector(changeTableViewContent), for: .valueChanged)
        
        //MARK: - SearchResultTableView 연결
        self.searchResultView.searchResultTableView.delegate = self
        self.searchResultView.searchResultTableView.dataSource = self
        
        //MARK: - tableViewCell 파일 register
        self.searchResultView.searchResultTableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: UserProfileTableViewCell.identifier)
        
        self.searchResultView.searchResultTableView.register(HabitProfileTableViewCell.self, forCellReuseIdentifier: HabitProfileTableViewCell.identifier)
         
        //MARK: - filterBTN
        self.searchResultView.filterBtn.addTarget(self, action: #selector(showFilterOptions), for: .touchDown)
        
        //MARK: - backBTN
        self.searchResultView.navigationBar.leftButton.action = #selector(popVC)
        self.searchResultView.navigationBar.leftButton.target = self
        
        //MARK: - searchBTN
        self.searchResultView.navigationBar.cancelButton.action = #selector(Search)
        self.searchResultView.navigationBar.cancelButton.target = self
        
        self.hidesBottomBarWhenPushed = true
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 검색 결과 출력 (예정)
    @objc func Search() {
        print(self.searchResultView.navigationBar.searchBar.text!)
        
        //검색 결과 나오게하면 될듯 -> Refresh
    }
    
    /// TableView 내용 변경
    /// sementIndex를 불러와 tableView 표시내용의 종류를 결정합니다.
    @objc func changeTableViewContent() {
        let segmentIndex = CGFloat(self.searchResultView.segmentControl.selectedSegmentIndex)
        if segmentIndex == 0 {
            
            self.tableViewIndex = 0
            self.searchResultView.filterBtn.isHidden = false
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.searchResultView.filterBtn.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                self.searchResultView.selectedLine.snp.updateConstraints {
                    $0.leading.equalTo(self.view.frame.width / 6)
                }
                self.searchResultView.layoutIfNeeded()
            })

            self.searchResultView.searchResultTableView.reloadData()
 
        } else if segmentIndex == 1 {
            
            self.tableViewIndex = 1
            self.searchResultView.filterBtn.isHidden = true
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.searchResultView.filterBtn.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                
                self.searchResultView.selectedLine.snp.updateConstraints {
                    $0.leading.equalTo(self.view.frame.width / 6 * 4)
                }
                self.searchResultView.layoutIfNeeded()
            })
            
            self.searchResultView.searchResultTableView.reloadData()
            
        }
    }
    
    /// 필터 버튼 눌러 바텀시트 팝업
    @objc func showFilterOptions() {
        
        let bottomSheet = SheetPresentationController()
        present(bottomSheet, animated: true, completion: nil)
    
    }
    
    
    /// 테이블 뷰에 표시할 셀 개수 전달 (필수)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 5
        
        if tableViewIndex == 0 {
            rowNum = Dummy_habitList.count
        } else if tableViewIndex == 1 {
            rowNum = Dummy_userList.count
        }
        
        return rowNum
    }
    
    /// 테이블 뷰에 표시할 셀 높이 전달
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UserProfileTableViewCell.cellHeight
    }
    
    /// 테이블 뷰에 표시할 재사용 셀 전달 (필수)
    /// tableViewIndex에 따라 셀 내용 다르게 전달
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var r_cell = UITableViewCell()
        
        if tableViewIndex == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitProfileTableViewCell.identifier, for: indexPath) as? HabitProfileTableViewCell else { return UITableViewCell() }
            
            // 넘기기 전에 cell에 데이터 넘겨줍니다
            cell.getHabitData(data: Dummy_habitList[indexPath.row])
            
            r_cell = cell
        }
        else if tableViewIndex == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as? UserProfileTableViewCell else { return UITableViewCell() }
            
            // 넘기기 전에 cell에 데이터 넘겨줍니다
            cell.getUserData(data: Dummy_userList[indexPath.row])
            r_cell = cell
        }
        
        return r_cell
    }
    
    /// 테이블 뷰에 표시된 셀 선택했을 때
    /// tableViewIndex에 따라 표시 VC 다르게 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        if tableViewIndex == 0 {
//            let nextVC = HabitProfileViewController()
//            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else if tableViewIndex == 1 {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
                                                    
}

import SwiftUI
struct SearchResultViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = SearchResultViewController()
            return ViewController
            
            //            let TabBarCon = AppTabBarController()
            //            TabBarCon.selectedIndex = 2
            //            let nextVC = SearchResultViewController()
            //            TabBarCon.navigationController?.pushViewController(nextVC, animated: true)
            //            return TabBarCon
        }
    }
}
