//
//  LogInViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation
import UIKit
import SnapKit
import WebKit

/// 카카오 로그인을 위한 웹뷰 컨트롤러 입니다.
/// 카카오 로그인 화면 팝업 후 로그인 완료시 dismiss됩니다.
class KakaoLoginViewController : UIViewController, WKNavigationDelegate {
    
    // 토큰처리를 성공적으로 진행했는지 판단하는 변수입니다.
    var isSucceed: Bool?
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        if let url = URL(string: "https://api.hyobn.shop/api/auth/kakao/login") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        // 테스트용 캐시 비우기
        //clearWebViewCache()
    }
}

extension KakaoLoginViewController {

    
    // WKNavigationDelegate 메서드 - 웹 페이지 로딩 상태 변경 시 호출됨
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 웹 페이지 로딩 완료 시 쿠키 및 페이지 내용을 확인하여 토큰 추출 및 처리
        webView.evaluateJavaScript("document.cookie") { (result, error) in
            if let cookieString = result as? String {
                // 토큰 값을 사용
                if cookieString.contains("Auth") {
                    myInfo.setMyToken(cookieString: cookieString)
                    // 토큰을 처리한 후에 isSucceed값 변경
                    self.isSucceed = true
                    // 웹 뷰를 닫기 + notify
                    self.dismissWebView()
                }
                //print("Received token value: \(cookieString)")
                
            }
        }
    }
    
    // 웹 뷰를 닫는 메서드
    func dismissWebView() {
        if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
        if let suc = isSucceed, suc == true {
            // 서버 토큰을 성공적으로 받았음을 notify합니다
            NotificationCenter.default.post(name: NSNotification.Name("KakaoLoginSucceed"), object: nil)
        }
        // 토큰 받기에 실패했을때, alert합니다.
        else {
            makeAlert(title: "Login Error", message: "로그인에 실패했습니다. 다시 시도해주세요", completion: nil)
        }
    }

    // 캐시삭제
    func clearWebViewCache() {
            let dataStore = WKWebsiteDataStore.default()
            let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
            
            dataStore.removeData(ofTypes: websiteDataTypes, modifiedSince: Date(timeIntervalSince1970: 0)) { [weak self] in
                self?.webView.loadHTMLString("", baseURL: nil) // Clear the current webView content
            }
        }
    
    
}
