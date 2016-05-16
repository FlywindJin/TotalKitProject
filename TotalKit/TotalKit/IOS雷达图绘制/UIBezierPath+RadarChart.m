//
//  UIBezierPath+RadarChart.m
//  TotalKit
//
//  Created by kinjin on 16/5/16.
//  Copyright © 2016年 kinjin. All rights reserved.
//

#import "UIBezierPath+RadarChart.h"

@implementation UIBezierPath (RadarChart)

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length
{
    NSArray *lengths = [NSArray arrayWithObjects:@(length),@(length),@(length),@(length),@(length), nil];
    return [self drawPentagonWithCenter:center LengthArray:lengths];
}
+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths
{
    NSArray *coordinates = [self converCoordinateFromLength:lengths Center:center];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < [coordinates count]; i++) {
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        if (i == 0) {
            [bezierPath moveToPoint:point];
        } else {
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath closePath];
    return bezierPath.CGPath;
}
+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < [lengthArray count] ; i++) {
        double length = [[lengthArray objectAtIndex:i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point =  CGPointMake(center.x - length * sin(M_PI / 5.0),
                                 center.y - length * cos(M_PI / 5.0));
        } else if (i == 1) {
            point = CGPointMake(center.x + length * sin(M_PI / 5.0),
                                center.y - length * cos(M_PI / 5.0));
        } else if (i == 2) {
            point = CGPointMake(center.x + length * cos(M_PI / 10.0),
                                center.y + length * sin(M_PI / 10.0));
        } else if (i == 3) {
            point = CGPointMake(center.x,
                                center.y +length);
        } else {
            point = CGPointMake(center.x - length * cos(M_PI / 10.0),
                                center.y + length * sin(M_PI / 10.0));
        }
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}
/*
#pragma mark - 描绘分数五边行  按照与各边成比例的速度放大
- (void)drawScorePentagonV
{
    NSArray *lengthsArray = [self convertLengthsFromScore:self.scoresArray];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) Length:0];
    pathAnimation.toValue = (id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) LengthArray:lengthsArray];
    pathAnimation.duration = 0.75;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.shapeLayer addAnimation:pathAnimation forKey:@"scale"];
    self.shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) LengthArray:lengthsArray];
    [self.layer addSublayer:self.shapeLayer];
    [self performSelector:@selector(changeBgSizeFinish) withObject:nil afterDelay:0.75];
}
#pragma mark - 描绘分数五边行  按照各边同样的速度放大
- (void)drawScorePentagonV
{
    NSArray *scoresArray = [self analysisScoreArray:self.scoresArray];
    NSMutableArray *lengthsArray = [NSMutableArray array];
    [lengthsArray addObject:(id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) Length:0.0]];
    for (int i = 0; i < [scoresArray count]; i++) {
        NSArray *scores = [scoresArray objectAtIndex:i];
        [lengthsArray addObject:(id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) LengthArray:[self convertLengthsFromScore:scores]]];
    }
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    frameAnimation.values = lengthsArray;
    frameAnimation.keyTimes = [self analysisDurationArray:self.scoresArray];
    frameAnimation.duration = 2;
    frameAnimation.calculationMode = kCAAnimationLinear;
    [self.shapeLayer addAnimation:frameAnimation forKey:@"scale"];
    self.shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) LengthArray:[self convertLengthsFromScore:[scoresArray lastObject]]];
    [self.layer addSublayer:self.shapeLayer];
    [self performSelector:@selector(changeBgSizeFinish) withObject:nil afterDelay:2];
}

#pragma mark - 描点
- (void)changeBgSizeFinish
{
    NSArray *array = [self convertLengthsFromScore:self.scoresArray];
    NSArray *lengthsArray = [UIBezierPath converCoordinateFromLength:array Center:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0)];
    for (int i = 0; i < [lengthsArray count]; i++) {
        CGPoint point = [[lengthsArray objectAtIndex:i] CGPointValue];
        RADotView *dotV = [[RADotView alloc] init];
        dotV.dotColor = [UIColor colorWithHex:0xF86465];
        dotV.center = point;
        dotV.bounds = CGRectMake(0, 0, 8, 8);
        [self addSubview:dotV];
    }
}
 
 */

#pragma mark - 分数转换
- (NSNumber *)convertLengthFromScore:(double)score
{
    if (score >= 4) {
        return @(12 + 22 + 30 + 30);
    } else if (score >= 3){
        return @(12 + 22 + 30 + 30 * (score - 3));
    } else if (score >= 2) {
        return @(12 + 22 + 30 * (score - 2));
    } else if (score >= 1) {
        return @(12 + 22 * (score - 1));
    } else  {
        return @(12 * score);
    }
}

- (NSArray *)convertLengthsFromScore:(NSArray *)scoreArray
{
    NSMutableArray *lengthArray = [NSMutableArray array];
    for (int i = 0; i < [scoreArray count]; i++) {
        double score = [[scoreArray objectAtIndex:i] doubleValue];
        [lengthArray addObject:[self convertLengthFromScore:score]];
    }
    return lengthArray;
}

#pragma mark - 对分数进行排序（第二种动画方法需要）
- (NSArray *)sortMergeScoresArray:(NSArray *)scores
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < [scores count]; i++) {
        [dic setObject:@"scoresValue" forKey:[scores objectAtIndex:i]];
    }
    
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:dic.allKeys];
    for (int i = 0; i < [sortArray count] - 1; i++) {
        for (int j = 0; j < [sortArray count] - i - 1 ; j++) {
            if ([[sortArray objectAtIndex:j] doubleValue] > [[sortArray objectAtIndex:j + 1] doubleValue]) {
                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                
            }
        }
    }
    return  sortArray;
}

- (NSArray *)analysisDurationArray:(NSArray *)scores
{
    NSMutableArray *analysisArray = [NSMutableArray array];
    NSArray *sortArray = [self sortMergeScoresArray:scores];
    double lastProportion = 0;
    [analysisArray addObject:@(0)];
    for (int i = 0; i < [sortArray count]; i++) {
        double currentProportion = [[sortArray objectAtIndex:i] doubleValue] / [[sortArray lastObject] doubleValue];
        [analysisArray addObject:@(currentProportion)];
        lastProportion = currentProportion;
    }
    return analysisArray;
}

- (NSArray *)analysisScoreArray:(NSArray *)scores
{
    NSArray *sortArray = [self sortMergeScoresArray:scores];
    
    NSMutableArray *analysisArray = [NSMutableArray array];
    
    for (int i = 0; i < [sortArray count]; i++) {
        double stepScore = [[sortArray objectAtIndex:i] doubleValue];
        NSMutableArray *analysisScores = [NSMutableArray array];
        for (int j = 0; j < [scores count]; j++) {
            double score = [[scores objectAtIndex:j] doubleValue];
            if (stepScore > score) {
                [analysisScores addObject:@(score)];
            } else {
                [analysisScores addObject:@(stepScore)];
            }
        }
        [analysisArray addObject:analysisScores];
    }
    return analysisArray;
}
@end
