//
//  DetailViewController.h
//  Test-Neon
//
//  Created by Paulo Mendes on 9/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

