import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let myArray: NSArray = ["Monday","Tuesday","Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    
    //dosage text field
    let myTextField: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width-100)/2), y: ((UIScreen.main.bounds.height-200)/2), width: 100.00, height: 30.00))
    //mg
    let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2+60), y: ((UIScreen.main.bounds.height-200)/2), width: 30, height: 30))
    //enter your dosage in mg
    let label2 = UILabel(frame: CGRect(x: 0, y: ((UIScreen.main.bounds.height-300)/2), width: UIScreen.main.bounds.width, height: 30))
    //alert
    let alert = UIAlertController(title: "Are you sure you would like to save?", message: "If you would like to save, press yes. Else, press no.", preferredStyle: .alert)
    
    
    let myTableView: UITableView = {
        let myTable = UITableView()
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        return myTable
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    
    let button : UIButton = {
        let b = UIButton()
        b.backgroundColor = .red //UIColor(displayP3Red: 0, green: 122, blue: 255, alpha: 0)
        b.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return b
    }()
    
    let button2 : UIButton = {
        let b2 = UIButton()
        b2.backgroundColor = .red //UIColor(displayP3Red: 0, green: 122, blue: 255, alpha: 0)
        b2.addTarget(self, action: #selector(button2Click), for: .touchUpInside)
        return b2
    }()
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        setupScrollView()
        super.viewDidLoad()
        setupButton()
        setupButton2()
        setupTextField()
        setupLabel1()
        setupLabel2()
        setupTableView()
        createToolbar()
        //weekView.setGestureRecognizer(gestureRecognizerType: UITapGestureRecognizer())
    }
    
    fileprivate func setupButton(){
        
        view.addSubview(button)
        
        //button placement
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0,*) {
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        } else {
            // Fallback on earlier versions
        }
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        
        //button info
        button.setTitle("Return",for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 20)
    }
    
    fileprivate func setupButton2(){
        
        view.addSubview(button2)
        
        //button placement
        button2.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0,*) {
            button2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height/2).isActive = true
        } else {
            // Fallback on earlier versions
        }
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -158).isActive = true
        
        //button info
        button2.setTitle("Next",for: .normal)
        button2.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 20)
    }
    
    @objc func buttonClick(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func button2Click(){
        let fourthController = AddPillViewController()
        navigationController?.pushViewController(fourthController, animated: true)
        print("Button 2 clicked")
    }
    
    fileprivate func setupTextField(){
        myTextField.placeholder = "Dosage"
        myTextField.textAlignment = .center
        myTextField.borderStyle = UITextBorderStyle.line
        myTextField.backgroundColor = UIColor.white
        myTextField.textColor = .red //UIColor(displayP3Red: 0, green: 122, blue: 255, alpha: 0)
        self.view.addSubview(myTextField)
        myTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    fileprivate func setupLabel2(){
        label.textAlignment = .center
        label.text = "mg"
        self.view.addSubview(label)
    }
    
    fileprivate func setupTableView(){
        view.addSubview(myTableView)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
    }
    
    fileprivate func setupLabel1(){
        label2.textAlignment = .center
        label2.text = "Type in the dosage below (in mg)"
        self.view.addSubview(label2)
    }
    
    fileprivate func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .red //UIColor(displayP3Red: 246, green: 246, blue: 246, alpha: 0)
        toolBar.tintColor = .red //UIColor(displayP3Red: 0, green: 122, blue: 255, alpha: 0)
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc fileprivate func doneButtonPressed(){
        dismissKeyboard()
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setupScrollView(){
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
