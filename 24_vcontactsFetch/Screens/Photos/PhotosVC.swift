//
//  FriendViewController.swift
//  21_Table_Contacts
//
//  Created by ALexFount on 19.05.22.
//

import UIKit

class PhotosVC: UIViewController, UIScrollViewDelegate{
    
    var personRow = 0
    var friends: [FriendModel] = []
    
    var photosAPI = PhotosAPI()
    var photos: [PhotoModel] = []
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scrollViewToZoom: UIScrollView!
    
    @IBOutlet weak var largeImage: UIImageView!
    
    var header = HeaderCollectionView()
    //MARK: - Private properties
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
        
    }()
    
    // MARK: -  ловим scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollY = -collectionView.contentOffset.y
        print(scrollY)
        let topInsets = view.safeAreaInsets.top
        print("hh", topInsets)
        header.imageHeight.constant = header.bounds.height + scrollY //- topInsets / 2.5
        //header.imageHeight.constant = max(header.bounds.height, header.bounds.height + scrollY - topInsets)
        
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let friend = friends[personRow]
        
        setupView()
        setupZoomView()
        
        photosAPI.fetchPhotos { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            self.collectionView.reloadData()
        }
        
    }
    
    // Zoom or Hide large image
    
    func setupZoomView(){
        containerView.alpha = 0
        
        self.scrollViewToZoom.minimumZoomScale = 1.0
        self.scrollViewToZoom.maximumZoomScale = 6.0
        
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(closeImage))
        gestureRecogniser.numberOfTapsRequired = 2
        gestureRecogniser.numberOfTouchesRequired = 1
        containerView.addGestureRecognizer(gestureRecogniser)
        containerView.isUserInteractionEnabled = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.largeImage
    }
    
    @objc func openImage(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.containerView.alpha = 1
            self.containerView.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    @objc func closeImage(){
        
        containerView.transform = CGAffineTransform.identity //трансформ на исходный размер
        self.scrollViewToZoom.setZoomScale(0.1, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.containerView.alpha = 0
            self.tabBarController?.tabBar.isHidden = false
            
            
        }//completion: { <#Bool#> in
        //            <#code#>
        //        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        closeImage()
    }
    
    //MARK: - Private methods
    private  func setupView(){
        
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        self.view.bringSubviewToFront(containerView)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    //MARK: - Header настройка
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.identifier, for: indexPath) as! HeaderCollectionView
        //let friend = friends[personRow]
        //let friend = friends[1]
        
        header.configure("Славик ===")
        header.imageHeight.constant = header.bounds.height + view.safeAreaInsets.top * 0.6
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)      // высота header
    }
    
}

//MARK: = CollectionViewDelegate

extension PhotosVC: UICollectionViewDelegate { //тап по ячейке
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        largeImage.sd_setImage(with: URL(string: photos[indexPath.row].presentPhotos.maxPhoto))
        openImage()
        
        print("Item selected", indexPath.row)
    }
    
}

//MARK: = CollectionViewDataSource
extension PhotosVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        cell.backgroundColor = .lightGray
        cell.contentMode = .scaleAspectFill
        //        cell.configure("design\(indexPath.row + 1)", 123) //передача данных в ячейку галереи
        
//        cell.photoImageView.sd_setImage(with: URL(string: photos[indexPath.row].averagePhoto))
        cell.photoImageView.sd_setImage(with: URL(string: photos[indexPath.row].presentPhotos.minPhoto))

        return cell
        
    }
    
}
extension PhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset:CGFloat = 10 // отступ
        let itemsInCols: CGFloat = 3 // количество колонок
        let widthForItem = (collectionView.bounds.width + inset) / itemsInCols - inset
        let heightForItem = widthForItem * 1.3
        return CGSize(width: widthForItem, height: heightForItem) //размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 2, left: 0, bottom: 10, right: 0) //поля  секции
    }
}
