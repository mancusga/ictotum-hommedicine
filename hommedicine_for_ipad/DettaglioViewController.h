//
//  DettaglioViewController.h
//  hommedicine_for_ipad
//
//  Created by Gabriele Mancuso on 05/10/15.
//  Copyright © 2015 Barbara Mancuso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DettaglioViewController : UIViewController
@property (strong) NSManagedObject *contactdb;

@property (strong, nonatomic) IBOutlet UITextField *nominativo;
@property (strong, nonatomic) IBOutlet UIDatePicker *scadenza;

- (IBAction)Back:(id)sender;
- (IBAction)Save:(id)sender;

@end
