//
//  BackdropHeaderView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

// TODO: Kingfisher 제거?
import SnapKit
import Kingfisher
import UIKit

class BackdropHeaderView: BaseTableViewHeaderView {
    
    var images: [Backdrop] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        
        return pageControl
    }()
    
    let dateImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .Gray2
        
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "2024-12-24"
        label.textColor = .Gray2
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    let rateImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .Gray2
        
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "8.0"
        label.textColor = .Gray2
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    let genreImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "film.fill")
        imageView.tintColor = .Gray2
        
        return imageView
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        
        label.text = "액션, 스릴러"
        label.textColor = .Gray2
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        
        title.textColor = .W
        title.font = .systemFont(ofSize: 18, weight: .bold)
        
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.configuration = config
        
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
}

extension BackdropHeaderView: ViewProtocol {
    
    func configureSubview() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        infoStackView.addArrangedSubview(dateImageView)
        infoStackView.addArrangedSubview(dateLabel)
        infoStackView.addArrangedSubview(rateImageView)
        infoStackView.addArrangedSubview(rateLabel)
        infoStackView.addArrangedSubview(genreImageView)
        infoStackView.addArrangedSubview(genreLabel)
        
        contentView.addSubview(infoStackView)
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(button)
        
        contentView.addSubview(stackView)
    }
    
    func configureConstraint() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        pageControl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(collectionView.snp.bottom).inset(12)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView).inset(70)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.top.equalTo(infoStackView.snp.bottom).offset(12)
            make.bottom.equalTo(contentView)
        }
    }
    
    func configureStyle(buttonTitle: String, buttonIsHidden: Bool = true) {
        let container = AttributeContainer(
            [.font: UIFont.systemFont(ofSize: 15, weight: .heavy)])
        
        button.configuration?.attributedTitle = AttributedString(buttonTitle, attributes: container)
        button.isHidden = buttonIsHidden
    }
    
    func configureWithData(sectionTitle: String) {
        title.text = sectionTitle
    }
}

// TODO: - 이걸 어떻게 할 것인가..어쨌든 이것도 뷰조작하는거니까 밖으로 빼는게 맞지않나?
extension BackdropHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // TODO: - 이미지 다섯개로 제한하기
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.identifier, for: indexPath) as! BackdropCollectionViewCell
        
        // TODO: - 다운샘플링
        let url = URL(string: MovieURL.image + images[indexPath.row].file_path)
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.visibleSize.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        pageControl.currentPage = currentPage
    }
}
