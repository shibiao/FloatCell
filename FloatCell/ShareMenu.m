//
//  ShareMenu.m
//  FloatCell
//
//  Created by sycf_ios on 2017/5/16.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ShareMenu.h"
#import <QuartzCore/QuartzCore.h>
@interface ShareMenu ()
@property (nonatomic,strong) NSWindow *subWindow;

@end
@implementation ShareMenu

static ShareMenu *menu = nil;
+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menu = [[self alloc]init];
    });
    return menu;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _edgeOffset = 10;
    }
    return self;
}
-(void)setEdgeOffset:(CGFloat)edgeOffset{
    _edgeOffset = edgeOffset;
}

-(NSWindow *)subWindow{
    if (!_subWindow) {
        _subWindow = [[NSWindow alloc]init];
        _subWindow.styleMask = NSWindowStyleMaskFullSizeContentView|NSWindowStyleMaskTitled;
        _subWindow.backingType = NSBackingStoreNonretained;
        _subWindow.titlebarAppearsTransparent = YES;
        _subWindow.titleVisibility = NSWindowTitleHidden;
        
    }
    return _subWindow;
}

-(void)popOverMenuWithItem:(NSCollectionViewItem *)item {
    //转换item在contentView中的左边位置
    NSRect rect = [item.view.window.contentView convertRect:item.view.frame fromView:item.collectionView];
    [self.subWindow setFrame:NSMakeRect(item.view.window.frame.origin.x
                                        + item.view.frame.origin.x
                                        - _edgeOffset
                                        ,item.view.window.frame.origin.y
                                        + rect.origin.y
                                        - _edgeOffset
                                        , item.view.bounds.size.width
                                        + _edgeOffset * 2
                                        , item.view.bounds.size.height
                                        + _edgeOffset * 2) display:YES];
    //-------------------------------------------------------------------
    //-------------------------在此处创建contentView----------------------
    //实例1
//    NSView *redView = [[NSView alloc]initWithFrame:NSMakeRect(0, 0, 0, 0)];
//    redView.wantsLayer = YES;
//    redView.layer.backgroundColor = [NSColor redColor].CGColor;
//    redView.animator.alphaValue = 0.3;
//    self.subWindow.contentView = redView;
    //实例2
    NSView *backgroundView = [[NSView alloc]init];
    backgroundView.wantsLayer = YES;
    backgroundView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    NSView *tmpView = [[[NSStoryboard storyboardWithName:@"Main" bundle:nil]instantiateControllerWithIdentifier:@"copyItem"] view];
    tmpView.animator.alphaValue = 0.3;
    tmpView.layer.cornerRadius = 5;
    self.subWindow.contentView = backgroundView;
    [backgroundView addSubview:tmpView];
    
    //-------------------------------------------------------------------
    [NSAnimationContext  runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = kDuration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        redView.animator.alphaValue = 0.99;
        tmpView.animator.alphaValue = 0.8;
        [item.view.window.animator addChildWindow:self.subWindow ordered:NSWindowAbove];
    } completionHandler:nil];
    
}
//关闭
-(void)close{
    if (_subWindow) {
        [NSApp.keyWindow removeChildWindow:self.subWindow];
        self.subWindow = nil;
    }
}
@end
