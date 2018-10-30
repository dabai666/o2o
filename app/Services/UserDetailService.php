<?php namespace YiZan\Services;

use YiZan\Models\UserDetail;
use YiZan\Models\UserAddress;
use DB;

class UserDetailService extends BaseService {

	//获取会员注册时详细信息
    public static function detail($userid) {
		
		$info = UserDetail::where('user_id', $userid)->first();
		$address = UserAddress::where('user_id',$userid)->where('is_reg','1')->first();
        $detail['info'] = $info;
        $detail['address'] = $address;
		
		return $detail;
    }
	
	//保存会员注册时详细信息
	public static function save($userId,$shopname,$personcharge,$shoptype,$addressid,$phone){

		$userInfo = UserDetail::where('user_id', $userId)->first();
		if($userInfo){
			$result['code'] = 0;
			$result['data'] = $userInfo;
			return $result;
		}
		$userDetail = new UserDetail();
		$userDetail->user_id = $userId;
		$userDetail->shopname = $shopname;
		$userDetail->personcharge = $personcharge;
		$userDetail->shoptype = $shoptype;
		$userDetail->addressid = $addressid ? $addressid : 0;
		$userDetail->phone = $phone;
		$userDetail->createtime = UTC_TIME;

		DB::beginTransaction();
        try{
            $userDetail->save();
            DB::commit();
            $result['code'] = 0;
            $result['data'] = $userDetail->toArray();
        }catch(Exception $e ){
            DB::rollback();
            $result['code'] = 10000;
        }
        return $result;
		
	}
	
}
