//
//  AWDiscoverCollectionViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDiscoverCollectionViewCell.h"

@interface AWDiscoverCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *paperImgView;

@end

@implementation AWDiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.paperImgView.layer.cornerRadius = 5.f;
    self.paperImgView.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)resetWallPaperImg:(NSString *)imgUrl {
    [self.paperImgView loadNetworkImg:imgUrl bigPlaceHolder:YES];
}

@end
