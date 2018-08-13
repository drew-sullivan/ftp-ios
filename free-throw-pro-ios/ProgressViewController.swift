//
//  ProgressViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit
import Charts

class ProgressViewController: UIViewController {
    
    @IBOutlet var barChart: BarChartView!
    
    @IBAction func renderChart() {
        barChartUpdate()
    }
    
    var numberOfDownloadsDataEntries = [BarChartDataEntry]()
    
    override func loadView() {
        super.loadView()
        
//        let segmentedControl = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
//        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        segmentedControl.selectedSegmentIndex = 0
//        
//        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
//        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        
//        topConstraint.isActive = true
//        leadingConstraint.isActive = true
//        trailingConstraint.isActive = true
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProgressViewController")
        
        barChartUpdate()
    }
    
    func barChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1.0, y: 2.2)
        let entry2 = BarChartDataEntry(x: 2.0, y: 4.4)
        let entry3 = BarChartDataEntry(x: 3.0, y: 5)
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Number of Widgets by Type"
        
        barChart.notifyDataSetChanged()
    }
}
