//
//  ViewController.swift
//  ZTImageTitleButton1
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    lazy var btn1: UIButton = {
        let bt = exampleButton
        bt.setTitle("图片在上方的按钮", for: .normal)
        bt.zt_imageLayoutStyle = .imageTop
        return bt
    }()
    lazy var btn2: UIButton = {
        let bt = exampleButton
        bt.setTitle("图片在下方的按钮", for: .normal)
        bt.zt_imageLayoutStyle = .imageBottom
        return bt
    }()
    lazy var btn3: UIButton = {
        let bt = exampleButton
        bt.setTitle("图片在左边的按钮", for: .normal)
        bt.zt_imageLayoutStyle = .imageLeft
        return bt
    }()
    lazy var btn4: UIButton = {
        let bt = exampleButton
        bt.setTitle("图片在右边的按钮", for: .normal)
        bt.zt_imageLayoutStyle = .imageRight
        return bt
    }()
    
    lazy var vStackView: UIStackView  = {
        let vs = UIStackView()
        vs.alignment = .fill
        vs.axis = .vertical
        vs.spacing = 10
        return vs
    }()
    
    var exampleButton: UIButton {
        let bt = UIButton()
        bt.setTitle("图片在上方的按钮", for: .normal)
        bt.setImage(UIImage(named: "emotion_01"), for: .normal)
        bt.contentVerticalAlignment = .bottom
        bt.backgroundColor = .init(white: 0.1, alpha: 1)
        bt.zt_imageTitleSpacing = 10
        bt.zt_contentEdgeInsets = .init(top: 10, left: 30, bottom: 10, right: 30)
        return bt
    }
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appendUI()
        self.layoutUI()
    }
    func appendUI() {
        self.view.addSubview(vStackView)
        self.vStackView.addArrangedSubview(btn1)
        self.vStackView.addArrangedSubview(btn2)
        self.vStackView.addArrangedSubview(btn3)
        self.vStackView.addArrangedSubview(btn4)
    }
    func layoutUI() {
        vStackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}


