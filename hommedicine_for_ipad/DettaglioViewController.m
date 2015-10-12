//
//  DettaglioViewController.m
//  hommedicine_for_ipad
//
//  Created by Gabriele Mancuso on 05/10/15.
//  Copyright © 2015 Barbara Mancuso. All rights reserved.
//

#import "DettaglioViewController.h"

@interface DettaglioViewController ()

@end

@implementation DettaglioViewController
@synthesize contactdb;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.contactdb) {
        [self.nominativo setText:[self.contactdb valueForKey:@"nominativo"]];
        [self.scadenza setDate:[self.contactdb valueForKey:@"scadenza"]];
    }

}

 - (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)Save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (self.contactdb) {
        // Update existing device
        [self.contactdb setValue:self.nominativo.text forKey:@"nominativo"];
        [self.contactdb setValue:self.scadenza.date forKey:@"scadenza"];
    } else {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Medicinali" inManagedObjectContext:context];
        [newDevice setValue:self.nominativo.text forKey:@"nominativo"];
        [newDevice setValue:self.scadenza.date forKey:@"scadenza"];
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
