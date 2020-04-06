//
//  ViewController.swift
//  LineChart
//
//  Created by pratul patwari on 10/17/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import Charts

struct Survey {
    var isExpanded: Bool = true
    var name: String
    var details: [SurveyDetails]
}
struct SurveyDetails {
    var myArray: String
    var score: String
    var dateCompleted: String
}

struct Steps {
    var date = Date()
    var count: Int
}

class ViewController: UIViewController, ChartViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    var survey : [Survey] = [Survey]()
    var numbers : [Steps] = [Steps]()
    
    private var myTableView: UITableView!
    
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let label : UILabel = {
        let lbl = UILabel()
        lbl.text = "Step Count Status"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let fitbit : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let batteryImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let batteryLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Light", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let chtChart : LineChartView = {
        let cht = LineChartView()
        cht.chartDescription?.enabled = false
        cht.dragEnabled = true
        cht.setScaleEnabled(true)
        cht.pinchZoomEnabled = true
        cht.leftAxis.enabled = true
        cht.rightAxis.enabled = true
        cht.leftAxis.drawAxisLineEnabled = false
        cht.leftAxis.drawGridLinesEnabled = false
        cht.xAxis.drawAxisLineEnabled = false
        cht.xAxis.drawGridLinesEnabled = true
        cht.xAxis.enabled = true
        cht.translatesAutoresizingMaskIntoConstraints = false
        return cht
    }()
    
    let table : UITableView = {
        let t = UITableView()
        return t
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chtChart.delegate = self
        axisFormatDelegate = self
        
        createSurveyArray()
        
        //setupLabel()
        
        setupFitbitImage()
        
        setupBatteryDetails()
        
        setupChartView()
        
        setupTable()
        
        // Do any additional setup after loading the view, typically from a nib.
        updateGraph()
        
    }
    
    private func setupFitbitImage(){
        view.addSubview(fitbit)
        
        let image: UIImage = UIImage(named: "fitbit")!
        fitbit.image = image
        fitbit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        fitbit.widthAnchor.constraint(equalToConstant: 100).isActive = true
        fitbit.heightAnchor.constraint(equalToConstant: 100).isActive = true
        fitbit.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -20).isActive = true
    }
    
    private func setupBatteryDetails(){
        view.addSubview(batteryImage)
        view.addSubview(batteryLabel)
        
        let batteryLevel = 19
        var batteryIcon = String()
        
        if batteryLevel >= 90 {
            batteryIcon.append("full_battery")
        } else if batteryLevel >= 50 && batteryLevel < 90 {
            batteryIcon.append("less_battery")
        } else if batteryLevel < 50 {
            batteryIcon.append("low_battery")
        }
        let image: UIImage = UIImage(named: batteryIcon)!
        batteryImage.image = image
        batteryImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        batteryImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        batteryImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        batteryImage.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 40).isActive = true
        
        batteryLabel.topAnchor.constraint(equalTo: batteryImage.bottomAnchor, constant: 10).isActive = true
        batteryLabel.leftAnchor.constraint(equalTo: batteryImage.leftAnchor).isActive = true
        
        
        batteryLabel.text = "Battery Level " + String(batteryLevel) + "%"
    }
    
    private func setupLabel(){
        self.view.addSubview(label)
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func setupChartView(){
        view.addSubview(chtChart)
        
        
        let ll1 = ChartLimitLine(limit: 5000, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: 1000, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chtChart.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 6000
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chtChart.topAnchor.constraint(equalTo: fitbit.bottomAnchor, constant: 20).isActive = true
        chtChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        chtChart.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        chtChart.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        chtChart.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        chtChart.animate(xAxisDuration: 2.5)
    }
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers.count {
            let timeIntervalForDate: TimeInterval = numbers[i].date.timeIntervalSince1970
            let value = ChartDataEntry(x: Double(timeIntervalForDate), y: Double(numbers[i].count)) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Steps") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.red] //Sets the colour to blue
        line1.valueFont = .systemFont(ofSize: 9)
        line1.formLineDashLengths = [5, 2.5]
        line1.formLineWidth = 1
        line1.formSize = 15
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        line1.drawFilledEnabled = true
        
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        //chtChart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        
        let xaxis = chtChart.xAxis
        xaxis.valueFormatter = axisFormatDelegate
    }
    
    private func setupTable(){
        
        myTableView = UITableView()
        myTableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: chtChart.bottomAnchor, constant: 10).isActive = true
        myTableView.leftAnchor.constraint(equalTo: chtChart.leftAnchor, constant: 0).isActive = true
        myTableView.rightAnchor.constraint(equalTo: chtChart.rightAnchor, constant: 0).isActive = true
        myTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return survey.count
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !survey[section].isExpanded {
            return 0
        } else {
            return survey[section].details.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor.init(red: 243 / 255, green: 233 / 255, blue: 107 / 255, alpha: 1.0)
        headerView.layer.cornerRadius = 5
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        button.setTitle(survey[section].name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExpandCollapse), for: .touchUpInside)
        headerView.addSubview(button)
        
        button.contentHorizontalAlignment = .left
        button.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10).isActive = true
        button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.tag = section
        
        return headerView
    }
    
    @objc func handleExpandCollapse(button: UIButton){
        var indexPaths = [IndexPath]()
        let section = button.tag
        
        
        for row in survey[section].details.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = survey[section].isExpanded
        survey[section].isExpanded = !isExpanded
        
        if isExpanded {
            myTableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            myTableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        let s = survey[indexPath.section]
        cell.survey = s.details[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Open the Survey details page")
        let s = survey[indexPath.section]
        print("Survey Name: ", s.name, " ---> ", s.details[indexPath.item].dateCompleted)
    }
    
    func createSurveyArray(){
        survey.append(Survey(isExpanded: true, name: "ODI - Low Back Pain", details: [SurveyDetails(myArray: "Survey 1", score: "40%", dateCompleted: "10/01/2018"),
                                                      SurveyDetails(myArray: "Survey 2", score: "50%", dateCompleted: "10/05/2018"),
                                                      SurveyDetails(myArray: "Survey 3", score: "70%", dateCompleted: "10/10/2018")]))
        survey.append(Survey(isExpanded: true, name: "VRS Pain Scale", details: [SurveyDetails(myArray: "Survey 1", score: "48%", dateCompleted: "09/13/2017"),
                                                      SurveyDetails(myArray: "Survey 2", score: "34%", dateCompleted: "10/05/2017"),
                                                      SurveyDetails(myArray: "Survey 3", score: "91%", dateCompleted: "01/10/2018")]))
        survey.append(Survey(isExpanded: true, name: "ODI 3", details: [SurveyDetails(myArray: "Survey 1", score: "40%", dateCompleted: "08/16/2018"),
                                                      SurveyDetails(myArray: "Survey 2", score: "50%", dateCompleted: "09/15/2018"),
                                                      SurveyDetails(myArray: "Survey 3", score: "70%", dateCompleted: "10/10/2018")]))
        
        numbers.append(Steps(date:Date(dateString: "2018-01-01")!,count: 4312))
        numbers.append(Steps(date:Date(dateString: "2018-02-01")!,count: 3105))
        numbers.append(Steps(date:Date(dateString: "2018-03-01")!,count:114))
        numbers.append(Steps(date:Date(dateString: "2018-04-01")!,count:3716))
        numbers.append(Steps(date:Date(dateString: "2018-05-01")!,count:3230))
        numbers.append(Steps(date:Date(dateString: "2018-06-01")!,count:785))
        numbers.append(Steps(date:Date(dateString: "2018-07-01")!,count:1830))
        numbers.append(Steps(date:Date(dateString: "2018-08-01")!,count:2915))
        numbers.append(Steps(date:Date(dateString: "2018-09-01")!,count:3011))
        numbers.append(Steps(date:Date(dateString: "2018-10-01")!,count:104))
        numbers.append(Steps(date:Date(dateString: "2018-11-01")!,count:2056))
    }
}

class CustomCell : UITableViewCell {
    
    var survey : SurveyDetails? {
        didSet{
            surveyName.text = survey?.myArray
            surveyScore.text = survey?.score
            surveyDate.text = survey?.dateCompleted
        }
    }
    
    private let surveyName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let surveyScore : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let surveyDate : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(surveyName)
        addSubview(surveyScore)
        addSubview(surveyDate)
        
        surveyName.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        surveyName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        surveyScore.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        surveyScore.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        surveyDate.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        surveyDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

extension Date {
    
    init?(dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        if let d = dateStringFormatter.date(from: dateString) {
            self.init(timeInterval: 0, since: d)
        } else {
            return nil
        }
    }
}
