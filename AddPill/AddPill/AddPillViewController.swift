
import Foundation
import UIKit

class AddPillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    private let myArray: NSArray = ["Monday","Tuesday","Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let optionTextField1 = UITextField()
    let hourList: NSArray = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    let minuteList: NSArray = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let dayTimeList: NSArray = ["AM", "PM"]
    let textField: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+765), width: 200, height: 30))
    var pickerView: UIPickerView!
    let numberOfComponents = 3;
    var temp = "0";
    
    //dosage text field
    let myTextField: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width-100)/2), y: ((UIScreen.main.bounds.height-200)/2), width: 100.00, height: 30.00))
    //# of times text field
    let secondTextField: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width-100)/2), y: ((UIScreen.main.bounds.height)/2+540), width: 100, height: 30))
    //mg
    let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2+60), y: ((UIScreen.main.bounds.height-200)/2), width: 30, height: 30))
    //enter your dosage in mg
    let label2 = UILabel(frame: CGRect(x: 0, y: ((UIScreen.main.bounds.height-300)/2), width: UIScreen.main.bounds.width, height: 30))
    //select your days
    let label3 = UILabel(frame: CGRect(x: 0, y: ((UIScreen.main.bounds.height)/2), width: UIScreen.main.bounds.width, height: 30))
    //type in the number of times
    let label4 = UILabel(frame: CGRect(x: 0, y: ((UIScreen.main.bounds.height)/2+495), width: UIScreen.main.bounds.width, height: 30))
    //times/day
    let label5 = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2+40), y: ((UIScreen.main.bounds.height+1080)/2), width: 120, height: 30))
    //enter pill times below
    let label6 = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2-200), y: ((UIScreen.main.bounds.height)/2+655), width: 400, height: 30))
    //enter pill times below
    let label7 = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2-150), y: ((UIScreen.main.bounds.height)/2+675), width: 300, height: 30))
    //regular alert
    let alert = UIAlertController(title: "Are you sure you would like to save?", message: "If you would like to edit the information, press no. ", preferredStyle: .alert)
    
    
    
    
    let myTableView: UITableView = {
        let myTable = UITableView(frame: CGRect(x: 0, y: ((UIScreen.main.bounds.height)/2+40), width: UIScreen.main.bounds.width, height: 380))
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
        let b = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width-120), y: 20, width: 100, height: 30))
        //b.backgroundColor = UIColor(red: 0, green: 122, blue: 255)
        
        
        b.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return b
    }()
    
    
    let button2 : UIButton = {
        let b2 = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width-100)/2, y: UIScreen.main.bounds.height+800, width: 100, height: 30))
       // b2.backgroundColor = UIColor(red: 0, green: 122, blue: 255)
        
        
        b2.addTarget(self, action: #selector(button2Click), for: .touchUpInside)
        return b2
    }()
    
    
    
    
    let quantityTextField1: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+765), width: 100, height: 30))
    fileprivate func setupQuantityTextField1(){
        quantityTextField1.placeholder = "#"
        quantityTextField1.textAlignment = .center
        quantityTextField1.borderStyle = UITextBorderStyle.line
        quantityTextField1.backgroundColor = UIColor.white
        //quantityTextField1.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField1)
        quantityTextField1.keyboardType = UIKeyboardType.decimalPad
    }
    
    fileprivate func createToolbar7(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
       // toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton7Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField1.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton7Pressed(){
        dismissKeyboard()
    }
    
    let quantityTextField2: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+815), width: 100, height: 30))
    fileprivate func setupQuantityTextField2(){
        quantityTextField2.placeholder = "#"
        quantityTextField2.textAlignment = .center
        quantityTextField2.borderStyle = UITextBorderStyle.line
        quantityTextField2.backgroundColor = UIColor.white
       // quantityTextField2.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField2)
        quantityTextField2.keyboardType = UIKeyboardType.decimalPad
        quantityTextField2.isHidden = true
    }
    
    fileprivate func createToolbar8(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton8Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField2.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton8Pressed(){
        dismissKeyboard()
    }
    let quantityTextField3: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+865), width: 100, height: 30))
    fileprivate func setupQuantityTextField3(){
        quantityTextField3.placeholder = "#"
        quantityTextField3.textAlignment = .center
        quantityTextField3.borderStyle = UITextBorderStyle.line
        quantityTextField3.backgroundColor = UIColor.white
        //quantityTextField3.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField3)
        quantityTextField3.keyboardType = UIKeyboardType.decimalPad
        quantityTextField3.isHidden = true
    }
    
    fileprivate func createToolbar9(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
//        toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
//        toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton9Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField3.inputAccessoryView = toolBar
        
    }
    @objc fileprivate func doneButton9Pressed(){
        dismissKeyboard()
    }
    let quantityTextField4: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+915), width: 100, height: 30))
    fileprivate func setupQuantityTextField4(){
        quantityTextField4.placeholder = "#"
        quantityTextField4.textAlignment = .center
        quantityTextField4.borderStyle = UITextBorderStyle.line
        quantityTextField4.backgroundColor = UIColor.white
        //quantityTextField4.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField4)
        quantityTextField4.keyboardType = UIKeyboardType.decimalPad
        quantityTextField4.isHidden = true
    }
    fileprivate func createToolbar10(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton10Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField4.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton10Pressed(){
        dismissKeyboard()
    }
    let quantityTextField5: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+965), width: 100, height: 30))
    fileprivate func setupQuantityTextField5(){
        quantityTextField5.placeholder = "#"
        quantityTextField5.textAlignment = .center
        quantityTextField5.borderStyle = UITextBorderStyle.line
        quantityTextField5.backgroundColor = UIColor.white
        //quantityTextField5.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField5)
        quantityTextField5.keyboardType = UIKeyboardType.decimalPad
        quantityTextField5.isHidden = true
    }
    fileprivate func createToolbar12(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton12Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField5.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton12Pressed(){
        dismissKeyboard()
    }
    
    let quantityTextField6: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+65), y: ((UIScreen.main.bounds.height)/2+1015), width: 100, height: 30))
    fileprivate func setupQuantityTextField6(){
        quantityTextField6.placeholder = "#"
        quantityTextField6.textAlignment = .center
        quantityTextField6.borderStyle = UITextBorderStyle.line
        quantityTextField6.backgroundColor = UIColor.white
        //quantityTextField6.textColor = UIColor(red: 0, green: 122, blue: 255)
        self.scrollView.addSubview(quantityTextField6)
        quantityTextField6.keyboardType = UIKeyboardType.decimalPad
        quantityTextField6.isHidden = true
    }
    fileprivate func createToolbar14(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton14Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        quantityTextField6.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton14Pressed(){
        dismissKeyboard()
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        setupScrollView()
        
        //weekView.setGestureRecognizer(gestureRecognizerType: UITapGestureRecognizer())
    }
    
    
    
    
    fileprivate func setupButton(){
        scrollView.addSubview(button)
        //button info
        button.setTitle("Return",for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 20)
    }
    
    
    
    
    fileprivate func setupButton2(){
        scrollView.addSubview(button2)
        //button info
        button2.setTitle("Next",for: .normal)
        button2.titleLabel?.font =  UIFont(name: "Avenir-Light", size: 20)
    }
    
    
    
    
    fileprivate func setupTableView(){
        scrollView.addSubview(myTableView)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        
        
        // Configure the cell...
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        
        
        if cell.isSelected
        {
            cell.isSelected = false
            if cell.accessoryType == UITableViewCellAccessoryType.none
            {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        
        
        if (cell!.isSelected)
        {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCellAccessoryType.none
            {
                cell!.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {
                cell!.accessoryType = UITableViewCellAccessoryType.none
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return myArray.count
    }
    
    @objc func buttonClick(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @objc func button2Click(){
//        let fourthController = FirstViewController()
//        navigationController?.pushViewController(fourthController, animated: true)
    }
    
    
    
    
    fileprivate func setupTextField(){
        myTextField.placeholder = "Dosage"
        myTextField.textAlignment = .center
        myTextField.borderStyle = UITextBorderStyle.line
        myTextField.backgroundColor = UIColor.white
        //myTextField.textColor = UIColor(red: 0, green: 122, blue: 255)
        
        
        self.scrollView.addSubview(myTextField)
        myTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    
    fileprivate func setupTextField2(){
        secondTextField.placeholder = "# of times"
        secondTextField.textAlignment = .center
        secondTextField.borderStyle = UITextBorderStyle.line
        secondTextField.backgroundColor = UIColor.white
        //secondTextField.textColor = UIColor(red: 0, green: 122, blue: 255)
        
        
        self.scrollView.addSubview(secondTextField)
        secondTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    
    
    
    fileprivate func setupLabel2(){
        label.textAlignment = .center
        label.text = "mg"
        self.scrollView.addSubview(label)
    }
    
    
    
    
    fileprivate func setupLabel1(){
        label2.textAlignment = .center
        label2.text = "Type in the dosage below (in mg)"
        label2.font = UIFont.boldSystemFont(ofSize: label2.font.pointSize)
        self.scrollView.addSubview(label2)
    }
    
    
    fileprivate func setupLabel3(){
        label3.textAlignment = .center
        label3.text = "Please select the days you will take this pill"
        label3.font = UIFont.boldSystemFont(ofSize: label3.font.pointSize)
        self.scrollView.addSubview(label3)
    }
    fileprivate func setupLabel4(){
        label4.textAlignment = .center
        label4.text = "Enter number of times each day (1 to 6)"
        label4.font = UIFont.boldSystemFont(ofSize: label4.font.pointSize)
        self.scrollView.addSubview(label4)
    }
    
    
    fileprivate func setupLabel5(){
        label5.textAlignment = .center
        label5.text = "Times/day"
        self.scrollView.addSubview(label5)
    }
    fileprivate func setupLabel6(){
        label6.textAlignment = .center
        label6.font = UIFont.boldSystemFont(ofSize: label6.font.pointSize)
        label6.text = "Enter the times you will take the pills and the"
        self.scrollView.addSubview(label6)
    }
    fileprivate func setupLabel7(){
        label7.textAlignment = .center
        label7.font = UIFont.boldSystemFont(ofSize: label7.font.pointSize)
        label7.text = "quantity at each time (e.g. 1, 1.5, .5)"
        self.scrollView.addSubview(label7)
    }
    
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    @objc fileprivate func doneButtonPressed(){
        dismissKeyboard()
    }
    
    @objc fileprivate func doneButton2Pressed(){
        temp = secondTextField.text!
        dismissKeyboard()
        if temp=="2" || temp=="3" || temp=="4" || temp=="5" || temp=="6" {
            self.textField2.isHidden = false
            self.quantityTextField2.isHidden = false
        }
        if temp=="3" || temp=="4" || temp=="5" || temp=="6" {
            self.textField3.isHidden = false
            self.quantityTextField3.isHidden = false
        }
        if temp=="4" || temp=="5" || temp=="6" {
            self.textField4.isHidden = false
            self.quantityTextField4.isHidden = false
        }
        if temp=="5" || temp=="6" {
            self.textField5.isHidden = false
            self.quantityTextField5.isHidden = false
        }
        if temp=="6" {
            self.textField6.isHidden = false
            self.quantityTextField6.isHidden = false
        }
    }
    @objc fileprivate func doneButton3Pressed(){
        dismissKeyboard()
    }
    @objc fileprivate func doneButton4Pressed(){
        dismissKeyboard()
    }
    
    fileprivate func setupTextField3(){
        textField.borderStyle = UITextBorderStyle.line
    }
    
    fileprivate func setupTextField4(){
        textField2.borderStyle = UITextBorderStyle.line
        textField2.isHidden = true
    }
    
    fileprivate func setupTextField5(){
        textField3.borderStyle = UITextBorderStyle.line
        textField3.isHidden = true
    }
    
    fileprivate func setupTextField6(){
        textField4.borderStyle = UITextBorderStyle.line
        textField4.isHidden = true
    }
    
    fileprivate func setupTextField7(){
        textField5.borderStyle = UITextBorderStyle.line
        textField5.isHidden = true
    }
    fileprivate func setupTextField8(){
        textField6.borderStyle = UITextBorderStyle.line
        textField6.isHidden = true
    }
    
    
    
    fileprivate func setUpPickerView1(){
        self.scrollView.addSubview(textField)
        textField.placeholder = "Click for 1st pill time"
        textField.textAlignment = .center
        self.pickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        textField.inputView = self.pickerView
        self.pickerView.backgroundColor = UIColor.white
        textField.inputView = self.pickerView
    }
    
    
    
    let textField2: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+815), width: 200, height: 30))
    
    
    
    var pickerView2: UIPickerView!
    
    
    fileprivate func setUpPickerView2(){
        self.scrollView.addSubview(textField2)
        textField2.placeholder = "Click for 2nd pill time"
        textField2.textAlignment = .center
        self.pickerView2 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView2.delegate = self
        self.pickerView2.dataSource = self
        textField2.inputView = self.pickerView
        self.pickerView2.backgroundColor = UIColor.white
        textField2.inputView = self.pickerView2
    }
    fileprivate func createToolbar4(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton4Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField2.inputAccessoryView = toolBar
    }
    
    let textField3: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+865), width: 200, height: 30))
    var pickerView3: UIPickerView!
    
    
    fileprivate func setUpPickerView3(){
        self.scrollView.addSubview(textField3)
        textField3.placeholder = "Click for 3rd pill time"
        textField3.textAlignment = .center
        self.pickerView3 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView3.delegate = self
        self.pickerView3.dataSource = self
        textField3.inputView = self.pickerView
        self.pickerView3.backgroundColor = UIColor.white
        textField3.inputView = self.pickerView3
    }
    fileprivate func createToolbar5(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton5Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField3.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton5Pressed(){
        dismissKeyboard()
    }
    
    let textField4: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+915), width: 200, height: 30))
    var pickerView4: UIPickerView!
    
    
    fileprivate func setUpPickerView4(){
        self.scrollView.addSubview(textField4)
        textField4.placeholder = "Click for 4th pill time"
        textField4.textAlignment = .center
        self.pickerView4 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView4.delegate = self
        self.pickerView4.dataSource = self
        textField4.inputView = self.pickerView
        self.pickerView4.backgroundColor = UIColor.white
        textField4.inputView = self.pickerView4
    }
    fileprivate func createToolbar6(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton6Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField4.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton6Pressed(){
        dismissKeyboard()
    }
    
    let textField5: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+965), width: 200, height: 30))
    var pickerView5: UIPickerView!
    
    
    fileprivate func setUpPickerView5(){
        self.scrollView.addSubview(textField5)
        textField5.placeholder = "Click for 5th pill time"
        textField5.textAlignment = .center
        self.pickerView5 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView5.delegate = self
        self.pickerView5.dataSource = self
        textField5.inputView = self.pickerView
        self.pickerView5.backgroundColor = UIColor.white
        textField5.inputView = self.pickerView5
    }
    fileprivate func createToolbar11(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton8Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField5.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton11Pressed(){
        dismissKeyboard()
    }
    
    let textField6: UITextField = UITextField(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+1015), width: 200, height: 30))
    var pickerView6: UIPickerView!
    
    
    fileprivate func setUpPickerView6(){
        self.scrollView.addSubview(textField6)
        textField6.placeholder = "Click for 6th pill time"
        textField6.textAlignment = .center
        self.pickerView6 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerView6.delegate = self
        self.pickerView6.dataSource = self
        textField6.inputView = self.pickerView
        self.pickerView6.backgroundColor = UIColor.white
        textField6.inputView = self.pickerView6
    }
    fileprivate func createToolbar13(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton8Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField6.inputAccessoryView = toolBar
    }
    @objc fileprivate func doneButton13Pressed(){
        dismissKeyboard()
    }
    
    
    
    
    
    
    
    
    fileprivate func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        myTextField.inputAccessoryView = toolBar
    }
    
    
    fileprivate func createToolbar2(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton2Pressed))
        toolBar.setItems([doneButton2], animated: false)
        toolBar.isUserInteractionEnabled = true
        secondTextField.inputAccessoryView = toolBar
    }
    
    
    
    
    fileprivate func createToolbar3(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        //toolBar.barTintColor = UIColor(red: 246, green: 246, blue: 246)
        //toolBar.tintColor = UIColor(red: 0, green: 122, blue: 255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton3Pressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    let description1 = UILabel(frame: CGRect(x: ((UIScreen.main.bounds.width)/2-165), y: ((UIScreen.main.bounds.height)/2+725), width: 200, height: 30))
    
    
    fileprivate func setupDescription1(){
        description1.textAlignment = .center
        description1.text = "Times"
        self.scrollView.addSubview(description1)
    }
    
    let description2 = UILabel(frame: CGRect(x: ((UIScreen.main.bounds.width)/2+17), y: ((UIScreen.main.bounds.height)/2+725), width: 200, height: 30))
    
    
    fileprivate func setupDescription2(){
        description2.textAlignment = .center
        description2.text = "Quantity"
        self.scrollView.addSubview(description2)
    }
    
    func setupScrollView(){
        setUpPickerView1()
        setUpPickerView2()
        setUpPickerView3()
        setUpPickerView4()
        setUpPickerView5()
        setUpPickerView6()
        setupButton()
        setupButton2()
        setupTableView()
        setupTextField()
        setupTextField2()
        setupTextField3()
        setupTextField4()
        setupTextField5()
        setupTextField6()
        setupTextField7()
        setupTextField8()
        setupLabel1()
        setupLabel2()
        setupLabel3()
        setupLabel4()
        setupLabel5()
        setupLabel6()
        setupLabel7()
        createToolbar()
        createToolbar2()
        createToolbar3()
        createToolbar4()
        createToolbar5()
        createToolbar6()
        createToolbar7()
        createToolbar8()
        createToolbar9()
        createToolbar10()
        createToolbar11()
        createToolbar12()
        createToolbar13()
        createToolbar14()
        setupQuantityTextField1()
        setupQuantityTextField2()
        setupQuantityTextField3()
        setupQuantityTextField4()
        setupQuantityTextField5()
        setupQuantityTextField6()
        setupDescription1()
        setupDescription2()
        
        
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hourList.count
        }else if component == 1 {
            return minuteList.count
        }else if component == 2 {
            return dayTimeList.count
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(hourList[row])"
        }else if component == 1 {
            return "\(minuteList[row])"
        }else if component == 2 {
            return "\(dayTimeList[row])"
        }else {
            return "in"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hourIndex = pickerView.selectedRow(inComponent: 0)
        let minuteIndex = pickerView.selectedRow(inComponent: 1)
        let dayIndex = pickerView.selectedRow(inComponent: 2)
        
        
        if pickerView == textField.inputView{
            textField.text = "\(hourList[hourIndex]) : \(minuteList[minuteIndex])    \(dayTimeList[dayIndex])"
        }
        else if pickerView == textField2.inputView {
            textField2.text = "\(hourList[hourIndex]) : \(minuteList[minuteIndex])    \(dayTimeList[dayIndex])"
        }
        else if pickerView == textField3.inputView {
            textField3.text = "\(hourList[hourIndex]) : \(minuteList[minuteIndex])    \(dayTimeList[dayIndex])"
        }
        else if pickerView == textField4.inputView {
            textField4.text = "\(hourList[hourIndex]) : \(minuteList[minuteIndex])    \(dayTimeList[dayIndex])"
        }
    }
}
