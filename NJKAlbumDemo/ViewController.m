//
//  ViewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "ViewController.h"
#import "PickerNavigationController.h"
#import "AlbumChooseController.h"
#import "PhotoListViewController.h"
#import "AAPLRootListViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pickedImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)albumButtonDidClick:(UIButton *)sender {
    UIViewController *viewController = nil;
//    UIViewController *viewController = [[UIViewController alloc] init];
//    viewController.view.backgroundColor = [UIColor greenColor];
//    viewController.title = @"123";
//    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    if ([sender.titleLabel.text isEqualToString:@"Album"]) {
//        viewController = [[AlbumChooseController alloc] init];
        viewController = [[AAPLRootListViewController alloc] init];
    } else if ([sender.titleLabel.text isEqualToString:@"OldAlbum"]) {
        viewController = [[PhotoListViewController alloc] init];
    } else if ([sender.titleLabel.text isEqualToString:@"CloudAlbum"]) {
        
    }
//    PickerNavigationController *navigationController = [[PickerNavigationController alloc] initWithRootViewController:viewController];
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

@end
