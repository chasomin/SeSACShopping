//
//  ItemDetailViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController {
    var urlString = "https://www.apple.com"
    var productId = ""
    let  webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        setButton()
        navigationController?.setNavigationBar()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ItemDetailViewController {
    func setWebView() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func setButton() {
        let button = UIBarButtonItem(image: UserDefaultsManager.shared.like.contains(productId) ? Constants.Image.heartFill : Constants.Image.heart, style: .plain, target: self, action: #selector(heartButtonTapped))
        
        navigationItem.rightBarButtonItem = button
        
    }
    
    @objc func heartButtonTapped() {
        if UserDefaultsManager.shared.like.contains(productId) {
            guard let index = UserDefaultsManager.shared.like.firstIndex(of: productId) else { return }
            UserDefaultsManager.shared.like.remove(at: index)
            setButton()
        } else {
            UserDefaultsManager.shared.like.append(productId)
            setButton()
        }
    }
}
