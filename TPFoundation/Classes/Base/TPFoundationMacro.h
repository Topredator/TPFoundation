//
//  TPFoundationMacro.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#ifndef TPFoundationMacro_h
#define TPFoundationMacro_h

//给所有扩展加上这个，就不用添加-all_load 或者 -force_load。
#ifndef TPSYNTH_DUMMY_CLASS
#define TPSYNTH_DUMMY_CLASS(_name_) \
@interface TPSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation TPSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


#endif /* TPFoundationMacro_h */
