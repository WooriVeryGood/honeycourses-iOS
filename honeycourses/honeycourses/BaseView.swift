//
//  BaseView.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
	associatedtype ViewController: BaseViewControllerProtocol
	var controller: ViewController? { get }
	init(controller: ViewController)
}

class BaseView<ViewController: BaseViewControllerProtocol>: UIView, BaseViewProtocol {
	weak var controller: ViewController?
	
	required init(controller: ViewController) {
		self.controller = controller
		super.init(frame: .zero)
		setupUI()
		setupBinding()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setupUI() { }
	
	func setupBinding() { }

}
