//
//  ViewController.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusBarView: StatusBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarView.delegate = self
    }

    override func loadView() {
        super.loadView()
        
    }
}

extension ViewController: MenuOpen {
    func ButtonTouchInside(_ component: StatusBarView) {
        if let navigation = navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            navigation.pushViewController(viewController, animated: true)
        }
    }
}
