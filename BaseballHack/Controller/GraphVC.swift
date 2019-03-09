//
//  GraphVC.swift
//  BaseballHack
//
//  Created by Zack Esm on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit
import Charts

class GraphVC: UIViewController {
    
    let chartView: LineChartView = {
        let v = LineChartView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        v.layer.cornerRadius = 10
        return v
    }()
    
    let segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["10 Years", "1 Year", "6 Months"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.tintColor = .black
        sc.backgroundColor = .white
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setData()
    }
    
    let evalData = [
        400,
        370,
        340,
        320,
        250,
        230,
        185,
        170,
        160,
        150
    ]
    
    fileprivate func setData() {
        let yVals1 = (0..<20).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(50) + 50)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: yVals1, label: "Share Price")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 1
        set1.drawFilledEnabled = true
        set1.fillColor = .blue
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMinimum)
        }
        
        let data = LineChartData(dataSets: [set1])
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
    fileprivate func setupView() {
        let margins = view.layoutMarginsGuide
        
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        view.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            chartView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            chartView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.6)
            ])
        
        let buyButton = UIButton(frame: .zero)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.setTitle("BUY", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = .black
        
        let sellButton = UIButton(frame: .zero)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.setTitle("SELL", for: .normal)
        sellButton.setTitleColor(.white, for: .normal)
        sellButton.backgroundColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [buyButton, sellButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
        
    }

}
