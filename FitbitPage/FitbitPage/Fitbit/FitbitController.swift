//
//  ViewController.swift
//  FitbitPage
//
//  Created by pratul patwari on 10/29/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import Charts

//struct Steps {
//    var date = Date()
//    var count: Int
//}

class FitbitController: UIViewController {
    
    var numbers : [Steps] = [Steps]()
    var weekly : [Steps] = [Steps]()
    var monthly : [Steps] = [Steps]()
    var dates = [String]()
    weak var axisFormatDelegate : IndexAxisValueFormatter?
    
    let barChart : BarChartView = {
        let cht = BarChartView()
        cht.chartDescription?.enabled = false
        cht.drawBarShadowEnabled = false
        cht.drawValueAboveBarEnabled = true
        cht.xAxis.enabled = true
        cht.xAxis.labelPosition = .bottom
        cht.rightAxis.enabled = true
        cht.leftAxis.enabled = false
        cht.translatesAutoresizingMaskIntoConstraints = false
        return cht
    }()
    
    
    
    let segment : UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Daily","Weekly","Monthly"])
        segmented.selectedSegmentIndex = 0
        segmented.tintColor = .red
        segmented.backgroundColor = UIColor.white
        segmented.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    let stepsLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.text = "Step Count"
        label.font = UIFont(name: "CustomFont-Light", size: UIFont.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(segment)
        self.setup(barLineChartView: barChart)
        createData()
        setupSegment()
        setupChart()
        setupLabel()
    }
    
    private func setupSegment(){
        segment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        segment.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        segment.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        switch (segment.selectedSegmentIndex) {
        case 0:
            setChart(steps: numbers, frequency: "D")
            break
        case 1:
            setChart(steps: weekly, frequency: "W")
            break
        case 2:
            setChart(steps: monthly, frequency: "M")
            break
        default:
            break
        }
    }
    
    private func setupChart(){
        view.addSubview(barChart)
        
        barChart.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 10).isActive = true
        barChart.leftAnchor.constraint(equalTo: segment.leftAnchor, constant: 0).isActive = true
        barChart.rightAnchor.constraint(equalTo: segment.rightAnchor, constant: 0).isActive = true
        barChart.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        
        barChart.animate(yAxisDuration: 0.5, easingOption: .easeInOutQuart)
        
        
        
        setChart(steps: numbers, frequency: "D")
    }
    
    private func setupLabel(){
        view.addSubview(stepsLabel)
        
        stepsLabel.leftAnchor.constraint(equalTo: barChart.leftAnchor, constant: 5).isActive = true
        stepsLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        stepsLabel.topAnchor.constraint(equalTo: barChart.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setDates(steps: [Steps], frequency: String){
        dates.removeAll()
        var total : Int = 0
        if frequency == "D" {
            for i in 0..<steps.count {
                dates.append(steps[i].date.daily()!)
                total += Int(steps[i].count)
            }
            updateLabel(label: "Total", value: total)
        } else if frequency == "W" {
            for i in 0..<steps.count {
                dates.append(steps[i].date.dayOfWeek()!)
                total += Int(steps[i].count)
            }
            updateLabel(label: "Avg", value: (total / steps.count))
        } else {
            for i in 0..<steps.count {
                dates.append(steps[i].date.monthly()!)
                total += Int(steps[i].count)
            }
            updateLabel(label: "Avg", value: (total / steps.count))
        }
        
    }
    
    private func updateLabel(label: String,value: Int){
        let stepsTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.red,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)
            ] as [NSAttributedString.Key : Any]
        let labelString = NSAttributedString(string: label.uppercased())
        let valueString = NSAttributedString(string: String(value.formatNumber()), attributes: stepsTextAttributes)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(labelString)
        mutableAttributedString.append(NSAttributedString(string: " "))
        mutableAttributedString.append(valueString)
        mutableAttributedString.append(NSAttributedString(string: " steps"))
        stepsLabel.attributedText = mutableAttributedString
    }
    
    private func setChart(steps: [Steps], frequency: String) {
        
        setDates(steps: steps, frequency: frequency)
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:self.dates)
        barChart.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dates.count {
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(steps[i].count))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Steps")
        let dataSets: [BarChartDataSet] = [chartDataSet]
        chartDataSet.colors = [UIColor.red]//[UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        let chartData = BarChartData(dataSets: dataSets)
        
        barChart.data = chartData
        
        barChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .linear)
        barChart.notifyDataSetChanged()
        
    }
    
    private func createData(){
        numbers.append(Steps(date:Date(dateString: "2018-11-01T07:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T08:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T09:53:04+0000")!,count: 0))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T10:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T11:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T12:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T13:53:04+0000")!,count:Int.random(in: 10..<500)))
        numbers.append(Steps(date:Date(dateString: "2018-11-01T14:53:04+0000")!,count:Int.random(in: 10..<500)))
        
        weekly.append(Steps(date:Date(dateString: "2018-10-27T07:53:04+0000")!,count:3716))
        weekly.append(Steps(date:Date(dateString: "2018-10-28T08:53:04+0000")!,count:3230))
        weekly.append(Steps(date:Date(dateString: "2018-10-29T09:53:04+0000")!,count:785))
        weekly.append(Steps(date:Date(dateString: "2018-10-30T10:53:04+0000")!,count:1830))
        weekly.append(Steps(date:Date(dateString: "2018-10-31T11:53:04+0000")!,count:2915))
        weekly.append(Steps(date:Date(dateString: "2018-11-01T12:53:04+0000")!,count:3011))
        
        monthly.append(Steps(date:Date(dateString: "2018-10-27T07:53:04+0000")!,count: Int.random(in: 1..<10000)))
        monthly.append(Steps(date:Date(dateString: "2018-10-28T08:53:04+0000")!,count: Int.random(in: 1..<10000)))
        monthly.append(Steps(date:Date(dateString: "2018-10-29T09:53:04+0000")!,count: Int.random(in: 1..<10000)))
        monthly.append(Steps(date:Date(dateString: "2018-10-30T10:53:04+0000")!,count: Int.random(in: 1..<10000)))
        monthly.append(Steps(date:Date(dateString: "2018-10-31T11:53:04+0000")!,count: Int.random(in: 1..<10000)))
        monthly.append(Steps(date:Date(dateString: "2018-11-01T12:53:04+0000")!,count: Int.random(in: 1..<10000)))
        
        
    }
    
}

extension FitbitController: ChartViewDelegate {
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        chartView.delegate = self
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        let xaxis = barChart.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        chartView.rightAxis.enabled = true
    }
}

extension Date {
    
    init?(dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let d = dateStringFormatter.date(from: dateString) {
            self.init(timeInterval: 0, since: d)
        } else {
            return nil
        }
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
    
    func daily() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: self)
    }
    
    func monthly() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
}

extension Int {
    func formatNumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}
