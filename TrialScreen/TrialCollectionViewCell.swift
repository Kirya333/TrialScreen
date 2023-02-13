//
//  TrialCollectionViewCell.swift
//  TrialScreen
//
//  Created by Кирилл Тарасов on 13.02.2023.
//

import UIKit

class TrialCollectionViewCell: UICollectionViewCell {
    
    private var topStackView: UIStackView!
    private var contentStackView: UIStackView!
    private var checkImageView: UIImageView!
    private var periodLabel: UILabel!
    private var priceLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    var period: String? {
        set {
            periodLabel.text = newValue
        }
        get {
            periodLabel.text
        }
    }
    
    var price: String? {
        set {
            priceLabel.text = newValue
        }
        get {
            priceLabel.text
        }
    }
    
    var infoDescription: String? {
        set {
            descriptionLabel.text = newValue
        }
        get {
            descriptionLabel.text
        }
    }
    
    private let backgroundViewColor = #colorLiteral(red: 0.9254901961, green: 0.9411764706, blue: 0.9529411765, alpha: 1)
    private let selectedBackgroundViewColor = #colorLiteral(red: 0.1411764706, green: 0.8509803922, blue: 0.4666666667, alpha: 1)
    private let cornerRadius: CGFloat = 10
    
    private let labelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private let periodLabelFont = UIFont(name: "SF Pro Display Bold", size: 20)
    private let priceLabelFont = UIFont(name: "SF Pro Display Heavy", size: 24)
    
    private let descriptionLabelTextColor = #colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
    private let descriptionLabelFont = UIFont(name: "SF Pro Display Regular", size: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        topStackView = UIStackView()
        contentStackView = UIStackView()
        checkImageView = UIImageView()
        periodLabel = UILabel()
        priceLabel = UILabel()
        descriptionLabel = UILabel()
        
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(topStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        topStackView.addArrangedSubview(checkImageView)
        topStackView.addArrangedSubview(periodLabel)
        topStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupUI() {
        backgroundColor = backgroundViewColor
        layer.cornerRadius = cornerRadius
        
        let selectedView = UIView()
        selectedView.backgroundColor = selectedBackgroundViewColor
        selectedView.layer.cornerRadius = cornerRadius
        selectedBackgroundView = selectedView
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = 8
        
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.spacing = 12
        
        checkImageView.image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate)
        checkImageView.isHidden = true
        checkImageView.contentMode = .scaleAspectFit
        checkImageView.tintColor = labelTextColor
        
        periodLabel.textColor = labelTextColor
        periodLabel.font = periodLabelFont
        
        priceLabel.textColor = labelTextColor
        priceLabel.font = priceLabelFont
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        priceLabel.setContentHuggingPriority(.required, for: .vertical)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        descriptionLabel.textColor = descriptionLabelTextColor
        descriptionLabel.font = descriptionLabelFont
        descriptionLabel.numberOfLines = 2
    }
    
    private func setConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: contentStackView.bottomAnchor, constant: 13),
            
            checkImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            checkImageView.isHidden = !isSelected
            descriptionLabel.textColor = isSelected ? labelTextColor : descriptionLabelTextColor
        }
    }
}
