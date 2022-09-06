//  Created by Dominik Hauser on 31.08.22.
//  
//

#import "GameNodeFactory.h"

@implementation GameNodeFactory

+ (SCNNode *)ground {
    SCNMaterial *groundMaterial = [[SCNMaterial alloc] init];
    groundMaterial.diffuse.contents = [UIColor colorWithWhite:0.3 alpha:1];

    SCNFloor *floor = [[SCNFloor alloc] init];
    floor.reflectivity = 0.2;
    floor.materials = @[groundMaterial];

    SCNNode *groundNode = [SCNNode nodeWithGeometry: floor];
    groundNode.position = SCNVector3Make(0, -6, 0);
    return groundNode;
}

+ (SCNLight *)ambientLight {
    SCNLight *light = [[SCNLight alloc] init];
    light.color = [UIColor grayColor];
    light.type = SCNLightTypeAmbient;
    return light;
}

+ (SCNNode *)camera: (SCNLookAtConstraint *)constraint {
    SCNCamera *camera = [[SCNCamera alloc] init];
    camera.zFar = 10000;

    SCNNode *cameraNode = [[SCNNode alloc] init];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 35, 45);
    cameraNode.constraints = @[constraint];
    cameraNode.light = [self ambientLight];
    return cameraNode;
}

+ (SCNNode *)spotLight: (SCNLookAtConstraint *)constraint {
    SCNLight *spotLight = [[SCNLight alloc] init];
    spotLight.type = SCNLightTypeSpot;
    spotLight.castsShadow = YES;
    spotLight.spotInnerAngle = 70;
    spotLight.spotOuterAngle = 90;
    spotLight.zFar = 500;
    spotLight.intensity = 800;

    SCNNode *spotLightNode = [[SCNNode alloc] init];
    spotLightNode.light = spotLight;
    spotLightNode.position = SCNVector3Make(20, 50, 50);
    spotLightNode.constraints = @[constraint];
    return spotLightNode;
}

+ (SCNNode *)cameraRootNode:(SCNLookAtConstraint *)constraint {
    SCNNode *cameraRootNode = [[SCNNode alloc] init];
    [cameraRootNode addChildNode:[self camera:constraint]];
    [cameraRootNode addChildNode:[self spotLight:constraint]];
    return cameraRootNode;
}

+ (SCNNode *)base {
    SCNMaterial *material = [[SCNMaterial alloc] init];
    material.diffuse.contents = [UIColor colorWithRed:0.8 green:0.7 blue:0.2 alpha:1.0];

    SCNGeometry *geometry = [SCNBox boxWithWidth:30 height:6 length:30 chamferRadius:2];
    geometry.materials = @[material];

    SCNNode *base = [[SCNNode alloc] init];
    base.geometry = geometry;
    base.position = SCNVector3Make(0, -3, 0);
    return base;
}

+ (SCNMaterial *)poleMaterial {
    SCNMaterial *material = [[SCNMaterial alloc] init];
    material.diffuse.contents = [[UIColor yellowColor] colorWithAlphaComponent:0.8];
    return material;
}

+ (NSArray<NSArray<SCNNode *> *> *)poles:(NSInteger)columns addToNode:(SCNNode *)node {
    CGFloat boardWidth = 22;
    CGFloat poleSpacing = boardWidth/3;

    NSMutableArray<NSArray <SCNNode *> *> *poleNodes = [[NSMutableArray<NSArray <SCNNode *> *> alloc] init];

    for (int j = 0; j < columns; j++) {
        NSMutableArray<SCNNode *> *columnNodes = [[NSMutableArray<SCNNode *> alloc] init];
        for (int i = 0; i < columns; i++) {
            SCNGeometry *poleGeometry = [SCNCylinder cylinderWithRadius: 1.4 height: 24];
            poleGeometry.materials = @[[self poleMaterial]];

            SCNNode *poleNode = [SCNNode nodeWithGeometry:poleGeometry];
            poleNode.position = SCNVector3Make(poleSpacing * i - boardWidth / 2, 5, poleSpacing * j - boardWidth / 2);

            [node addChildNode:poleNode];
            [columnNodes addObject: poleNode];
        }
        [poleNodes addObject:columnNodes];
    }
    return poleNodes;
}

+ (SCNNode *)text: (NSString *)string {
    SCNText *text = [SCNText textWithString: string extrusionDepth: 1];
    text.font = [UIFont boldSystemFontOfSize:10];

    SCNNode *textNode = [SCNNode nodeWithGeometry: text];
    textNode.position = SCNVector3Make(-10, 15, 15);
    textNode.hidden = true;
    textNode.castsShadow = false;
    return textNode;
}

+ (SCNLookAtConstraint *)lookAtConstraint:(SCNNode *)node {
    SCNLookAtConstraint *constraint = [SCNLookAtConstraint lookAtConstraintWithTarget:node];
    constraint.gimbalLockEnabled = YES;
    constraint.influenceFactor = 0.8;
    return constraint;
}

@end
