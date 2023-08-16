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
    
    /// KakaoLoginViewController의 didUserGetToken값을 반환하는 클로저입니다.
    var didUserGetToken: ((Bool?) -> Void)?
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //clearWebViewCache()
        
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
        
//        clearWebViewCache()
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
                    // 토큰을 처리한 후에 웹 뷰를 닫기
                    
                    self.didUserGetToken?(true)
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
