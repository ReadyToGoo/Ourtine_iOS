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
class SearchResultViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    /// TableView 내용 전환을 위한 Index 변수입니다.
    /// segmentControl에 의해 변경됩니다.
    private var tableViewIndex: Int = 0
    
    /// filter 값을 위한 변수입니다.
    /// 기본 값은 첫번째 값입니다.
    private var filterIndex: Int = 1
    
    /// 검색어 입니다. 이전 VC 에서 받아옵니다. default = ""
    var searchTargetName: String = ""
    
    /// 습관 찾기 결과 리스트 입니다. API로 받아옵니다.
    private var habitResultList: [HabitCardModel] = []
    
    /// 유저닉네임 결과 리스트입니다. API로 받아옵니다.
    private var userNameResultList: [UserModel] = []
    
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
        
        // MARK: - SearchResultCollectionView 연결
        self.searchResultView.searchResultCollectionView.delegate = self
        self.searchResultView.searchResultCollectionView.dataSource = self
        
        //MARK: - tableViewCell 파일 register
        self.searchResultView.searchResultTableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: UserProfileTableViewCell.identifier)
        
        //MARK: - habitCardCollectionView 파일 register
        self.searchResultView.searchResultCollectionView.register(HabitCardCollectionViewCell.self, forCellWithReuseIdentifier: HabitCardCollectionViewCell.identifier)
         
        //MARK: - filterBTN
        self.searchResultView.filterBtn.addTarget(self, action: #selector(showFilterOptions), for: .touchDown)
        
        //MARK: - backBTN
        self.searchResultView.navigationBar.leftButton.action = #selector(popVC)
        self.searchResultView.navigationBar.leftButton.target = self
        
        //MARK: - searchBTN
        self.searchResultView.navigationBar.cancelButton.action = #selector(Search)
        self.searchResultView.navigationBar.cancelButton.target = self
        
        //MARK: - 시작 시 습관찾기로 segment 디폴트 설정
        self.searchResultView.segmentControl.selectedSegmentIndex = 0
        
        // MARK: - 시작 시 테이블 뷰 안보이게, 콜렉션 뷰는 보이게
        self.searchResultView.searchResultTableView.isHidden = true
        
        fetchData()
        self.hidesBottomBarWhenPushed = true
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 검색 결과 출력 (예정)
    @objc func Search() {
        print(self.searchResultView.navigationBar.searchBar.text!)
        fetchData()
        //검색 결과 나오게하면 될듯 -> Refresh
    }
    
    
    
    /// TableView 내용 변경
    /// sementIndex를 불러와 tableView 표시내용의 종류를 결정합니다.
    /// 수정 -> CollectionView와 TableView 전환으로 수정되었습니다.
    @objc func changeTableViewContent() {
        let segmentIndex = CGFloat(self.searchResultView.segmentControl.selectedSegmentIndex)
        if segmentIndex == 0 {
            
            self.tableViewIndex = 0
            self.searchResultView.filterBtn.isHidden = false
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                // 버튼 보이게
                self.searchResultView.filterBtn.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                // 밑 강조선 이동
                self.searchResultView.selectedLine.snp.updateConstraints {
                    $0.leading.equalTo(self.view.frame.width / 12)
                }
                // 레이아웃 업데이트
                self.searchResultView.layoutIfNeeded()
            })
            
            // 유저 닉네임 검색 결과 테이블 뷰 숨김
            self.searchResultView.searchResultTableView.isHidden = true
 
        } else if segmentIndex == 1 {
            
            self.tableViewIndex = 1
            self.searchResultView.filterBtn.isHidden = true
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.searchResultView.filterBtn.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                
                self.searchResultView.selectedLine.snp.updateConstraints {
                    $0.leading.equalTo(self.view.frame.width / 12 * 7)
                }
                self.searchResultView.layoutIfNeeded()
            })
            
            
            // 해당 내용은 콜렉션뷰 바꾸고, 테이블뷰 보이게
//            self.searchResultView.searchResultTableView.reloadData()
            self.searchResultView.searchResultTableView.isHidden = false
            
        }
        
        fetchData()
    }
    
    /// 필터 버튼 눌러 바텀시트 팝업
    @objc func showFilterOptions() {
        
        // 바텀 시트 컨트롤러
        let bottomSheet = SheetPresentationController()
        
        bottomSheet.loadItem(index: self.filterIndex)
        
        // 바텀 시트에서 선택 아이템 데이터 갖고오기위한 클로저
        bottomSheet.onItemSelected = { data in
            switch data {
            case 1:
                print("모집 중")
                self.filterIndex = data ?? 1
            case 2:
                print("습관 개설 순")
                self.filterIndex = data ?? 1
            case 3:
                print("시작일 순")
                self.filterIndex = data ?? 1
            default:
                print("error")
            }
            self.changeFilterBtnName(index: self.filterIndex)
            self.fetchData()
        }
        
        // 바텀시트 컨트롤러 present
        present(bottomSheet, animated: true, completion: nil)
    }
    
    /// 본 뷰의 필터버튼 이름 변경
    private func changeFilterBtnName(index: Int) {
        switch index {
        case 1:
            self.searchResultView.filterBtn.setTitle("모집 중", for: .normal)
        case 2:
            self.searchResultView.filterBtn.setTitle("습관 개설 순", for: .normal)
        case 3:
            self.searchResultView.filterBtn.setTitle("시작일 순", for: .normal)
        default:
            return
        }
    }
    
    func getStringFromFilterIndex() -> String {
        switch self.filterIndex {
        case 1:
            return searchFilter.CREATED_DATE.toString()
        case 2:
            return searchFilter.RECRUITING.toString()
        case 3:
            return searchFilter.START_DATE.toString()
        default:
            return searchFilter.CREATED_DATE.toString()
        }
    }
    
    func fetchData() {
        let selectedIndex = self.tableViewIndex
        let searchTarget = self.searchResultView.navigationBar.searchBar.text
        let filterString = getStringFromFilterIndex()
        
        switch selectedIndex {
        case 0:
            var inputList:[HabitCardModel] = []
            let habitAPI = MoyaWrapper<HabitAPI>()
            habitAPI.requestSuccessRes(target:.getSearchHabit(sort_by: filterString, keyword: searchTarget ?? ""), instance: data_getSearchHabit.self){ result in
                switch result {
                case .success(let result):
                    print(result)
                    for item in result.content {
                        print(item.id)
                        inputList.append(HabitCardModel(habitId: item.id, image: item.imageUrl, title: item.category ?? "none", habitName: item.title ?? "none", userName: item.hostName ?? "none", userImage: item.hostImageUrl, days: item.days, startTime: item.startTime, endTime: item.endTime))
                    }
                    self.habitResultList = inputList
                    self.searchResultView.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case 1:
            var inputList:[UserModel] = []
            let userAPI = MoyaWrapper<UserAPI>()
            userAPI.requestSuccessRes(target: .getSearchUserNickName(keyword: searchTarget ?? ""), instance: data_getSearchUserNickName.self) { result in
                switch result {
                case .success(let result):
                    print(result)
                    for item in result.content {
                        inputList.append(UserModel(item.userId ?? 0, item.profileImage, item.nickname ?? "", nil))
                    }
                    self.userNameResultList = inputList
                    self.searchResultView.searchResultTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default :
            print("unexpected Error")
            return
        }
    }
}

/// CollectionView의 Delegate와 DataSource 상속 내용입니다
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// numberOfItemsInSection : cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.habitResultList.count
    }
    
    /// cellForItemAt : cell 내용 배정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HabitCardCollectionViewCell.identifier,
            for: indexPath
        ) as? HabitCardCollectionViewCell else { return UICollectionViewCell() }
        //cell.getHabitsData(data: Dummy_habitCards[indexPath.row])
        cell.getHabitsData(data: self.habitResultList[indexPath.row])
        return cell
    }
    
    /// didSelectItemAt : cell 선택했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.habitResultList[indexPath.row].habitName)
        print("habitId : \(self.habitResultList[indexPath.row].habitId ?? -100)")
    }
}

/// CollectionView의  FlowLayout 상속 내용입니다
extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView의 좌우 여백 조정
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let topBottomPadding: CGFloat = 20
            let leftPadding: CGFloat = 16
            let rightPadding: CGFloat = 16

            return UIEdgeInsets(top: topBottomPadding, left: leftPadding, bottom: topBottomPadding, right: rightPadding)
        }
    
    // CollectionView의 Cell 사이즈 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: self.view.frame.width / 2 - 25,
            height: self.view.frame.width / 2 + 20
        )
    }
    
    //섹션의 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    //섹션의 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    /// 테이블 뷰에 표시할 셀 개수 전달 (필수)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.userNameResultList.count
    }
    
    /// 테이블 뷰에 표시할 셀 높이 전달
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UserProfileTableViewCell.cellHeight
    }
    
    /// 테이블 뷰에 표시할 재사용 셀 전달 (필수)
    /// tableViewIndex에 따라 셀 내용 다르게 전달
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as? UserProfileTableViewCell else { return UITableViewCell() }
        
        // 넘기기 전에 cell에 데이터 넘겨줍니다
        cell.getUserData(data: self.userNameResultList[indexPath.row])
        // 셀 선택할 때의 색 없앱니다
        cell.selectionStyle = .none
        return cell
    }
    
    /// 테이블 뷰에 표시된 셀 선택했을 때
    /// tableViewIndex에 따라 표시 VC 다르게 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        print("userID: \(self.userNameResultList[indexPath.row].userKey)")
        
        
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    
}

import SwiftUI
struct SearchResultViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = SearchResultViewController()
            return ViewController
        }
    }
}
