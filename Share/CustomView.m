//
//  CustomView.m
//
//  Code generated using QuartzCode 1.37.3 on 8/30/15.
//  www.quartzcodeapp.com
//

#import "CustomView.h"
#import "QCMethod.h"

@interface CustomView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;
@property (nonatomic, assign) BOOL  updateLayerValueForCompletedAnimation;


@end

@implementation CustomView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}



- (void)setupProperties{
	self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
	self.layers = [NSMutableDictionary dictionary];
	
}

- (void)setupLayers{
	CALayer * aLayer = [CALayer layer];
	aLayer.frame = CGRectMake(0, -0.11, 400, 600);
	[self.layer addSublayer:aLayer];
	self.layers[@"aLayer"] = aLayer;
	
	CALayer * aLayer2 = [CALayer layer];
	aLayer2.frame = CGRectMake(125, 91.88, 150, 150);
	[self.layer addSublayer:aLayer2];
	self.layers[@"aLayer2"] = aLayer2;
	
	CALayer * star1 = [CALayer layer];
	star1.frame = CGRectMake(172.5, 122.31, 55, 55);
	[self.layer addSublayer:star1];
	self.layers[@"star1"] = star1;
	
	CAShapeLayer * rectangle2 = [CAShapeLayer layer];
	rectangle2.frame = CGRectMake(145.78, 260.72, 1, 5.51);
	rectangle2.path = [self rectangle2Path].CGPath;
	[self.layer addSublayer:rectangle2];
	self.layers[@"rectangle2"] = rectangle2;
	
	CAShapeLayer * rectangle4 = [CAShapeLayer layer];
	rectangle4.frame = CGRectMake(0.5, 254.87, 146.78, 20.96);
	rectangle4.path = [self rectangle4Path].CGPath;
	[self.layer addSublayer:rectangle4];
	self.layers[@"rectangle4"] = rectangle4;
	
	CATextLayer * text = [CATextLayer layer];
	text.frame = CGRectMake(128.98, 273.52, 144.04, 41.93);
	[self.layer addSublayer:text];
	self.layers[@"text"] = text;
	
	CAShapeLayer * rectangle3 = [CAShapeLayer layer];
	rectangle3.frame = CGRectMake(148.28, 269.23, 250, 46.21);
	rectangle3.path = [self rectangle3Path].CGPath;
	[self.layer addSublayer:rectangle3];
	self.layers[@"rectangle3"] = rectangle3;
	
	[self resetLayerPropertiesForLayerIdentifiers:nil];
}

- (void)resetLayerPropertiesForLayerIdentifiers:(NSArray *)layerIds{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	
	if(!layerIds || [layerIds containsObject:@"aLayer"]){
		CALayer * aLayer = self.layers[@"aLayer"];
		aLayer.backgroundColor = [UIColor colorWithRed:0.518 green: 0.961 blue:0.722 alpha:1].CGColor;
	}
	if(!layerIds || [layerIds containsObject:@"aLayer2"]){
		CALayer * aLayer2 = self.layers[@"aLayer2"];
		aLayer2.contents = (id)[UIImage imageNamed:@"aLayer2"].CGImage;
	}
	if(!layerIds || [layerIds containsObject:@"star1"]){
		CALayer * star1 = self.layers[@"star1"];
		[star1 setValue:@(-139.52 * M_PI/180) forKeyPath:@"transform.rotation"];
		star1.cornerRadius = 10;
		star1.contents     = (id)[UIImage imageNamed:@"star1"].CGImage;
	}
	if(!layerIds || [layerIds containsObject:@"rectangle2"]){
		CAShapeLayer * rectangle2 = self.layers[@"rectangle2"];
		rectangle2.fillColor   = [UIColor colorWithRed:0.808 green: 0.188 blue:0.212 alpha:1].CGColor;
		rectangle2.strokeColor = [UIColor colorWithRed:0.808 green: 0.188 blue:0.212 alpha:1].CGColor;
	}
	if(!layerIds || [layerIds containsObject:@"rectangle4"]){
		CAShapeLayer * rectangle4 = self.layers[@"rectangle4"];
		rectangle4.fillColor   = [UIColor colorWithRed:0.518 green: 0.961 blue:0.722 alpha:1].CGColor;
		rectangle4.strokeColor = [UIColor colorWithRed:0.518 green: 0.961 blue:0.722 alpha:1].CGColor;
	}
	if(!layerIds || [layerIds containsObject:@"text"]){
		CATextLayer * text = self.layers[@"text"];
		text.contentsScale   = [[UIScreen mainScreen] scale];
		text.string          = @"SHARE";
		text.font            = (__bridge CFTypeRef)@"Avenir-Medium";
		text.fontSize        = 33;
		text.alignmentMode   = kCAAlignmentCenter;
		text.foregroundColor = [UIColor whiteColor].CGColor;
	}
	if(!layerIds || [layerIds containsObject:@"rectangle3"]){
		CAShapeLayer * rectangle3 = self.layers[@"rectangle3"];
		rectangle3.fillColor   = [UIColor colorWithRed:0.518 green: 0.961 blue:0.722 alpha:1].CGColor;
		rectangle3.strokeColor = [UIColor colorWithRed:0.518 green: 0.961 blue:0.722 alpha:1].CGColor;
	}
	
	[CATransaction commit];
}

#pragma mark - Animation Setup

- (void)addUntitled1Animation{
	[self addUntitled1AnimationCompletionBlock:nil];
}

- (void)addUntitled1AnimationCompletionBlock:(void (^)(BOOL finished))completionBlock{
	if (completionBlock){
		CABasicAnimation * completionAnim = [CABasicAnimation animationWithKeyPath:@"completionAnim"];;
		completionAnim.duration = 1.786;
		completionAnim.delegate = self;
		[completionAnim setValue:@"Untitled1" forKey:@"animId"];
		[completionAnim setValue:@(NO) forKey:@"needEndAnim"];
		[self.layer addAnimation:completionAnim forKey:@"Untitled1"];
		[self.completionBlocks setObject:completionBlock forKey:[self.layer animationForKey:@"Untitled1"]];
	}
	
	NSString * fillMode = kCAFillModeForwards;
	
	////ALayer2 animation
	CAKeyframeAnimation * aLayer2OpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	aLayer2OpacityAnim.values   = @[@0, @1];
	aLayer2OpacityAnim.keyTimes = @[@0, @1];
	aLayer2OpacityAnim.duration = 1;
	
	CAAnimationGroup * aLayer2Untitled1Anim = [QCMethod groupAnimations:@[aLayer2OpacityAnim] fillMode:fillMode];
	[self.layers[@"aLayer2"] addAnimation:aLayer2Untitled1Anim forKey:@"aLayer2Untitled1Anim"];
	
	////Star1 animation
	CAKeyframeAnimation * star1TransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	star1TransformAnim.values   = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)], 
		 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)], 
		 [NSValue valueWithCATransform3D:CATransform3DIdentity], 
		 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(218 * M_PI/180, 0, 0, -1)], 
		 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(218 * M_PI/180, 0, 0, -1)]];
	star1TransformAnim.keyTimes = @[@0, @0.301, @0.573, @1, @1];
	star1TransformAnim.duration = 1.74;
	
	CAAnimationGroup * star1Untitled1Anim = [QCMethod groupAnimations:@[star1TransformAnim] fillMode:fillMode];
	[self.layers[@"star1"] addAnimation:star1Untitled1Anim forKey:@"star1Untitled1Anim"];
	
	////Rectangle2 animation
	CAKeyframeAnimation * rectangle2TransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	rectangle2TransformAnim.values    = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], 
		 [NSValue valueWithCATransform3D:CATransform3DMakeScale(110, 1, 1)]];
	rectangle2TransformAnim.keyTimes  = @[@0, @1];
	rectangle2TransformAnim.duration  = 0.731;
	rectangle2TransformAnim.beginTime = 0.998;
	
	CAAnimationGroup * rectangle2Untitled1Anim = [QCMethod groupAnimations:@[rectangle2TransformAnim] fillMode:fillMode];
	[self.layers[@"rectangle2"] addAnimation:rectangle2Untitled1Anim forKey:@"rectangle2Untitled1Anim"];
	
	////Text animation
	CAKeyframeAnimation * textOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	textOpacityAnim.values                = @[@0, @1];
	textOpacityAnim.keyTimes              = @[@0, @1];
	textOpacityAnim.duration              = 0.745;
	textOpacityAnim.beginTime             = 0.984;
	
	CAAnimationGroup * textUntitled1Anim = [QCMethod groupAnimations:@[textOpacityAnim] fillMode:fillMode];
	[self.layers[@"text"] addAnimation:textUntitled1Anim forKey:@"textUntitled1Anim"];
	
	////Rectangle3 animation
	CAKeyframeAnimation * rectangle3TransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	rectangle3TransformAnim.values    = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], 
		 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 1, 1)]];
	rectangle3TransformAnim.keyTimes  = @[@0, @1];
	rectangle3TransformAnim.duration  = 0.802;
	rectangle3TransformAnim.beginTime = 0.984;
	
	CAAnimationGroup * rectangle3Untitled1Anim = [QCMethod groupAnimations:@[rectangle3TransformAnim] fillMode:fillMode];
	[self.layers[@"rectangle3"] addAnimation:rectangle3Untitled1Anim forKey:@"rectangle3Untitled1Anim"];
}

#pragma mark - Animation Cleanup

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	void (^completionBlock)(BOOL) = [self.completionBlocks objectForKey:anim];;
	if (completionBlock){
		[self.completionBlocks removeObjectForKey:anim];
		if ((flag && self.updateLayerValueForCompletedAnimation) || [[anim valueForKey:@"needEndAnim"] boolValue]){
			[self updateLayerValuesForAnimationId:[anim valueForKey:@"animId"]];
			[self removeAnimationsForAnimationId:[anim valueForKey:@"animId"]];
		}
		completionBlock(flag);
	}
}

- (void)updateLayerValuesForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"aLayer2"] animationForKey:@"aLayer2Untitled1Anim"] theLayer:self.layers[@"aLayer2"]];
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"star1"] animationForKey:@"star1Untitled1Anim"] theLayer:self.layers[@"star1"]];
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"rectangle2"] animationForKey:@"rectangle2Untitled1Anim"] theLayer:self.layers[@"rectangle2"]];
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"text"] animationForKey:@"textUntitled1Anim"] theLayer:self.layers[@"text"]];
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"rectangle3"] animationForKey:@"rectangle3Untitled1Anim"] theLayer:self.layers[@"rectangle3"]];
	}
}

- (void)removeAnimationsForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[self.layers[@"aLayer2"] removeAnimationForKey:@"aLayer2Untitled1Anim"];
		[self.layers[@"star1"] removeAnimationForKey:@"star1Untitled1Anim"];
		[self.layers[@"rectangle2"] removeAnimationForKey:@"rectangle2Untitled1Anim"];
		[self.layers[@"text"] removeAnimationForKey:@"textUntitled1Anim"];
		[self.layers[@"rectangle3"] removeAnimationForKey:@"rectangle3Untitled1Anim"];
	}
}

- (void)removeAllAnimations{
	[self.layers enumerateKeysAndObjectsUsingBlock:^(id key, CALayer *layer, BOOL *stop) {
		[layer removeAllAnimations];
	}];
}

#pragma mark - Bezier Path

- (UIBezierPath*)rectangle2Path{
	UIBezierPath * rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 6)];
	return rectangle2Path;
}

- (UIBezierPath*)rectangle4Path{
	UIBezierPath * rectangle4Path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 147, 21)];
	return rectangle4Path;
}

- (UIBezierPath*)rectangle3Path{
	UIBezierPath * rectangle3Path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 250, 46)];
	return rectangle3Path;
}


@end