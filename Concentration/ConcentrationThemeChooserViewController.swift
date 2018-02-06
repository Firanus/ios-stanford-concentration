//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Ivan Tchernev on 05/02/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
 
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    @IBAction func changeTheme(_ sender: UIButton) {
        if let theme = getThemeFromButton(sender) {
            if let cvc = splitViewDetailConcentrationViewController {
                cvc.theme = theme
            } else if let cvc = lastSeguedToConcentrationViewController {
                cvc.theme = theme
                navigationController?.pushViewController(cvc, animated: true)
            } else {
                performSegue(withIdentifier: "Choose Theme", sender: sender)
            }
        }
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        //Counter-intuitively, if we DO NOT want to collapse the secondary onto the primary, we have to return true.
        //In our situation, if a theme has been set, do the collapse (so we see the secondary). Otherwise, do not
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme != nil {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton, let theme = getThemeFromButton(button) {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    
    private func getThemeFromButton(_ sender: UIButton) -> GameTheme? {
        //This is terrible behaviour. I'm identifying the theme to pick based off of the button's name, which makes the code very brittle. However, it will do for our purposes for the moment.
        if let themeName = sender.currentTitle {
            var theme: GameTheme
            switch themeName {
            case "Halloween":
                theme = .Halloween
            case "Sports":
                theme = .Sports
            case "Religion":
                theme = .Religion
            case "Japan":
                theme = .Japan
            default:
                theme = .Halloween
            }
            return theme
        }
        return nil
    }

}
