//
//  Medicinali.h
//  hommedicine_for_ipad
//
//  Created by Gabriele Mancuso on 10/10/15.
//  Copyright © 2015 Barbara Mancuso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Medicinali : NSManagedObject
@property (nonatomic, retain) NSString * nominativo;
@property (nonatomic, retain) NSDate * scadenza;
@end
