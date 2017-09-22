//
//  UIViewController+ScrollBackground.m
//  xgoods
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 Look. All rights reserved.
//

#import "UIViewController+ScrollBackground.h"
#import <objc/runtime.h>

@implementation SLBackGroundScrollView

@end

@interface SLBackGroundView ()<UIScrollViewDelegate>

@end

@implementation SLBackGroundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.bgScroll];

    }
    return self;
}

-(void)addSubview:(UIView *)view{
    if (view.sl_enableSuspension) {
        [super addSubview:view];
    }
    else{
        [self.bgScroll addSubview:view];
    }
}

-(UIScrollView *)bgScroll{
    if (_bgScroll==nil) {
        _bgScroll=[[SLBackGroundScrollView alloc] initWithFrame:self.bounds];
        _bgScroll.showsVerticalScrollIndicator=NO;
        _bgScroll.showsHorizontalScrollIndicator=NO;
        _bgScroll.sl_enableSuspension=YES;
        _bgScroll.delegate=self;
    }
    return _bgScroll;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!scrollView.bounces) {
        CGRect tmpBounds=scrollView.bounds;
        if (tmpBounds.origin.y<0) {
            tmpBounds.origin=CGPointMake(tmpBounds.origin.x, 0);
            scrollView.bounds=tmpBounds;
        }
    }
    if (_scrollBackgroundDelgate&&[_scrollBackgroundDelgate respondsToSelector:@selector(sl_scrollViewDidScroll:)]) {
        [_scrollBackgroundDelgate sl_scrollViewDidScroll:scrollView];
    }
}

@end

@implementation UIScrollView (ScrollBackground)

-(void)setSl_lastScrollContentOffset:(CGPoint)sl_lastScrollContentOffset{
    objc_setAssociatedObject(self, @selector(sl_lastScrollContentOffset), [NSValue valueWithCGPoint:sl_lastScrollContentOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGPoint)sl_lastScrollContentOffset{
    return [objc_getAssociatedObject(self, @selector(sl_lastScrollContentOffset)) CGPointValue];
}

@end

@implementation UIView (ScrollBackground)

static const void *sl_enableSuspensionKey = &sl_enableSuspensionKey;

-(void)setSl_enableSuspension:(BOOL)sl_enableSuspension{
    objc_setAssociatedObject(self, sl_enableSuspensionKey, @(sl_enableSuspension), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sl_enableSuspension&&[self.superview isKindOfClass:[SLBackGroundScrollView class]]) {
        self.frame=[self.superview convertRect:self.frame toView:self.superview.superview];
        [self.superview.superview addSubview:self];
    }
    if (!sl_enableSuspension&&![self.superview isKindOfClass:[SLBackGroundScrollView class]]&&[self.superview isKindOfClass:[SLBackGroundView class]]) {
        self.frame=[self.superview convertRect:self.frame toView:((SLBackGroundView*)self.superview).bgScroll];
        [((SLBackGroundView*)self.superview).bgScroll addSubview:self];
    }
}

-(BOOL)sl_enableSuspension{
    return [objc_getAssociatedObject(self, sl_enableSuspensionKey) boolValue];
}

@end

@implementation UIViewController (ScrollBackground)

static const void *sl_enableScrollBackgroundKey = &sl_enableScrollBackgroundKey;

-(void)setSl_enableScrollBackground:(BOOL)sl_enableScrollBackground{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        [(SLBackGroundView*)self.view bgScroll].scrollEnabled=sl_enableScrollBackground;
    }
    objc_setAssociatedObject(self, sl_enableScrollBackgroundKey, @(sl_enableScrollBackground), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)sl_enableScrollBackground{
    return [objc_getAssociatedObject(self, sl_enableScrollBackgroundKey) boolValue];
}

-(void)setSl_scrollBackgroundDelgate:(id<SL_UIViewControllerScrollBackgroundDelegate>)sl_scrollBackgroundDelgate{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        [(SLBackGroundView*)self.view setScrollBackgroundDelgate:sl_scrollBackgroundDelgate];
    }
}

-(id<SL_UIViewControllerScrollBackgroundDelegate>)sl_scrollBackgroundDelgate{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        return [(SLBackGroundView*)self.view scrollBackgroundDelgate];
    }
    return nil;
}

-(void)setSl_scrollBackgroundBounces:(BOOL)sl_scrollBackgroundBounces{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        [(SLBackGroundView*)self.view bgScroll].bounces=sl_scrollBackgroundBounces;
    }
    
}

-(BOOL)sl_scrollBackgroundBounces{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        return [(SLBackGroundView*)self.view bgScroll].bounces;
    }
    return NO;
}

-(void)setSl_scrollBackgroundContentSize:(CGSize)sl_scrollBackgroundContentSize{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        [(SLBackGroundView*)self.view bgScroll].contentSize=sl_scrollBackgroundContentSize;
    }
}

-(CGSize)sl_scrollBackgroundContentSize{
    if ([self.view isKindOfClass:[SLBackGroundView class]]) {
        return [(SLBackGroundView*)self.view bgScroll].contentSize;
    }
    return CGSizeZero;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(view);
        SEL swizzledSelector = @selector(sl_view);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(UIView *)sl_view{
    UIView *tmpView=[self sl_view];
    
    if (self.sl_enableScrollBackground) {
        if (![tmpView isKindOfClass:[SLBackGroundView class]]) {
            tmpView=[[SLBackGroundView alloc] initWithFrame:tmpView.frame];
            tmpView.backgroundColor=[UIColor whiteColor];
            [self setView:tmpView];
        }
        return tmpView;
    }
    else{
        return tmpView;
    }
}

@end
