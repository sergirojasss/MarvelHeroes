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
        textField.placeholder = Constans.placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        return textField
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.spacing = Constans.spaceing
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

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constans.margin),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constans.margin),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constans.margin),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: Constans.searchTextFieldHeight),

            stackView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constans.spaceing),
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
            .throttle(.milliseconds(Constans.twoSeconds), scheduler: MainScheduler.instance)
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
        guard let indexSelected = sender.view?.tag,
              let controller = viewModel?.didSelect(indexSelected) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - Constants
private enum Constans {
    static let placeholder = "Which comic are you looking for?"
    static let margin: CGFloat = 20
    static let spaceing: CGFloat = 20
    static let searchTextFieldHeight: CGFloat = 50
    static let twoSeconds = 2000
}

