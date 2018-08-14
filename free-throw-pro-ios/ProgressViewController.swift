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
    
    var segmentedControl: UISegmentedControl!
    @IBOutlet var barChart: BarChartView!
    
    @IBAction func addNewSession(_ sender: UIBarButtonItem) {
        print("Button tapped")
    }
    
    @IBAction func renderChart() {
        barChartUpdate()
    }
    
    var numberOfDownloadsDataEntries = [BarChartDataEntry]()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProgressViewController")
        
        barChartUpdate()
    }
    
    func barChartUpdate() {
        var values = [BarChartDataEntry]()
        for i in 1..<30 {
            values.append(BarChartDataEntry(x: Double(i), y: Double(i) * 1.22))
        }
        
        let dataSet = BarChartDataSet(values: values, label: "")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.legend.formSize = 0
        
        barChart.notifyDataSetChanged()
    }
}
