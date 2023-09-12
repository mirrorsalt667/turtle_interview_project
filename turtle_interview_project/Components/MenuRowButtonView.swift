//
//  MenuRowButtonView.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/11.
//

import UIKit

protocol MenuRowButtonDelegate: NSObject {
    func buttonBeenTouched(_ component: MenuRowButtonView, _ clickOn: MenuRowButtonEnum)
}

enum MenuRowButtonEnum {
    case usingGuide
    case takingFee
    case stopInfo
    case newsPage
    case activityPage
}

//@IBDesignable
class MenuRowButtonView: UIView, NibOwnerLoadable {
    
    weak var delegate: MenuRowButtonDelegate?
    var whichButton: MenuRowButtonEnum?
    
//    @IBInspectable
    var buttonTitle: String = "123" {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }

    @IBOutlet weak var button: UIButton!
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        print("Prepare For Interface Builder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("menu init")
        customInit()
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(named: "main_dark_green"), for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(named: "main_dark_green"), for: .highlighted)
    }
    
    private func customInit() {
        loadNibContent()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("nib awake")
    }
    
    // MARK: - Action
    
    @IBAction private func buttonClick(_ sender: Any) {
        if let whichButton = whichButton {
            delegate?.buttonBeenTouched(self, whichButton)
        }
    }
}
