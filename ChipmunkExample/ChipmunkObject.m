//
//  ChipmunkObject.m
//  ChipmunkExample
//
//  Created by Игорь Мищенко on 24.07.13.
//  Copyright (c) 2013 Igor Mischenko. All rights reserved.
//

#import "ChipmunkObject.h"

@implementation ChipmunkObject

- (id)initWithView:(UIView *)view {
    
    if (self = [self init]) {
        
        _view = view;
        
        CGFloat radius   = _view.frame.size.width/2;
        CGPoint position = _view.center;
        
        _view.center = CGPointZero;
        
        cpFloat mass = 1;
        ChipmunkBody *body = [[ChipmunkBody alloc] initWithMass:mass
                                                      andMoment:cpMomentForCircle(mass, radius, 0, cpvzero)];
        body.pos = position;
        body.data = self;
        
        ChipmunkCircleShape *shape = [[ChipmunkCircleShape alloc] initWithBody:body radius:radius offset:cpvzero];
        shape.elasticity = 1.0;
        shape.collisionType = [ChipmunkObject class];
        shape.data = self;
        
        _body = body;
        _shape = shape;
        
        _chipmunkObjects = [NSArray arrayWithObjects:_body, _shape, nil];
        
        [self updatePosition];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {

    UIView *view = [[UIView alloc] initWithFrame:frame];
    return [self initWithView:view];
}


- (void)updatePosition {
    
    self.view.transform = self.body.affineTransform;
    //    NSLog(@"body position %@", NSStringFromCGPoint(self.body.pos));
}

@end
