//
//  LoginViewController.swift
//  CustomLogin
//
//  Created by Adelmo Brunelli on 09/05/2020.
//  Copyright © 2020 Adelmo Brunelli. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    

    func setUpElements(){
        
        // nascondiamo la error label
        errorLabel.alpha = 0
         
        // aggiungiamo lo stile agli elementi
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
        
        
    }
    
    // qui controlliamo i tap, creiamo i metodi
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // validiamo i campi
        
        // creo una versione pulita dei dati
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // loggiamo l'utente
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil{
                // non puoi accedere
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                // transition to home screen
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
              
                
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                      
            }
        }
        
    }
    
    

}
