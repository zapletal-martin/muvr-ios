#import <Foundation/Foundation.h>

typedef NSString MRExercise;

///
/// Actions executed as results of exercise
///
@protocol MRClassificationPipelineDelegate

///
/// Classification successful
///
- (void)classificationSucceeded:(MRExercise *)exercise fromData:(NSData *)data;

///
/// Classification ambiguous
///
- (void)classificationAmbiguous:(NSArray *)exercises fromData:(NSData *)data;

///
/// Classification failed
///
- (void)classificationFailed:(NSData *)data;
@end

///
/// Interface to the C++ codebase implementing the classification pipeline code
///
@interface MRClassificationPipeline : NSObject

///
/// Constructs an instance, sets up the underlying native structures
///
- (instancetype)init;

///
/// Classify the session data
///
- (int)classify:(NSData *)data;

///
/// Sets the exercise block delegate, whose methods get called when entire exercise
/// block is detected.
///
@property id<MRClassificationPipelineDelegate> classificationPipelineDelegate;
@end