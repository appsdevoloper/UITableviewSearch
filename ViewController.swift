//
//  ViewController.swift
//  test
//
//  Created by Rajeshkumar on 07/06/17.
//  Copyright © 2017 ndotmac. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
  
  var allDetails:[(String,[String])] = []
  var searchResult:[(String,[String])] = []
  @IBOutlet weak var tableVIew: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
    
   private var floatingButton: UIButton?
   // TODO: Replace image name with your own image:
   private let floatingButtonImageName = "NAME OF YOUR IMAGE"
   private static let buttonHeight: CGFloat = 65.0
   private static let buttonWidth: CGFloat = 65.0
   private let roundValue = ViewController.buttonHeight/2
   private let trailingValue: CGFloat = 15.0
   private let leadingValue: CGFloat = 15.0
   private let shadowRadius: CGFloat = 2.0
   private let shadowOpacity: Float = 0.5
   private let shadowOffset = CGSize(width: 0.0, height: 5.0)
   private let scaleKeyPath = "scale"
   private let animationKeyPath = "transform.scale"
   private let animationDuration: CFTimeInterval = 0.4
   private let animateFromValue: CGFloat = 1.00
   private let animateToValue: CGFloat = 1.05
    
  override func viewDidLoad() {
    super.viewDidLoad()
    //New line of code! Be sure to set your search bar's delegate in viewDidLoad()
    allDetails = [("Vadavalli",["Vadvalli", "Mullai Nagar", "P.N.Pudhur"]),
                  ("R.S.Puram",["Lawly Road", "Kowly Brown", "D.B Road"]),
                  ("Town Hall",["Raja Street", "Gandhipark", "Five corner road", "Main Town Hall"])]
    searchResult = allDetails
    searchBar.delegate = self

    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
        textfield.textColor = UIColor.blue
        textfield.backgroundColor = UIColor.lightGray
    }
  }

    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult[section].1.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchResult[section].0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = searchResult[indexPath.section].1[indexPath.row]
        return cell!
    }
    
    //Let's get rid of this function
    /*
     func updateSearchResults(for searchController: UISearchController) {
     // SEARCH NOT WORKING
     if let searchText = searchController.searchBar.text {
     searchResult = allDetails.map({ (areaTitle:$0.0,areas:$0.1.filter({ $0.lowercased().contains(searchText) })) }).filter { !$0.1.isEmpty }
     //self.tableVIew.reloadData();
     }
     }*/
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    //And implement the UISearchBarDelegate method. This method fires every time that the search bar's text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = allDetails.map({ (areaTitle:$0.0,areas:$0.1.filter({ $0.lowercased().contains(searchText) })) }).filter { !$0.1.isEmpty }
        self.tableVIew.reloadData();
    }
    
    //MARK: Floating Button
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createFloatingButton()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        guard floatingButton?.superview != nil else {  return }
        DispatchQueue.main.async {
            self.floatingButton?.removeFromSuperview()
            self.floatingButton = nil
        }
        super.viewWillDisappear(animated)
    }
    
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        floatingButton?.backgroundColor = .white
        floatingButton?.setImage(UIImage(named: floatingButtonImageName), for: .normal)
        floatingButton?.addTarget(self, action: #selector(doThisWhenButtonIsTapped(_:)), for: .touchUpInside)
        constrainFloatingButtonToWindow()
        makeFloatingButtonRound()
        addShadowToFloatingButton()
        addScaleAnimationToFloatingButton()
    }
    
    // TODO: Add some logic for when the button is tapped.
    @IBAction private func doThisWhenButtonIsTapped(_ sender: Any) {
        print("Button Tapped")
    }
    
    private func constrainFloatingButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow,
                let floatingButton = self.floatingButton else { return }
            keyWindow.addSubview(floatingButton)
            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor,
                                                constant: self.trailingValue).isActive = true
            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor,
                                              constant: self.leadingValue).isActive = true
            floatingButton.widthAnchor.constraint(equalToConstant:
                ViewController.buttonWidth).isActive = true
            floatingButton.heightAnchor.constraint(equalToConstant:
                ViewController.buttonHeight).isActive = true
        }
    }
    
    private func makeFloatingButtonRound() {
        floatingButton?.layer.cornerRadius = roundValue
    }
    
    private func addShadowToFloatingButton() {
        floatingButton?.layer.backgroundColor = UIColor.green.cgColor
        floatingButton?.layer.shadowColor = UIColor.black.cgColor
        floatingButton?.layer.shadowOffset = shadowOffset
        floatingButton?.layer.masksToBounds = false
        floatingButton?.layer.shadowRadius = shadowRadius
        floatingButton?.layer.shadowOpacity = shadowOpacity
    }
    
    private func addScaleAnimationToFloatingButton() {
        // Add a pulsing animation to draw attention to button:
        /*DispatchQueue.main.async {
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: self.animationKeyPath)
            scaleAnimation.duration = self.animationDuration
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = self.animateFromValue
            scaleAnimation.toValue = self.animateToValue
            self.floatingButton?.layer.add(scaleAnimation, forKey: self.scaleKeyPath)
        }*/
    }
}

