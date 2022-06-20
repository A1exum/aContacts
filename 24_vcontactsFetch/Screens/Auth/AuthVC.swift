//
//  ViewController.swift
//  24-oauthVK
//
//  Created by Alex Fount on 30.05.22.
//

import UIKit
import WebKit

class AuthVC: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: UIScreen.main.bounds)
        
        webView.navigationDelegate = self
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if Session.isValid {
            
            let mainTabBarVC = MainTabBarVC()
            navigationController?.pushViewController(mainTabBarVC, animated: true)
            navigationController?.isNavigationBarHidden = true
            
            return
        }
        
        authorizeToVK()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private
    private func setupViews() {
        
        view.addSubview(webView)
        
    }
  
    private func authorizeToVK() {
        
        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8180745"), //id приложения
            URLQueryItem(name: "display", value: "mobile"), //моб + без javascript
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),   //права доступа к контенту
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        print("request===",url)
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension AuthVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            
            print("Observe URL ->", navigationResponse.response.url)
            decisionHandler(.allow)
            return
        }
        
        let params: Dictionary<String, String> = fragment.components(separatedBy: "&") //созд dict разбив строку
            .map { $0.components(separatedBy: "=") }
            .reduce(Dictionary<String, String>()) { partialResult, param in
                var dictionary = partialResult
                let key = param[0]
                let value = param[1]
                dictionary[key] = value
                return dictionary
            }
        
        guard let token = params["access_token"], let userId = params["user_id"], let expiresIn = params["expires_in"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = Int(userId) ?? 0
        Session.shared.expiresIn = Int(expiresIn) ?? 0
     
        
        let mainTabBarVC = storyboard?.instantiateViewController(withIdentifier: "MainTabBarVC") as! MainTabBarVC
        //let friendsVC = FriendsVC()
        navigationController?.pushViewController(mainTabBarVC, animated: true)
        
        decisionHandler(.cancel)
        print("LoginedId",Session.shared.userId)
     
        
    }
    
}
