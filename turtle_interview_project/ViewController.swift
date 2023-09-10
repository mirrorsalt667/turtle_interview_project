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
        print("Navigation 打開目錄")
    }
}
