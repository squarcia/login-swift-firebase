//
//  SignUpViewController.swift
//  CustomLogin
//
//  Created by Adelmo Brunelli on 09/05/2020.
//  Copyright © 2020 Adelmo Brunelli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNametextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
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
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNametextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    
    /*  Questo metodo controlla i campi dell'utente.
        Se tutto è corretto restituisce nil, altrimenti
        restituisce il messaggio di errore
    
     */
    func validateFields() -> String? {
        
        // controlla che tutti i campi siano inseriti
        
        if(firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ||
            lastNametextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            
            return "Per favore inserisci tutti i campi."
        }
        
        // controlla che la password è sicura
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (Utilities.isPasswordValid(cleanedPassword) == false) {
            // la password non è sicura abbastanza
            
            return "Assicurati che la tua password sia almeno 8 caratteri, contanga un carattere speciale e un numero."
        }
        
        return nil
    }
   
    
    
    // qui controlliamo i tap
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validare i campi
        let error = validateFields()
        
        if error != nil {
            
            // c'è qualcosa di sbagliato con i campi, mostrare l'errore
            showError(error!)
        }else{
            
            // creo una versione dei dati
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNametextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            
            // creare l'utente
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // controlliamo gli errori
                if err != nil {
                    // c'è un errore (altrimenti err varrebbe nil
                    self.showError("Errore nella creazione dell'utente")
                }else{
                    
                    // l'utente è stato creato correttamente, memorizziamo nome e cognome
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            self.showError("Errore nel salvataggio dei dati")
                        }
                        
                    }
                     // mandarlo alla home screen
                    self.transitionToHome()
                    
                }
                
                
                
                
            }
                      
               
            
        }
        
   
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    

}
