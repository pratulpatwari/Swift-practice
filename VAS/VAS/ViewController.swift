//
//  ViewController.swift
//  VAS
//
//  Created by pratul patwari on 1/25/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    let table : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        return tableView
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Please tell us your pain level on a scale of 0 to 10 where 0 being no pain and 10 being extreme pain."
        label.font = UIFont.init(name: "Georgia-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slider: UISlider = {
        let slide = UISlider()
        slide.isContinuous = true
        slide.addTarget(self, action: #selector(sliderAction(_:)), for: .valueChanged)
        slide.translatesAutoresizingMaskIntoConstraints = false
        return slide
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.init(name: "Georgia-Bold", size: 50)
        label.textColor = UIColor.init(red: 0 / 255, green: 119 / 255, blue: 179 / 255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreName: UILabel = {
        let label = UILabel()
        label.text = "No Pain"
        label.font = UIFont.init(name: "Georgia-Bold", size: 20)
        label.textColor = UIColor.init(red: 0 / 255, green: 119 / 255, blue: 179 / 255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let low: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "No Pain"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let high: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Extreme \n  Pain"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let radio: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        table.register(OptionCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(table)
        table.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        //setupQuestion()
        //setupSlider()
        //setupLabel()
        //setupScoreLabel()
        //setupOptions()
    }
    
    fileprivate func setupOptions(){
        view.addSubview(radio)
        
        radio.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        radio.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
    }
    
    fileprivate func setupQuestion(){
        view.addSubview(questionLabel)
        
        questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
    }
    
    fileprivate func setupLabel(){
        
        view.addSubview(low)
        view.addSubview(high)
        
        low.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5).isActive = true
        low.leftAnchor.constraint(equalTo: slider.leftAnchor, constant: 1).isActive = true
        
        high.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5).isActive = true
        high.rightAnchor.constraint(equalTo: slider.rightAnchor, constant: 5).isActive = true
    }
    
    fileprivate func setupScoreLabel(){
        view.addSubview(scoreLabel)
        view.addSubview(scoreName)
        
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40).isActive = true
        
        scoreName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreName.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    fileprivate func setupSlider(){
        view.addSubview(slider)
        
        slider.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.setThumbImage(#imageLiteral(resourceName: "VAS"), for: .normal)
        //slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
    }
    
    @objc func sliderAction(_ sender: UISlider){
        let roundedValue = round(sender.value / Float(1)) * Float(1)
        scoreLabel.text = String(Int(roundedValue))
        slider.setValue((Float(roundedValue)), animated: true)
        if roundedValue.isLessThanOrEqualTo(0){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS"), for: .normal)
            setColors(color: UIColor.init(red: 0 / 255, green: 119 / 255, blue: 179 / 255, alpha: 1), text: "No Pain")
        }else if roundedValue.isLessThanOrEqualTo(2){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS1"), for: .normal)
            setColors(color: .green, text: "Annoying \n (mild)")
        } else if roundedValue.isLessThanOrEqualTo(5){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS2"), for: .normal)
            setColors(color: UIColor.init(red: 204 / 255, green: 153 / 255, blue: 0 / 255, alpha: 1), text: "Annoying \n (mild)")
        } else if roundedValue.isLessThanOrEqualTo(7){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS3"), for: .normal)
            setColors(color: UIColor.init(red: 204 / 255, green: 122 / 255, blue: 0 / 255, alpha: 1), text: "Uncomfortable \n (moderate)")
        } else if roundedValue.isLessThanOrEqualTo(9){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS4"), for: .normal)
            setColors(color: UIColor.init(red: 230 / 255, green: 57 / 255, blue: 0 / 255, alpha: 1), text: "Horrible \n (severe)")
        } else if roundedValue.isLessThanOrEqualTo(10){
            slider.setThumbImage(#imageLiteral(resourceName: "VAS5"), for: .normal)
            setColors(color: UIColor.init(red: 128 / 255, green: 32 / 255, blue: 0 / 255, alpha: 1), text: "Worst")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Please tell us your pain level on a scale of 0 to 10 where 0 being no pain and 10 being extreme pain."
        tableView.tableHeaderView = label
        return label
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let question = "Please tell us your pain level on a scale of 0 to 10 where 0 being no pain and 10 being extreme pain."
        return question
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! OptionCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension ViewController {
    func setColors(color: UIColor, text: String) {
        scoreName.text = text
        scoreName.textColor = color
        scoreLabel.textColor = color
        slider.minimumTrackTintColor = color
    }
}
