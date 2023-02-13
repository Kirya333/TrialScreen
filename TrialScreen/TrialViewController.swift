//
//  TrialViewController.swift
//  TrialScreen
//
//  Created by Кирилл Тарасов on 13.02.2023.
//

import UIKit

class TrialViewController: UIViewController {

    private var contentView: UIView!
    private var labelStackView: UIStackView!
    private var buttonStackView: UIStackView!
    private var titleLable: UILabel!
    private var subtitleLabel: UILabel!
    private var collectionView: UICollectionView!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var subscribeButton: UIButton!
    private var restoreButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!
    
    private var cellSize: CGSize {
        get {
            CGSize(width: collectionView.bounds.width, height: 105)
        }
    }
    
    private let backgroundViewColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    private let titleLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private let titleLabelFont = UIFont(name: "SF Pro Display Black", size: 26)
    private let titleLabelText = "Приложение платное"
    
    private let subtitleLabelColor = #colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
    private let subtitleLabelFont  = UIFont(name: "SF Pro Display Regular", size: 18)
    private let subtitleLabelText = "Выберите удобный для вас способ\nоплаты"
    
    private let subscribeButtonColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private let subscribeButtonTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private let subscribeButtonCornerRadius: CGFloat = 25
    private let subscribeButtonFont = UIFont(name: "SF Pro Display Semibold", size: 16)
    private let subscribeButtonText = "Оформить подписку"
    
    private let restoreButtonColor = UIColor.clear
    private let restoreButtonTextColor = #colorLiteral(red: 0.6, green: 0.6352941176, blue: 0.6784313725, alpha: 1)
    private let restoreButtonFont = UIFont(name: "SF Pro Display Semibold", size: 16)
    private let restoreButtonText = "Восстановить покупки"
    
    private let activityIndicatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    private var viewData = [TrialViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
        setupUI()
        setConstraints()
        setViewData()
    }

    private func createUI() {
        contentView = UIView()
        labelStackView = UIStackView()
        buttonStackView = UIStackView()
        titleLable = UILabel()
        subtitleLabel = UILabel()
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        subscribeButton = UIButton()
        restoreButton = UIButton()
        activityIndicator = UIActivityIndicatorView()
        
        view.addSubview(contentView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(buttonStackView)
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
        labelStackView.addArrangedSubview(titleLable)
        labelStackView.addArrangedSubview(subtitleLabel)
        buttonStackView.addArrangedSubview(subscribeButton)
        buttonStackView.addArrangedSubview(restoreButton)
    }
    
    private func setupUI() {
        view.backgroundColor = backgroundViewColor
        
        titleLable.text = titleLabelText
        titleLable.textAlignment = .center
        titleLable.font = titleLabelFont
        titleLable.textColor = titleLabelColor
        titleLable.setContentHuggingPriority(.required, for: .vertical)
        titleLable.setContentCompressionResistancePriority(.required, for: .vertical)
        
        subtitleLabel.text = subtitleLabelText
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = subtitleLabelFont
        subtitleLabel.textColor = subtitleLabelColor
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 16
        
        collectionViewFlowLayout.minimumLineSpacing = 16
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TrialCollectionViewCell.self, forCellWithReuseIdentifier: "TrialCollectionViewCell")
        
        subscribeButton.setTitle(subscribeButtonText, for: .normal)
        subscribeButton.setTitleColor(subscribeButtonTextColor, for: .normal)
        subscribeButton.backgroundColor = subscribeButtonColor
        subscribeButton.layer.cornerRadius = subscribeButtonCornerRadius
        subscribeButton.addTarget(self, action: #selector(actionSubscribe), for: .touchUpInside)
        
        restoreButton.setTitle(restoreButtonText, for: .normal)
        restoreButton.backgroundColor = restoreButtonColor
        restoreButton.setTitleColor(restoreButtonTextColor, for: .normal)
        restoreButton.addTarget(self, action: #selector(actionRestore), for: .touchUpInside)
        
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8
        
        activityIndicator.style = .medium
        activityIndicator.color = activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    private func setConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor, constant: 0),
            
            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 48),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0),
            
            buttonStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 0),
            
            subscribeButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: subscribeButton.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: subscribeButton.centerYAnchor, constant: 0)
        ])
    }
    
    private func setViewData() {
        var dataOne = TrialViewData()
        dataOne.period = "6 месяцев"
        dataOne.price = "1990 руб."
        dataOne.info = "Пробный период три дня, бесплатная отмена"
        
        var dataTwo = TrialViewData()
        dataTwo.period = "1 месяц"
        dataTwo.price = "499 руб."
        dataTwo.info = "Ежемесячная подписка"
        
        var dataThree = TrialViewData()
        dataThree.period = "Навсегда"
        dataThree.price = "4990 руб."
        dataThree.info = "Один платеж"
        
        viewData.append(contentsOf: [dataOne, dataTwo, dataThree])
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewFlowLayout.invalidateLayout()
    }
    
    @objc
    private func actionSubscribe(_ sender: UIButton) {
        guard let indexPathForSelectedItem = collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        interface(block: true)
        print(viewData[indexPathForSelectedItem.row])
        //MARK: - Код оформления подписки
    }
    
    @objc
    private func actionRestore(_ sender: UIButton) {
        //MARK: - Код восстановления покупок
    }
    
    func interface(block: Bool) {
        view.isUserInteractionEnabled = !block
        subscribeButton.setTitle(block ? "" : subscribeButtonText, for: .normal)
        block ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension TrialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrialCollectionViewCell", for: indexPath) as! TrialCollectionViewCell
        let data = viewData[indexPath.row]
        cell.period = data.period
        cell.price = data.price
        cell.infoDescription = data.info
        return cell
    }
}

extension TrialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}
