//
//  MainViewController.swift
//  AutiCare
//
//  Created by sourav_singh on 07/06/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    var showAssessmentOrNot : Bool?
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Progress"
        self.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle")
    }

    @IBOutlet var assessmentStack: UIStackView!
    
    private var collectionView: UICollectionView!
        private let monthLabel = UILabel()
        private var currentDate = Date()
        private var progressDates: Set<Date> = []
        
        private let gamesProgressView = UIProgressView(progressViewStyle: .default)
        private let videosProgressView = UIProgressView(progressViewStyle: .default)
        private let booksProgressView = UIProgressView(progressViewStyle: .default)
        
        private let scrollView = UIScrollView()
        private let contentView = UIView()
        private let progressStackView = UIStackView()
        private let takeAssessmentButton = UIButton(type: .system)
        private let todayGoalsView = TodayGoalsView()
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            assessmentStack.isHidden = false
//            setupScrollView()
//            setupUI()
//            setupCollectionView()
//            setupProgressBars()
//            setupTodayGoals()
//            updateMonthLabel()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
        
        private func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }
        
        private func setupUI() {
            // Month Label
            monthLabel.textAlignment = .center
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(monthLabel)
            
            NSLayoutConstraint.activate([
                monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                monthLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
            
            // Navigation Buttons
            let previousButton = UIButton(type: .system)
            previousButton.setTitle("Previous", for: .normal)
            previousButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(previousButton)
            
            let nextButton = UIButton(type: .system)
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(nextButton)
            
            NSLayoutConstraint.activate([
                previousButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
                previousButton.trailingAnchor.constraint(equalTo: monthLabel.leadingAnchor, constant: -16),
                
                nextButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
                nextButton.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 16)
            ])
        }
        
        private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 32),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                collectionView.heightAnchor.constraint(equalToConstant: 300)
            ])
        }
        
        private func setupProgressBars() {
            // Labels for progress bars
            let gamesLabel = UILabel()
            gamesLabel.text = "Games"
            gamesLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let videosLabel = UILabel()
            videosLabel.text = "Videos"
            videosLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let booksLabel = UILabel()
            booksLabel.text = "Worksheets"
            booksLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Progress bars configuration
            gamesProgressView.progressTintColor = .systemRed
            videosProgressView.progressTintColor = .systemBlue
            booksProgressView.progressTintColor = .systemGreen
            
            gamesProgressView.setProgress(0.5, animated: false) // Example progress value
            videosProgressView.setProgress(0.7, animated: false) // Example progress value
            booksProgressView.setProgress(0.3, animated: false) // Example progress value
            
            // Stack view for labels and progress bars
            progressStackView.axis = .vertical
            progressStackView.spacing = 8
            progressStackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(progressStackView)
            
            // Add labels and progress bars to the stack view
            progressStackView.addArrangedSubview(gamesLabel)
            progressStackView.addArrangedSubview(gamesProgressView)
            progressStackView.addArrangedSubview(videosLabel)
            progressStackView.addArrangedSubview(videosProgressView)
            progressStackView.addArrangedSubview(booksLabel)
            progressStackView.addArrangedSubview(booksProgressView)
            
            NSLayoutConstraint.activate([
                progressStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32),
                progressStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                progressStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                gamesProgressView.heightAnchor.constraint(equalToConstant: 20),
                videosProgressView.heightAnchor.constraint(equalToConstant: 20),
                booksProgressView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        
    private func setupTodayGoals() {
        // Today's Goals Heading
        let todayGoalsHeading = UILabel()
        todayGoalsHeading.text = "Today's Target"
        todayGoalsHeading.font = UIFont.boldSystemFont(ofSize: 18)
        todayGoalsHeading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(todayGoalsHeading)
        
        NSLayoutConstraint.activate([
            todayGoalsHeading.topAnchor.constraint(equalTo: progressStackView.bottomAnchor, constant: 32),
            todayGoalsHeading.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        todayGoalsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(todayGoalsView)
        
        NSLayoutConstraint.activate([
            todayGoalsView.topAnchor.constraint(equalTo: todayGoalsHeading.bottomAnchor, constant: 16),
            todayGoalsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            todayGoalsView.widthAnchor.constraint(equalToConstant: 200),
            todayGoalsView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(todayGoalsTapped(_:)))
        todayGoalsView.addGestureRecognizer(tapGestureRecognizer)
        todayGoalsView.isUserInteractionEnabled = true
    }
    
    private func setupTakeAssessmentButton() {
        takeAssessmentButton.setTitle("Take Assessment", for: .normal)
        takeAssessmentButton.backgroundColor = .systemMint
        takeAssessmentButton.layer.cornerRadius = 10
        takeAssessmentButton.addTarget(self, action: #selector(takeAssessmentTapped), for: .touchUpInside)
        takeAssessmentButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(takeAssessmentButton)
        
        NSLayoutConstraint.activate([
            takeAssessmentButton.topAnchor.constraint(equalTo: todayGoalsView.bottomAnchor, constant: 50), // Add spacing here
            takeAssessmentButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            takeAssessmentButton.widthAnchor.constraint(equalToConstant: 250),
            takeAssessmentButton.heightAnchor.constraint(equalToConstant: 50),
            takeAssessmentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16) // Bottom constraint
        ])
    }
    
    
    
        @objc private func todayGoalsTapped(_ sender: UITapGestureRecognizer) {
            let todayGoalsView = sender.view as! TodayGoalsView
            todayGoalsView.updateCompletionState()
            
            // Update the current date progress in the calendar
            let currentComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
            if let date = Calendar.current.date(from: currentComponents) {
                if todayGoalsView.allGoalsCompleted() {
                    progressDates.insert(date)
                } else {
                    progressDates.remove(date)
                }
                collectionView.reloadData()
            }
        }
    
    @objc private func takeAssessmentTapped() {
        performSegue(withIdentifier: "AsessmentSegue", sender: nil)
    }
        
    @objc private func nextMonth() {
        changeMonth(by: 1)
    }
    
        @objc private func previousMonth() {
            changeMonth(by: -1)
        }
        
        
        
        private func changeMonth(by offset: Int) {
            var dateComponents = DateComponents()
            dateComponents.month = offset
            currentDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) ?? currentDate
            updateMonthLabel()
            collectionView.reloadData()
        }
        
        private func updateMonthLabel() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            monthLabel.text = dateFormatter.string(from: currentDate)
        }
        
        // MARK: - UICollectionViewDataSource
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let range = Calendar.current.range(of: .day, in: .month, for: currentDate)!
            return range.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarDayCell
            cell.dayLabel.text = "\(indexPath.item + 1)"
            
            var components = Calendar.current.dateComponents([.year, .month], from: currentDate)
            components.day = indexPath.item + 1
            if let date = Calendar.current.date(from: components) {
                if progressDates.contains(date) {
                    cell.contentView.backgroundColor = .systemGreen.withAlphaComponent(0.3)
                } else {
                    cell.contentView.backgroundColor = .systemBackground
                }
            }
            
            return cell
        }
        
        // MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 16
            let availableWidth = collectionView.frame.width - (padding * 2) - (8 * 6) // 7 items per row, 8px spacing
            let itemWidth = availableWidth / 7
            return CGSize(width: itemWidth, height: itemWidth)
        }
    
    @IBAction func unwindToProgressViewController(_ unwindSegue: UIStoryboardSegue) {
        assessmentStack.isHidden = true
        setupScrollView()
        setupUI()
        setupCollectionView()
        setupProgressBars()
        setupTodayGoals()
        updateMonthLabel()
        setupTakeAssessmentButton()
    }
    
    }

    class CalendarDayCell: UICollectionViewCell {
        let dayLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            dayLabel.textAlignment = .center
            contentView.addSubview(dayLabel)
            
            NSLayoutConstraint.activate([
                dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
            
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.layer.cornerRadius = 8
            contentView.clipsToBounds = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class TodayGoalsView: UIView {
        private var gamesCompleted = false
        private var videosCompleted = false
        private var booksCompleted = false
        
        private let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen]
        private let labels = ["Games", "Videos", "Worksheets"]
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let radius = min(rect.width, rect.height) / 2 - 10
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            
            for i in 0..<3 {
                context.move(to: center)
                context.setFillColor(currentColor(for: i).cgColor)
                context.addArc(center: center, radius: radius, startAngle: CGFloat(i) * (2 * .pi / 3), endAngle: CGFloat(i + 1) * (2 * .pi / 3), clockwise: false)
                context.fillPath()
                
                let labelCenterAngle = CGFloat(i) * (2 * .pi / 3) + (2 * .pi / 6)
                let labelRadius = radius + 20
                let labelCenter = CGPoint(x: center.x + labelRadius * cos(labelCenterAngle), y: center.y + labelRadius * sin(labelCenterAngle))
                
                let label = UILabel()
                label.text = labels[i]
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 10)
                label.sizeToFit()
                label.center = labelCenter
                addSubview(label)
            }
            
            context.setBlendMode(.clear)
            context.fillEllipse(in: CGRect(x: center.x - radius / 2, y: center.y - radius / 2, width: radius, height: radius))
            context.setBlendMode(.normal)
        }
        
        func updateCompletionState() {
            gamesCompleted.toggle()
            videosCompleted.toggle()
            booksCompleted.toggle()
            setNeedsDisplay()
        }
        
        func allGoalsCompleted() -> Bool {
            return gamesCompleted && videosCompleted && booksCompleted
        }
        
        private func currentColor(for index: Int) -> UIColor {
            switch index {
            case 0:
                return gamesCompleted ? colors[index] : .lightGray
            case 1:
                return videosCompleted ? colors[index] : .lightGray
            case 2:
                return booksCompleted ? colors[index] : .lightGray
            default:
                return .clear
            }
        }
    }


    
