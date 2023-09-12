//
//  StatusBarView.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/10.
//

import UIKit

protocol MenuOpen: NSObject {
    func ButtonTouchInside(_ component: StatusBarView)
}

//@IBDesignable
class StatusBarView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    
    weak var delegate: MenuOpen?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        loadNibContent()
    }
    
    // MARK: - Action
    
    @IBAction func menuBtn_onClick(_ sender: Any) {
        delegate?.ButtonTouchInside(self)
    }
}
