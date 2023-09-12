//
//  ViewController.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/10.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Property

    @IBOutlet weak var statusBarView: StatusBarView!
    @IBOutlet weak var stationTableView: UITableView!
    @IBOutlet weak var searchingTextField: UITextField!
    @IBOutlet weak var searchingImageView: UIImageView!
    @IBOutlet weak var searchingView: UIView!
    @IBOutlet weak var tableTitleView: UIView!
    @IBOutlet weak var tableBodyView: UIView!
    var searchingTableView: UITableView!
    
    private var searchingStationList = [YoubikeType]()
    private var totalStationList = [YoubikeType]()
    private let fetchDataType = FetchData()
    
    // MARK: view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarView.delegate = self
        stationTableView.delegate = self
        stationTableView.dataSource = self
        searchingTextField.delegate = self
        setSearchingTableView()
        setUIStyle()
        
        fetchStationData()
        
        // 設置點擊螢幕取消編輯手勢
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Methods

extension ViewController {
    /// 生成UI畫面
    private func setUIStyle() {
        searchingView.layer.cornerRadius = 8
        tableBodyView.layer.borderWidth = 0.5
        tableBodyView.layer.borderColor = UIColor(named: "gray_01")!.cgColor
        tableBodyView.layer.cornerRadius = 8
        tableTitleView.layer.cornerRadius = 8
        tableTitleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    /// 生成TableVeiw 搜尋欄
    private func setSearchingTableView() {
        self.searchingTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.searchingTableView.backgroundColor = UIColor.white
        self.searchingTableView.delegate = self
        self.searchingTableView.dataSource = self
        self.searchingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchingTableViewCell")
        self.view.addSubview(self.searchingTableView!)
        
        self.searchingTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchingTableView.topAnchor.constraint(equalTo: searchingView.bottomAnchor, constant: 8),
            searchingTableView.leadingAnchor.constraint(equalTo: searchingView.leadingAnchor),
            searchingTableView.trailingAnchor.constraint(equalTo: searchingView.trailingAnchor),
            searchingTableView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        searchingTableView.separatorStyle = .none
        searchingTableView.backgroundColor = UIColor.clear
        searchingTableView.layer.backgroundColor = UIColor(named: "light_gray")!.cgColor
        searchingTableView.layer.cornerRadius = 8
        
        self.searchingTableView.isHidden = true
    }
    
    /// 取得站點資料
    private func fetchStationData() {
        fetchDataType.fetchData { receive in
            self.totalStationList = receive
            DispatchQueue.main.async {
                self.stationTableView.reloadData()
            }
        }
    }
    
    /// 點擊螢幕隱藏鍵盤
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Actions

extension ViewController: MenuOpen {
    /// 狀態列的 Action
    func ButtonTouchInside(_ component: StatusBarView) {
        if let navigation = navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            navigation.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - TableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchingTableView {
            return searchingStationList.count
        }
        if tableView == self.stationTableView {
            return totalStationList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell") as? StationTableViewCell {
            cell.countiesLabel.text = "台北市"
            cell.areaLabel.text = totalStationList[indexPath.row].sarea
            cell.stationLabel.text = totalStationList[indexPath.row].sna
            
            // 灰白相間
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(named: "light_gray")
            }
            return cell
        } else {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SearchingTableViewCell", for: indexPath)
            cell!.textLabel?.text = searchingStationList[indexPath.row].sna
            cell!.backgroundColor = .clear
            return cell!
        }
    }
}

// MARK: - TextField Delegate 搜尋用

extension ViewController: UITextFieldDelegate {
    /// 文字框被編輯
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchingStationList = totalStationList
        if let text = textField.text,
           let range = Range(range, in: text) {
            
            // 新的文字框內容
            let newText = text.replacingCharacters(in: range, with: string)
            if newText == "" { // 空白的話，清空搜尋內容
                searchingStationList = []
                searchingTableView.reloadData()
                return true
            }
            // filter 出相關內容
            searchingStationList = searchingStationList.filter({ station in
                return station.sna.range(of: newText) != nil
            })
            searchingTableView.reloadData()
        }
        return true
    }
    
    /// 開始編輯，跳出新的table view搜尋欄，放大鏡改為綠色
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                searchingStationList = []
                searchingTableView.reloadData()
            } else {
                // 照文字框內容篩選
                searchingStationList = totalStationList
                // filter 出相關內容
                searchingStationList = searchingStationList.filter({ station in
                    return station.sna.range(of: text) != nil
                })
                searchingTableView.reloadData()
            }
        }
        searchingTableView.isHidden = false
        searchingImageView.tintColor = UIColor(named: "main_green")
    }
    
    /// 結束編輯、隱藏搜尋欄
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchingTableView.isHidden = true
        searchingImageView.tintColor = UIColor(named: "gray_01")
    }
}
