//
//  ViewController.swift
//  MultiLineChart
//
//  Created by pratul patwari on 1/24/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit
import Charts

struct Graph {
    var label: [String]
    var value: [Int]
}

class ViewController: UIViewController, ChartViewDelegate {

    weak var axisFormatDelegate: IAxisValueFormatter?
    
    let minValue = 500
    var maxValue : Int = 10000
    var initialValue: Int = 0
    var prom = 5
    var step = 100
    let stepsLine = LineChartDataSet()
    let promLine = LineChartDataSet()
    
    let slider: UISlider = {
        let slide = UISlider()
        slide.isContinuous = true
        slide.thumbTintColor = .red
        slide.addTarget(self, action: #selector(stepsSliderAction(_:)), for: .valueChanged)
        slide.translatesAutoresizingMaskIntoConstraints = false
        return slide
    }()
    
    let promSlider: UISlider = {
        let slide = UISlider()
        slide.isContinuous = true
        slide.thumbTintColor = .blue
        slide.addTarget(self, action: #selector(promSliderAction(_:)), for: .valueChanged)
        slide.translatesAutoresizingMaskIntoConstraints = false
        return slide
    }()
    
    let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let promLabel: UILabel = {
        let label = UILabel()
        label.text = "Proms"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepsButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.white, for: .normal)
        l.setTitle("Assign", for: .normal)
        l.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        l.layer.cornerRadius = 5
        l.backgroundColor = UIColor.init(red: 102 / 255, green: 140 / 255, blue: 255 / 255, alpha: 1)
        l.addTarget(self, action: #selector(saveStepsAction), for: .touchUpInside)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let promButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.white, for: .normal)
        l.setTitle("Assign", for: .normal)
        l.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        l.layer.cornerRadius = 5
        l.backgroundColor = UIColor.init(red: 102 / 255, green: 140 / 255, blue: 255 / 255, alpha: 1)
        l.addTarget(self, action: #selector(savePromAction), for: .touchUpInside)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var ll2 : ChartLimitLine = {
        let limit = ChartLimitLine()
        limit.lineWidth = 4
        limit.lineDashLengths = [5,5]
        limit.labelPosition = .leftBottom
        limit.valueFont = UIFont(name: "Helvetica", size: 13)!
        limit.limit = 2000
        limit.valueTextColor = .red
        return limit
    }()
    
    var ll3 : ChartLimitLine = {
        let limit = ChartLimitLine()
        limit.lineWidth = 4
        limit.lineDashLengths = [5,5]
        limit.labelPosition = .rightTop
        limit.valueFont = UIFont(name: "Helvetica", size: 13)!
        limit.valueTextColor = .blue
        limit.lineColor = .blue
        return limit
    }()
    
    let dropDown: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    var weekData = Graph(label: ["WEEK 1", "WEEK 2", "WEEK 3", "WEEK 4", "WEEK 5", "WEEK 6", "WEEK 7"], value: [3572, 1240, 2374, 2890, 3090, 5775, 7913])
    var promData = Graph(label: ["WEEK 1", "WEEK 2", "WEEK 3", "WEEK 4", "WEEK 5", "WEEK 6", "WEEK 7"], value: [91, 84, 61, 50, 48, 32, 24])
    var heartRate = Graph(label: ["WEEK 1", "WEEK 2", "WEEK 3", "WEEK 4", "WEEK 5", "WEEK 6", "WEEK 7"], value: [68, 77, 80, 93, 98, 101, 101])
    
    let chtChart : LineChartView = {
        let cht = LineChartView()
        cht.chartDescription?.enabled = false
        cht.dragEnabled = true
        cht.setScaleEnabled(true)
        cht.pinchZoomEnabled = true
        cht.leftAxis.enabled = true
        cht.rightAxis.enabled = true
        cht.leftAxis.drawAxisLineEnabled = true
        cht.leftAxis.drawGridLinesEnabled = true
        cht.rightAxis.drawAxisLineEnabled = true
        cht.rightAxis.drawGridLinesEnabled = false
        cht.xAxis.enabled = true
        cht.xAxis.drawAxisLineEnabled = true
        cht.xAxis.drawGridLinesEnabled = true
        cht.xAxis.avoidFirstLastClippingEnabled = true
        cht.xAxis.labelPosition = .bothSided
        cht.translatesAutoresizingMaskIntoConstraints = false
        return cht
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        chtChart.delegate = self
        axisFormatDelegate = self
        setupChartView()
        setupSlider()
        setupLabels()
        updateGraph()
        setupButton()
        
    }

    
    fileprivate func setupSlider(){
        view.addSubview(slider)
        view.addSubview(promSlider)
        
        slider.topAnchor.constraint(equalTo: chtChart.bottomAnchor, constant: 5).isActive = true
        slider.leftAnchor.constraint(equalTo: chtChart.leftAnchor, constant: 20).isActive = true
        slider.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        
        
        promSlider.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5).isActive = true
        promSlider.leftAnchor.constraint(equalTo: chtChart.leftAnchor, constant: 20).isActive = true
        promSlider.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        
        
        promSlider.minimumValue = Float(0)
        promSlider.maximumValue = Float(100)
        promSlider.value = promSlider.maximumValue / 2
        ll3.limit = Double(promSlider.maximumValue / 2)
    }
    
    fileprivate func setupLabels(){
        view.addSubview(activityLabel)
        view.addSubview(promLabel)
        
        activityLabel.leftAnchor.constraint(equalTo: slider.rightAnchor, constant: 10).isActive = true
        activityLabel.topAnchor.constraint(equalTo: slider.topAnchor).isActive = true
        activityLabel.bottomAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        activityLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        promLabel.leftAnchor.constraint(equalTo: promSlider.rightAnchor, constant: 10).isActive = true
        promLabel.topAnchor.constraint(equalTo: promSlider.topAnchor).isActive = true
        promLabel.bottomAnchor.constraint(equalTo: promSlider.bottomAnchor).isActive = true
        promLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupChartView(){
        view.addSubview(chtChart)
        
        var maxSteps = 0
        if weekData.value.count > 0 {
            maxSteps = weekData.value.max()! + 1000
            initialValue = weekData.value.max()!
        }
        
        let ll1 = ChartLimitLine(limit: Double(maxSteps), label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightBottom
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chtChart.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMinimum = 100
        leftAxis.axisMaximum = Double(maxSteps + 1000)
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        let rightAxis = chtChart.rightAxis
        rightAxis.removeAllLimitLines()
        rightAxis.addLimitLine(ll3)
        rightAxis.axisMaximum = 100
        rightAxis.axisMinimum = 0
        rightAxis.gridLineDashLengths = [8, 8]
        rightAxis.drawLimitLinesBehindDataEnabled = true
        
        chtChart.xAxis.labelPosition = .bothSided
        
        chtChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chtChart.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        chtChart.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        chtChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        chtChart.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        
        chtChart.animate(xAxisDuration: 0.5)
    }
    
    fileprivate func setupButton(){
        view.addSubview(stepsButton)
        view.addSubview(promButton)
        
        stepsButton.leftAnchor.constraint(equalTo: activityLabel.rightAnchor, constant: 1).isActive = true
        stepsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        stepsButton.topAnchor.constraint(equalTo: slider.topAnchor, constant: 0).isActive = true
        stepsButton.bottomAnchor.constraint(equalTo: slider.bottomAnchor, constant: 0).isActive = true
        
        
        promButton.leftAnchor.constraint(equalTo: stepsButton.leftAnchor, constant: 0).isActive = true
        promButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        promButton.topAnchor.constraint(equalTo: promSlider.topAnchor, constant: 0).isActive = true
        promButton.bottomAnchor.constraint(equalTo: promSlider.bottomAnchor, constant: 0).isActive = true
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(highlight)
        print(entry)
    }
    
    
    fileprivate func updateGraph(){
        
        var stepsChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        chtChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:weekData.label)
        if weekData.value.count > 0 {
            for i in 0..<weekData.label.count {
                let value = ChartDataEntry(x: Double(i), y: Double(weekData.value[i])) // here we set the X and Y status in a data chart entry
                stepsChartEntry.append(value) // here we add it to the data set
            }
        }
        
        var promChartEntry  = [ChartDataEntry]()
        if promData.value.count > 0 {
            for i in 0..<promData.label.count {
                let value = ChartDataEntry(x: Double(i), y: Double(promData.value[i])) // here we set the X and Y status in a data chart entry
                promChartEntry.append(value) // here we add it to the data set
            }
        }
        
        let l = chtChart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.xEntrySpace = 15
        l.yEntrySpace = 0
        l.yOffset = 0
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Steps")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chtChart.xAxis.valueFormatter!)
        marker.chartView = chtChart
        marker.minimumSize = CGSize(width: 80, height: 40)
        chtChart.marker = marker
        
        stepsLine.values = stepsChartEntry
        stepsLine.colors = [NSUIColor.red] //Sets the colour to red
        stepsLine.valueFont = .systemFont(ofSize: 9)
        stepsLine.formLineDashLengths = [5, 2.5]
        //stepsLine.formLineWidth = 1
        //stepsLine.formSize = 15
        stepsLine.circleRadius = 4
        stepsLine.label = attributeString.string
        
        
        promLine.label = "Prom"
        promLine.values = promChartEntry
        promLine.colors = [NSUIColor.blue] //Sets the colour to blue
        promLine.valueFont = .systemFont(ofSize: 9)
        promLine.formLineDashLengths = [1,3,4,2]
        //promLine.formLineWidth = 5
        //promLine.formSize = 25
        promLine.circleRadius = 8
        promLine.axisDependency = .right
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(stepsLine) //Adds the line to the dataSet
        data.addDataSet(promLine)
        chtChart.data = data
    }
    
    
    @objc func stepsSliderAction(_ sender: UISlider){
        let roundedValue = round(sender.value / Float(step)) * Float(step)
        chtChart.leftAxis.limitLines[0].limit = Double(roundedValue)
        if Int(sender.value) > Int(chtChart.leftAxis.axisMaximum) {
            chtChart.leftAxis.axisMaximum += 1000
        }
        
        self.activityLabel.text = String(Int(roundedValue))
        updateGraph()
    }
    
    
    @objc func promSliderAction(_ sender: UISlider){
        let roundedValue = round(sender.value / Float(prom)) * Float(prom)
        chtChart.rightAxis.limitLines[0].limit = Double(roundedValue)
        self.promLabel.text = String(Int(roundedValue))
        updateGraph()
    }
    
    @objc func saveStepsAction(){
        print("Make a DB call for steps action")
        hideShowDataPoint(line: stepsLine, slider: slider, limitLine: chtChart.leftAxis.limitLines)
    }
    
    @objc func savePromAction(){
        print("Make DB call for prom action")
        hideShowDataPoint(line: promLine, slider: promSlider, limitLine: chtChart.rightAxis.limitLines)
    }
}

extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
   func hideShowDataPoint(line: LineChartDataSet, slider: UISlider, limitLine: [ChartLimitLine] ){
        if line.isVisible {
            line.visible = false
            limitLine[0].enabled = false
            slider.isEnabled = false
        } else {
            line.visible = true
            limitLine[0].enabled = true
            slider.isEnabled = true
        }
        updateGraph()
    }
}
