//
//  ViewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "ViewController.h"
#import "PickerNavigationController.h"
#import "OldAlbumChooseController.h"
#import "AlbumChooseController.h"
#import "AlbumNotification.h"

@interface ViewController () <AlbumNotificationReciever, PickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pickedImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    self.pickedImageView.contentMode = UIViewContentModeScaleAspectFit;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeNotification];
}

- (IBAction)albumButtonDidClick:(UIButton *)sender {
    PickerNavigationController *navigationController = nil;
    if ([sender.titleLabel.text isEqualToString:@"Album"]) {
        navigationController = [[PickerNavigationController alloc] initWithPickerDelegate:self maximumPickCount:10 multiPicker:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"SingleAlbum"]) {
        navigationController = [[PickerNavigationController alloc] initWithPickerDelegate:self maximumPickCount:1 multiPicker:NO];
    }
    if (!navigationController) {
        return;
    }
    [self presentViewController:navigationController animated:YES completion:^{
        nil;
    }];
}

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

#pragma mark - PickerNavigationControllerDelegate

- (void)pickerNavigationController:(PickerNavigationController *)controller didSelectImage:(UIImage *)image {
    NSLog(@"%@",image);
}

- (void)pickerNavigationController:(PickerNavigationController *)controller didSelectImagesWithArray:(NSArray *)array {
    NSLog(@"%@",array);
}

#pragma mark - AlbumNotificationReciever

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRecieveNotification:) name:ALBUM_DID_PICK_IMAGE_NOTIFICATION object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:ALBUM_DID_PICK_IMAGE_NOTIFICATION];
}

- (void)didRecieveNotification:(NSNotification *)notification {
    self.pickedImageView.image = notification.object;
}

@end
