//
//  ViewController.m
//  Chess
//
//  Created by Ivan Babich on 12.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBoard];
    [self addFiguresOnBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIView * anotherView = [self.view hitTest:point withEvent:event];
    if (![anotherView isEqual:self.view]) {
        self.someView = anotherView;
        [self.view bringSubviewToFront:self.someView];
        UITouch * touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.someView];
        self.differencePoint = CGPointMake(CGRectGetMidX(self.someView.bounds)-point.x, CGRectGetMidY(self.someView.bounds)-point.y);
        [UIView animateWithDuration:0.3 animations:^{
            self.someView.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
            self.someView.alpha = 0.5;}];
    }
    else
        self.someView = nil;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.someView) {
        UITouch * touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CGPoint makePoint = CGPointMake(point.x + self.differencePoint.x,
                                        point.y + self.differencePoint.y);
        self.someView.center = makePoint;
        }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        self.someView.transform = CGAffineTransformIdentity;
        self.someView.alpha = 1;}];
}


/*--------------------------------------------------------------------------------*/
#pragma mark - Chess

- (void) addFiguresOnBoard {
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * names = [NSMutableArray array];
    NSFileManager * managers = [NSFileManager new];
    NSBundle * bundle = [NSBundle mainBundle];
    NSDirectoryEnumerator * enumerator = [managers enumeratorAtPath:[bundle bundlePath]];
    for (NSString * name in enumerator) {
        if ([name hasSuffix:@".jpg"]) {
            [names addObject:name];
        }
    }
    for (NSString * imageName in names) {
        UIImage * image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    NSInteger xWhite = 18;
    NSInteger yWhite = 120;
        for (int i = 0; i < images.count; i++) {
            if (xWhite >= 755) {
                yWhite -= 93;
                xWhite = 18;
            }
                UIView * figureView = [[UIView alloc]initWithFrame:CGRectMake(xWhite, yWhite, 80, 80)];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:figureView.bounds];
                imageView.image = [images objectAtIndex:i];
                [figureView addSubview:imageView];
                [self.view addSubview:figureView];
            xWhite += 93;
        }
}

-(void) addBoard {
    NSInteger yWhite = 20;              // Переменные расположения белых и черных view по x и по y
    NSInteger xWhite;
    NSInteger yBlack = 20;
    NSInteger xBlack;
    for (int i = 1; i <= 8; i++) {             // 1-й цикл добавляет view по оси y
        if (i % 2 == 1) {
            xWhite = 12;
            xBlack = 105;
        }
        else  {
            xWhite = 105;
            xBlack = 12;
        }
            for (int j = 1; j <= 4; j++) {     // 2-й цикл добавляет view по оси x
                UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(xWhite, yWhite, 93, 93)];
                UIView * blackView = [[UIView alloc]initWithFrame:CGRectMake(xBlack, yBlack, 93, 93)];
                whiteView.backgroundColor = [UIColor whiteColor];
                blackView.backgroundColor = [UIColor brownColor];
                self.whiteView = whiteView;
                self.blackView = blackView;
                [self.view addSubview:self.blackView];
                [self.view addSubview:self.whiteView];
                xWhite += 186;
                xBlack += 186;
            }
        yWhite += 93;
        yBlack += 93;
    }
}

@end
