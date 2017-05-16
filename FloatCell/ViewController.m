//
//  ViewController.m
//  FloatCell
//
//  Created by sycf_ios on 2017/5/15.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ViewController.h"
#import "SBCollectionItem.h"
@interface ViewController ()<NSCollectionViewDataSource,NSCollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *data;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setSelectable:YES];
    [self.collectionView registerNib:[[NSNib alloc]initWithNibNamed:@"SBCollectionItem" bundle:nil] forItemWithIdentifier:@"SBCollectionItem"];
    
}
-(void)viewDidAppear{
    [super viewDidAppear];
    
}
//MARK: NSCollectionViewDataSource&NSCollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    SBCollectionItem *item = [collectionView makeItemWithIdentifier:@"SBCollectionItem" forIndexPath:indexPath];
    item.text.stringValue = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.item];
    return item;
}
//- (NSSet<NSIndexPath *> *)collectionView:(NSCollectionView *)collectionView shouldChangeItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths toHighlightState:(NSCollectionViewItemHighlightState)highlightState NS_AVAILABLE_MAC(10_11);


- (void)collectionView:(NSCollectionView *)collectionView didChangeItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths toHighlightState:(NSCollectionViewItemHighlightState)highlightState {
    NSLog(@"didChangeItemsAtIndexPaths:%@",indexPaths);
    NSLog(@"%s",__func__);
}


//- (NSSet<NSIndexPath *> *)collectionView:(NSCollectionView *)collectionView shouldSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
//    
//}


//- (NSSet<NSIndexPath *> *)collectionView:(NSCollectionView *)collectionView shouldDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths NS_AVAILABLE_MAC(10_11);


- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSLog(@"didSelectItemsAtIndexPaths:%@",indexPaths);
    NSLog(@"%s",__func__);
}


- (void)collectionView:(NSCollectionView *)collectionView didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSLog(@"didDeselectItemsAtIndexPaths:%@",indexPaths);
    NSLog(@"%s",__func__);
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
