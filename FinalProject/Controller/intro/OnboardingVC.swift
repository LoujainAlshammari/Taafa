//
//  OnboardingVC.swift
//  FinalProject
//
//  Created by loujain on 15/01/2022.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides:[OnboardingSlide] = []
    var  currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage

            if currentPage == slides.count - 1 {
                nextButton.setTitle("البدء", for: .normal)
            }else{
                nextButton.setTitle("التالي", for: .normal)


            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        slides = [
            
            OnboardingSlide(title: "جولة في تَعافَى", description: "تحدث مع الاخصائي بضغطة زر", image:#imageLiteral(resourceName: "logo2.png") ),
        OnboardingSlide(title: "تحدث مع الاخصائي بضغطة زر", description: "يمكنك البدء و التحدث مع الاخصائي المناسب لك او احجز موعد لك من قائمة المواعيد  ", image:#imageLiteral(resourceName: "logo4.png") ),
        OnboardingSlide(title: "تَعافَى يدعمك ويدعم عائلتك", description: " دعمنا يمتد لك ولعائلتك للوصول لنمط حياة صحية", image: #imageLiteral(resourceName: "logo5.png"))

        ]
    }
    

    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {

            let controller = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
            print("go to next page")
            
        }else{
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        }
    }
    
    
}

extension OnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.identifier, for: indexPath) as! OnboardingCVCell
        
        cell.setUp(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage

    }
    
    
}
