//
//  MenuViewController.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/10.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var closeMenuButton: UIButton!
    @IBOutlet weak var usingGuideButton: MenuRowButtonView!
    @IBOutlet weak var takingFeeButton: MenuRowButtonView!
    @IBOutlet weak var stopInfoButton: MenuRowButtonView!
    @IBOutlet weak var newsButton: MenuRowButtonView!
    @IBOutlet weak var activityButton: MenuRowButtonView!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: view cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usingGuideButton.buttonTitle = "使用說明"
        usingGuideButton.whichButton = .usingGuide
        usingGuideButton.delegate = self
        takingFeeButton.buttonTitle = "收費方式"
        takingFeeButton.whichButton = .takingFee
        takingFeeButton.delegate = self
        stopInfoButton.buttonTitle = "站點資訊"
        stopInfoButton.whichButton = .stopInfo
        stopInfoButton.delegate = self
        newsButton.buttonTitle = "最新消息"
        newsButton.whichButton = .newsPage
        newsButton.delegate = self
        activityButton.buttonTitle = "活動專區"
        activityButton.whichButton = .activityPage
        activityButton.delegate = self
        loginButton.layer.cornerRadius = 20
    }
    
    @IBAction private func closeMenu_onClike(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MenuViewController {
    
    // MARK: - Methods
    
    /// 檢查要 push 或 pop回到頁面
    private func checkPushPopPages(to pageTitle: String, needToPush: @escaping () -> Void) {
        if let viewControllers = navigationController?.viewControllers {
            var pageIndex: Int?
            for i in 0 ..< viewControllers.count {
                if let title = viewControllers[i].title {
                    if title == pageTitle {
                        pageIndex = i
                    }
                }
            }
            if let pageIndex = pageIndex {
                self.navigationController?.popToViewController(viewControllers[pageIndex], animated: true)
            } else {
                needToPush()
            }
        }
    }
}

// MARK: - Delegates

extension MenuViewController: MenuRowButtonDelegate {
    func buttonBeenTouched(_ component: MenuRowButtonView, _ clickOn: MenuRowButtonEnum) {
        switch clickOn {
        case .usingGuide: break
        case .takingFee: break
        case .stopInfo:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let stopInfoPage = storyboard.instantiateViewController(withIdentifier: "ViewController")
            if let title = stopInfoPage.title {
                checkPushPopPages(to: title) {
                    self.navigationController?.pushViewController(stopInfoPage, animated: true)
                }
            } else {
                self.navigationController?.pushViewController(stopInfoPage, animated: true)
            }
          
        case .newsPage: break
        case .activityPage: break
        }
    }
}
