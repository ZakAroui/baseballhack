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
        v.backgroundColor = .white
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
        setData(vData: evalData10Y)
        
        segmentControl.addTarget(self, action: #selector(updateGraph), for: .valueChanged)
        
        addNewsButton()
    }
    
    @objc func updateGraph() {
        let index = segmentControl.selectedSegmentIndex
        if(index == 0){
            setData(vData: evalData10Y)
        } else if(index == 1){
            setData(vData: evalData1Y)
        } else if(index == 2){
            setData(vData: evalData6M)
        }
    }
    
    fileprivate func addNewsButton() {
        let newsButton = UIButton(type: .custom)
        newsButton.setTitle("News", for: .normal)
        newsButton.setTitleColor(.black, for: .normal)
        newsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        newsButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        let newsItem = UIBarButtonItem(customView: newsButton)
        
        navigationItem.rightBarButtonItem = newsItem
    }
    
    @objc func showNews() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newsBoard") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    let evalData10Y = [
        150,
        160,
        170,
        185,
        230,
        250,
        320,
        340,
        370,
        400,
        400
    ]
    
    let evalData1Y = [
        230,
        240,
        232,
        280,
        249,
        250,
        255,
        240,
        210,
        220,
        230
    ]
    
    let evalData6M = [
        140,
        145,
        143,
        180,
        167,
        200,
        185,
        190,
        220,
        235,
        260
    ]
    
    fileprivate func setData(vData: Array<Int>) {
        let yVals1 = (0..<11).map { (i) -> ChartDataEntry in
            let val = Double(vData[i])
            return ChartDataEntry(x: Double(i), y: val )
        }
        
        //style chart
        chartView.legend.enabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.xAxis.labelPosition = .bottom
        //lineChartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled  = true
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        
        let dataSet = LineChartDataSet(values: yVals1, label: "Share Price")
        dataSet.setColor(.black)
        dataSet.lineWidth = 1.0
        dataSet.circleRadius = 5.0
        dataSet.fillAlpha = 0.8
        dataSet.fillColor = .blue
        dataSet.highlightEnabled = false
        dataSet.highlightColor = .blue
        dataSet.drawCircleHoleEnabled = true
        dataSet.circleHoleRadius = 3.0
        dataSet.circleColors = [NSUIColor(cgColor: UIColor.green.cgColor)]
        dataSet.drawFilledEnabled = true
        
        let data = LineChartData(dataSets: [dataSet])
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
    @objc func buy() {
        let alertController = UIAlertController(title: "Share Bought", message:
            "You bought a share for $300", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func sell() {
        let alertController = UIAlertController(title: "Share Listed", message:
            "You listed a share for $300", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
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
        buyButton.backgroundColor = .green
        buyButton.addTarget(self, action: #selector(buy), for: .touchUpInside)
        
        let sellButton = UIButton(frame: .zero)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.setTitle("SELL", for: .normal)
        sellButton.setTitleColor(.white, for: .normal)
        sellButton.backgroundColor = .red
        sellButton.addTarget(self, action: #selector(sell), for: .touchUpInside)
        
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
