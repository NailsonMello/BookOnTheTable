//
//  ExtensionColectionView+HomeViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 08/04/21.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == readingBookCollection) {
            let readingBookFiltered = listSearch.filter { $0.status == "Reading" }
            return readingBookFiltered.count
        }

        if (collectionView == toReadBookCollection) {
            let toReadBookFiltered = listSearch.filter { $0.status == "Para ler" }
            return toReadBookFiltered.count
        }

        if (collectionView == alreadyReadBookCollection) {
            let alreadyReadBookFiltered = listSearch.filter { $0.status == "Done" }
            return alreadyReadBookFiltered.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let readingBookCell = readingBookCollection.dequeueReusableCell(withReuseIdentifier: "readingBookId", for: indexPath) as! ReadingBookCollectionViewCell
        
        if (collectionView == readingBookCollection) {

            readingBookCell.configureCell(listSearch.filter { $0.status == "Reading" }[indexPath.item])
            return readingBookCell
        }
        
        if (collectionView == toReadBookCollection) {
            let toReadBookCell = toReadBookCollection.dequeueReusableCell(withReuseIdentifier: "toReadBookId", for: indexPath) as! ToReadBookCollectionViewCell
            toReadBookCell.configureCell(listSearch.filter { $0.status == "Para ler" }[indexPath.item])
            return toReadBookCell
        }

        if (collectionView == alreadyReadBookCollection) {
            let alreadyReadBookCell = alreadyReadBookCollection.dequeueReusableCell(withReuseIdentifier: "alreadyReadBookId", for: indexPath) as! AlreadyReadBookCollectionViewCell
            alreadyReadBookCell.configureCell(listSearch.filter { $0.status == "Done" }[indexPath.item])
            return alreadyReadBookCell
        }
        
        return readingBookCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detailsBooks") as! DetailsBookViewController

        if (collectionView == readingBookCollection) {
            controller.bookSelected = listSearch.filter { $0.status == "Reading" }[indexPath.item]
        }

        if (collectionView == toReadBookCollection) {
            controller.bookSelected = listSearch.filter { $0.status == "Para ler" }[indexPath.item]
        }

        if (collectionView == alreadyReadBookCollection) {
            controller.bookSelected = listSearch.filter { $0.status == "Done" }[indexPath.item]
        }

        self.navigationController?.pushViewController(controller, animated: true)
    }
}
