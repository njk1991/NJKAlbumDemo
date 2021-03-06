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

@interface ViewController () <AlbumNotificationReciever>

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
    UIViewController *viewController = nil;
    if ([sender.titleLabel.text isEqualToString:@"Album"]) {
        viewController = [[AlbumChooseController alloc] init];
    } else if ([sender.titleLabel.text isEqualToString:@"OldAlbum"]) {
        viewController = [[OldAlbumChooseController alloc] init];
    } else if ([sender.titleLabel.text isEqualToString:@"CloudAlbum"]) {
        
    }
    if (!viewController) {
        return;
    }
    UINavigationController *navigationController = [[PickerNavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:^{
        nil;
    }];
}

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
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
