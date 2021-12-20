//
//  SeriesViewController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import UIKit
import RxSwift

class SeriesViewController: UIViewController {
    
    var viewModel: SeriesViewModel?
    private let disposeBag = DisposeBag()
    private var model: [SeriesModel]? {
        viewModel?.items.value
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.isUserInteractionEnabled = true
        textField.placeholder = "xxxx"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        return textField
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    //MARK: - LigeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        viewModel?.viewDidLoad()
    }
}

//MARK: - private methods
private extension SeriesViewController {
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchTextField)
        contentView.addSubview(stackView)
        
        setupConstraints()
        setupRxCocoa()
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),

            stackView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
        
    func setupBinding() {
        viewModel?.items.bind(listener: { [weak self] items in
            self?.stackView.arrangedSubviews.forEach({ view in
                view.removeFromSuperview()
            })
            
            guard let items = items else { return }
            for (index, serieModel) in items.enumerated() {
                let label = UILabel()
                label.text = serieModel.title
                label.isUserInteractionEnabled = true
                label.tag = index
                
                label.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(self?.didSelectLabel(sender:))))
                self?.stackView.addArrangedSubview(label)
            }
        })
    }
    
    func setupRxCocoa() {
        searchTextField
            .rx
            .text
            .observe(on: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .map( { text in
                if let text = text,
                   !text.isEmpty {
                    self.viewModel?.searchSeries(text: text)
                }
            }).subscribe()
            .disposed(by: disposeBag)
    }
}

private extension SeriesViewController {
    @objc func didSelectLabel(sender: UITapGestureRecognizer) {
        guard let indexSelected = sender.view?.tag else { return }
            let controller = viewModel?.didSelect(indexSelected)
    }
}
