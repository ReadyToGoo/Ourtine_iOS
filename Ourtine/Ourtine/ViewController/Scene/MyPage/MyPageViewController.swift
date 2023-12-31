//
//  MyPageViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/11.
//

import Foundation
import UIKit

/// 습관 초기 뷰컨트롤러에서 넘어온 습관 검색 뷰컨트롤러 입니다.
/// 습관 초기 VC(test) -> SearchViewController -> SearchResultViewController
class MyPageViewController: UIViewController {
    
    // searchView 등록
    let myPageView = MyPageView()
    
    var dummy_habitCounts = [1,2,3,4,5,6,3]
    
    // 선택된 감정 셀
    var selectedFeelingCellIndex: Int?
    
    // 오늘의 요일 인덱스 (월부터 0)
    var todayIndex: Int?
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = myPageView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //아래의 코드는 네비게이션 루트 VC에 있어야 커스텀 바랑 같이 안보입니다!
        self.navigationController?.navigationBar.isHidden = true
        
        // 오늘 요일 인덱스 가져오기
        todayIndex = getTodayDate()
        
        // 위클리로그 작성하기 탭
        self.myPageView.logTapView.isUserInteractionEnabled = true
        self.myPageView.logTapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goWeeklyLogVC)))
        
        fetchData()
    }
    
    @objc func goWeeklyLogVC() {
        print("위클리로그 화면 전환")
        self.navigationController?.pushViewController(WeeklyLogViewController(), animated: true)
    }
    
    private func fetchData() {
        let userAPI = MoyaWrapper<UserAPI>()
        userAPI.requestSuccessRes(target: .getMyPageInfo, instance: data_getMyPageInfo.self)
        { result in
            var dayCountList:[Int] = [0,0,0,0,0,0,0]
            var moodCountList:[Int] = [0,0,0,0,0]
            
            switch result {
            case .success(let result):
                print(result)
                for item in result.weeklyLog {
                    switch item.day {
                    case "MON" :
                        dayCountList[0] += 1
                    case "TUE" :
                        dayCountList[1] += 1
                    case "WED" :
                        dayCountList[2] += 1
                    case "THU" :
                        dayCountList[3] += 1
                    case "FRI" :
                        dayCountList[4] += 1
                    case "SAT" :
                        dayCountList[5] += 1
                    case "SUN" :
                        dayCountList[6] += 1
                    default :
                        break
                    }
                    
                    switch item.emotion {
                    case "VERY_GOOD" :
                        moodCountList[0] += 1
                    case "GOOD" :
                        moodCountList[1] += 1
                    case "MODERATE" :
                        moodCountList[2] += 1
                    case "BAD" :
                        moodCountList[3] += 1
                    case "VERY_BAD" :
                        moodCountList[4] += 1
                    default:
                        break
                    }
                }
                
                self.dummy_habitCounts = dayCountList
                
                var attributedText = NSMutableAttributedString(string: "\(result.nickname!) 님")
                
                var bigFont = UIFont.systemFont(ofSize: 22, weight: .medium)
                attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 2))
                
                var smallFont = UIFont.systemFont(ofSize: 18, weight: .light)
                attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 2, length: 2))
                
                self.myPageView.nameLabel.attributedText = attributedText
                
                self.myPageView.profileImage.kf.setImage(with: URL(string: result.imageUrl ?? ""))
                self.myPageView.followingNum.text = String(result.followingCount!)
                self.myPageView.followerNum.text = String(result.followerCount!)
                self.myPageView.contentLabel.text = result.goal
                
                attributedText = NSMutableAttributedString(string: "\(result.participationRate!) %")
                
                bigFont = UIFont.systemFont(ofSize: 30, weight: .bold)
                attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 1))
                attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: attributedText.length - 1))
                
                smallFont = UIFont.systemFont(ofSize: 25, weight: .medium)
                attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 1, length: 1  ))
                
                self.myPageView.participateRateLabel.attributedText = attributedText
                
                
                attributedText = NSMutableAttributedString(string: "\(result.habitCount) 개")
                
                bigFont = UIFont.systemFont(ofSize: 30, weight: .bold)
                attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 1))
                attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: attributedText.length - 1))
                
                smallFont = UIFont.systemFont(ofSize: 25, weight: .medium)
                attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 1, length: 1  ))

                self.myPageView.habitCountLabel.attributedText = attributedText
                
                self.fetchDotsCount(stackView: self.myPageView.logStackView, dayCountList: dayCountList)
                self.fetchMoodCount(stackView: self.myPageView.feelingStackView, moodCountList: moodCountList)
                self.addCellActions(stackView: self.myPageView.feelingStackView)
                
                
//                self.habitProfileScrollView.habitProfileView.memberCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchDotsCount(stackView: UIStackView, dayCountList: [Int]) {
        for (index, subView) in stackView.arrangedSubviews.enumerated() {
            if let cell = subView as? WeeklyStatusStackCell {
                cell.habitCount = dayCountList[index]
                
                if index == todayIndex {
                    cell.dayLabel.textColor = .app_PrimaryColor
                    for i in cell.dotsList {
                        let dot = i as UIImageView
                        dot.image = createImageWithColor(color: .app_PrimaryColor, size: CGSize(width: 13, height: 13))?.circularCropped()
                    }
                }
            }
        }
    }
    
    private func fetchMoodCount(stackView:UIStackView, moodCountList: [Int]) {
        for (index, subView) in stackView.arrangedSubviews.enumerated() {
            if let cell = subView as? WeeklyFeelingStackCell {
                cell.countLabel.text = moodCountList[index].value
            }
        }
    }
    
    // Calendar의 weekday는 일요일(1)부터 시작하여 토요일(7)까지 입니다.
    /// 오늘의 요일을 int index로 반환하는 함수입니다. 월요일 부터 0입니다.
    private func getTodayDate()-> Int? {
        let calendar = Calendar.current
        let today = Date()

        if let weekdayIndex = calendar.dateComponents([.weekday], from: today).weekday {
            let adjustedWeekdayIndex = (weekdayIndex + 5) % 7
            return adjustedWeekdayIndex
        } else {
            print("오늘의 요일을 가져올 수 없습니다.")
            return nil
        }
    }
    
    
    private func addCellActions(stackView: UIStackView) {
        for subView in stackView.arrangedSubviews {
            if let cell = subView as? WeeklyFeelingStackCell {
                cell.isUserInteractionEnabled = true
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCell)))
            }
        }
    }
    

    @objc func selectCell(_ sender: UITapGestureRecognizer) {
        let cellIndex: Int?
        guard let cell = sender.view as? WeeklyFeelingStackCell else { return }
            
        switch cell.descLabel.text {
            
        case "매우 좋아요":
            cellIndex = 0
        case "좋아요":
            cellIndex = 1
        case "괜찮아요":
            cellIndex = 2
        case "별로에요":
            cellIndex = 3
        case "매우 별로에요":
            cellIndex = 4
        default:
            cellIndex = nil
            
        }
        
        guard let cellIndex = cellIndex else { return }
        updateFeelingStack(index: cellIndex)
        cell.gotChosen.toggle()
        
    }
    
    func updateFeelingStack(index: Int) {
        // 전에 선택한 인덱스 없으면 인덱스 저장하고 리턴
        guard let precedeIndex = self.selectedFeelingCellIndex else {
            self.selectedFeelingCellIndex = index
            return
        }
        // 셀을 타입캐스팅
        let targetCell = self.myPageView.feelingStackView.arrangedSubviews[precedeIndex] as! WeeklyFeelingStackCell
        //해당 셀 토글
        targetCell.gotChosen.toggle()
        // 선택한 인덱스 바꾸기
        self.selectedFeelingCellIndex = index
    }
    
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }

}

import SwiftUI
struct MyPageViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = MyPageViewController()
            return ViewController
        }
    }
}

