//
//  hommedicineTableViewController.m
//  hommedicine_for_ipad
//
//  Created by Gabriele Mancuso on 05/10/15.
//  Copyright © 2015 Barbara Mancuso. All rights reserved.
//

#import "hommedicineTableViewController.h"
#import "DettaglioViewController.h"
#import "Medicinali.h"

@interface hommedicineTableViewController ()

@end

@implementation hommedicineTableViewController
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicinali"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"scadenza" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects: sortDescriptor1, nil]];
    
//    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
//    Medicinali *latestEntity = [results objectAtIndex:0];

    self.contactarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSManagedObject *device = [self.contactarray objectAtIndex:indexPath.row];
    // Formatting the date field...
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:[device valueForKey:@"scadenza"]];
    NSTimeInterval secondsForTenDays = 60 * 60 * 24 * 30;
    NSDate *futureDate = [[NSDate alloc] init];
    futureDate = [NSDate dateWithTimeIntervalSinceNow:secondsForTenDays];
    if ([futureDate compare:[device valueForKey:@"scadenza"]] == NSOrderedDescending) {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        
    } else if ([futureDate compare:[device valueForKey:@"scadenza"]] == NSOrderedAscending) {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        
    } else {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"nominativo"]]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"scadenza: %@", dateString];
    
    if (indexPath.row == 0) {
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        localNotification.fireDate = [device valueForKey:@"scadenza"];
        localNotification.alertBody = [NSString stringWithFormat:@"Verifica la scadenza: %@", dateString];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.applicationIconBadgeNumber = 1;
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//        if ([futureDate compare:[device valueForKey:@"scadenza"]] == NSOrderedDescending) {
//            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//            localNotification.fireDate = [device valueForKey:@"scadenza"];
//            localNotification.alertBody = [NSString stringWithFormat:@"Verifica la scadenza: %@", dateString];
//            localNotification.timeZone = [NSTimeZone defaultTimeZone];
//            localNotification.soundName = UILocalNotificationDefaultSoundName;
//            localNotification.applicationIconBadgeNumber = 1;
//            UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//            UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//            [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
//            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//        } else if ([futureDate compare:[device valueForKey:@"scadenza"]] == NSOrderedAscending) {
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
//            [[UIApplication sharedApplication] cancelAllLocalNotifications];
//        } else {
//            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//            localNotification.fireDate = [device valueForKey:@"scadenza"];
//            localNotification.alertBody = [NSString stringWithFormat:@"Verifica la scadenza: %@", dateString];
//            localNotification.timeZone = [NSTimeZone defaultTimeZone];
//            localNotification.soundName = UILocalNotificationDefaultSoundName;
//            localNotification.applicationIconBadgeNumber = 1;
//            UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//            UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//            [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
//            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//        }
    }

    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.contactarray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove device from table view
        [self.contactarray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"seg2"]) {
        NSManagedObject *selectedDevice = [self.contactarray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        DettaglioViewController *destViewController = segue.destinationViewController;
        destViewController.contactdb = selectedDevice;
    }
}


@end
