<?php 
namespace YiZan\Services\System;

use YiZan\Models\System\Adv;
use YiZan\Models\System\AdvPosition;
use YiZan\Utils\String;
use YiZan\Utils\Time;
use DB, Validator;
/**
 * 广告管理
 */
class AdvService extends \YiZan\Services\AdvService 
{
	/**
     * 广告列表
     * @param string $clientType 客户端类型
     * @param  string $code 页码
     * @param  int $page 页码
     * @param  int $pageSize 每页数
     * @return array          广告信息
     */
	public static function getList($code, $page,$pageSize) 
    {
        $list = Adv::orderBy('id', 'desc');

        if ($code !== '') {
            $list->whereIn("position_id", function($query)use($code)
            {
                $query->select("id")
                    ->from('adv_position')
                    ->where('client_type', $code);

            });
        }
        
        $totalCount = $list->count();

        $list = $list->with('city', 'position')
            ->skip(($page - 1) * $pageSize)
            ->take($pageSize)
            ->get()
            ->toArray();
        
		return ["list"=>$list, "totalCount"=>$totalCount];
	}

    /**
     * 添加广告
     * @param int $cityId 显示城市
     * @param int $positionId 广告位编号
     * @param string $name 广告名称
     * @param string $image 图片
     * @param string $bgColor 背景颜色
     * @param string $type 动作类型
     * @param string $arg 动作参数
     * @param int $sort 排序
     * @param int $status 状态
     * @return array   创建结果
     */
    public static function create($cityId, $positionId, $name, $image, $bgColor, $type, $arg, $sort, $status, $sellerCateId,$image1,$type1,$arg1,$image2,$type2,$arg2,$image3,$type3,$arg3,$image4,$type4,$arg4,$flage,$title2='',$instruction2='',$instruction2Bg='',$title3='',$instruction3='',$instruction3Bg='',$title4='',$instruction4='',$instruction4Bg='')
    {
        if($flage==1) { //1+3广告
            $result = array(
                'code' => self::SUCCESS,
                'data' => null,
                'msg' => ''
            );

            $rules = array(
                'name' => ['required'],
                'image1' => ['required'],
                'image2' => ['required'],
                'image3' => ['required'],
                'image4' => ['required'],
            );

            $messages = array(
                'name.required' => 70103,    // 请填写名称
                'image1.required' => 70104, // 请上传图片
                'image2.required' => 70104,
                'image3.required' => 70104,
                'image4.required' => 70104,
            );

            $validator = Validator::make(
                [
                    'name' => $name,
                    'image1' => $image1,
                    'image2' => $image2,
                    'image3' => $image3,
                    'image4' => $image4,
                ], $rules, $messages);

            //验证信息
            if ($validator->fails()) {
                $messages = $validator->messages();

                $result['code'] = $messages->first();

                return $result;
            }
        }else { //其它广告
            $result = array(
                'code' => self::SUCCESS,
                'data' => null,
                'msg' => ''
            );

            $rules = array(
                'name' => ['required'],
                'image' => ['required'],
                'type' => ['required'],
            );

            $messages = array(
                'name.required' => 70103,    // 请填写名称
                'image.required' => 70104,
                'type.required' => 70106,
            );

            $validator = Validator::make(
                [
                    'name' => $name,
                    'image' => $image,
                    'type'  => $type

                ], $rules, $messages);
            //验证信息
            if ($validator->fails()) {
                $messages = $validator->messages();

                $result['code'] = $messages->first();

                return $result;
            }


            $image = self::movePublicImage($image);
            if (!$image) {
                $result['code'] = 70105;
                return $result;
            }

            //APP启动广告位验证，只保证数据库存在一条信息
            $buyer_start_banner_id = AdvPosition::where('code', 'BUYER_START_BANNER')->pluck('id');
            if ($buyer_start_banner_id > 0 && $buyer_start_banner_id == $positionId && Adv::where('position_id', $buyer_start_banner_id)->first()) {
                $result['code'] = 70313; //添加失败！启动页广告已存在，请勿重复添加。

                return $result;
            }

            if ($type < 8 && $arg === '') {
                $result['code'] = 70108;
                return $result;
            }
			if($type == 5){
					if(!preg_match("/^(http:\/\/|https:\/\/).*$/",$arg)){
					$arg = "http://"  .  $arg;
				}
			}
        }

        $adv = new Adv();

  
        $adv->city_id       = $cityId;
        $adv->position_id   = $positionId;
        $adv->name          = $name;
        $adv->image         = $image;
        $adv->bg_color      = $bgColor;
        $adv->type          = $type;
        $adv->arg           = $arg;
        $adv->sort 	        = $sort;
        $adv->status 	    = $status;
        $adv->create_time   = Time::getTime();
        $adv->seller_cate_id = $sellerCateId;
        $adv->image1=$image1;
        $adv->type1=$type1;
        $adv->arg1=$arg1;
        $adv->image2=$image2;
        $adv->type2=$type2;
        $adv->arg2=$arg2;
        $adv->image3=$image3;
        $adv->type3=$type3;
        $adv->arg3=$arg3;
        $adv->image4=$image4;
        $adv->type4=$type4;
        $adv->arg4=$arg4;
        $adv->flage=$flage;
        $adv->title2 = $title2;
        $adv->instruction2 = $instruction2;
        $adv->instruction2_bg = $instruction2Bg;
        $adv->title3 = $title3;
        $adv->instruction3 = $instruction3;
        $adv->instruction3_bg = $instruction3Bg;
        $adv->title4 = $title4;
        $adv->instruction4 = $instruction4;
        $adv->instruction4_bg = $instruction4Bg;
        $adv->adv_serialize = '';

        $res = $adv->save();
       return $result;
    }
    public static function create1($name, $cityId, $positionId,  $flage, $sort, $status, $advSerialize)
    {
        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'name' => ['required'],
        );

        $messages = array(
            'name.required' => 70103,    // 请填写名称
        );

        $validator = Validator::make(
            [
                'name' => $name,

            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();

            $result['code'] = $messages->first();

            return $result;
        }


        /*$image = self::movePublicImage($image);
        if (!$image) {
            $result['code'] = 70105;
            return $result;
        }*/

        //APP启动广告位验证，只保证数据库存在一条信息
        $buyer_start_banner_id = AdvPosition::where('code', 'BUYER_START_BANNER')->pluck('id');
        if ($buyer_start_banner_id > 0 && $buyer_start_banner_id == $positionId && Adv::where('position_id', $buyer_start_banner_id)->first()) {
            $result['code'] = 70313; //添加失败！启动页广告已存在，请勿重复添加。

            return $result;
        }

        $adv = new Adv();
        $adv->city_id       = $cityId;
        $adv->position_id   = $positionId;
        $adv->name          = $name;
//        $adv->image         = '';
//        $adv->bg_color      = '';
//        $adv->type          = '0';
//        $adv->arg           = '';
        $adv->sort 	        = $sort;
        $adv->status 	    = $status;
        $adv->create_time   = Time::getTime();
//        $adv->seller_cate_id = '';
//        $adv->image1='';
//        $adv->type1='0';
//        $adv->arg1='';
//        $adv->image2='';
//        $adv->type2='0';
//        $adv->arg2='';
//        $adv->image3='';
//        $adv->type3='0';
//        $adv->arg3='';
//        $adv->image4='';
//        $adv->type4='0';
//        $adv->arg4='';
        $adv->flage=$flage;
//        $adv->title2 = '';
//        $adv->instruction2 = '';
//        $adv->instruction2_bg = '';
//        $adv->title3 = '';
//        $adv->instruction3 = '';
//        $adv->instruction3_bg = '';
//        $adv->title4 = '';
//        $adv->instruction4 = '';
//        $adv->instruction4_bg = '';
        $adv->adv_serialize = serialize($advSerialize);
        $adv->save();
        return $result;
    }
    /**
     * 更新广告
     * @param int $id 广告id
     * @param int $cityId 显示城市
     * @param int $positionId 广告位编号
     * @param string $name 广告名称
     * @param string $clientType 客户端类型
     * @param string $image 图片
     * @param string $bgColor 背景颜色
     * @param string $type 动作类型
     * @param string $arg 动作参数
     * @param int $sort 排序
     * @param int $status 状态
     * @return array   创建结果
     */
    public static function update($id, $cityId, $positionId, $name, $image, $bgColor, $type, $arg, $sort, $status, $sellerCateId,$image1,$type1,$arg1,$image2,$type2,$arg2,$image3,$type3,$arg3,$image4,$type4,$arg4,$flage,$title2='',$instruction2='',$instruction2Bg='',$title3='',$instruction3='',$instruction3Bg='',$title4='',$instruction4='',$instruction4Bg='',$sign2='',$sign3='',$sign4='',$mark2='',$mark3='',$mark4='',$remarks2='',$remarks3='',$remarks4='')
    {
        if($flage==1) { //1+3广告
            $result = array(
                'code' => self::SUCCESS,
                'data' => null,
                'msg' => ''
            );

            $rules = array(
                'name' => ['required'],
                'image1' => ['required'],
                'image2' => ['required'],
                'image3' => ['required'],
                'image4' => ['required'],
            );

            $messages = array(
                'name.required' => 70103,    // 请填写名称
                'image1.required' => 70104, // 请上传图片
                'image2.required' => 70104,
                'image3.required' => 70104,
                'image4.required' => 70104,
            );

            $validator = Validator::make(
                [
                    'name' => $name,
                    'image1' => $image1,
                    'image2' => $image2,
                    'image3' => $image3,
                    'image4' => $image4,
                ], $rules, $messages);

            //验证信息
            if ($validator->fails()) {
                $messages = $validator->messages();

                $result['code'] = $messages->first();

                return $result;
            }
        }else{
            $result = array(
                'code' => self::SUCCESS,
                'data' => null,
                'msg' => ''
            );

            $rules = array(
                'name' => ['required'],
                'image' => ['required'],
                'type' => ['required'],
            );
            $messages = array(
                'name.required' => 70103,    // 请填写名称
                'image.required' => 70104,
                'type.required' => 70106,
            );

            $validator = Validator::make(
                [
                    'name' => $name,
                    'image' => $image,
                    'type'  =>$type
                ], $rules, $messages);

            //验证信息
            if ($validator->fails()) {
                $messages = $validator->messages();

                $result['code'] = $messages->first();

                return $result;
            }

            $image = self::movePublicImage($image);
            if (!$image) {
                $result['code'] = 70105;
                return $result;
            }
			if($type == 5){
					if(!preg_match("/^(http:\/\/|https:\/\/).*$/",$arg)){
					$arg = "http://"  .  $arg;
				}
			}
        }


        Adv::where("id", $id)->update(array(
               'city_id'        => $cityId,
               'position_id'    => $positionId,
               'name'           => $name,
               'image'          => $image,
               'bg_color'       => $bgColor,
               'type'           => $type,
               'arg'            => $arg,
               'sort' 	        => $sort,
               'status'         => $status,
               'seller_cate_id' => $sellerCateId,
               'image1'         => $image1,
               'type1'          => $type1,
               'arg1'           => $arg1,
                'image2'         => $image2,
                'type2'          => $type2,
                'arg2'           => $arg2,
                'image3'         => $image3,
                'type3'          => $type3,
                'arg3'           => $arg3,
                'image4'         => $image4,
                'type4'          => $type4,
                'arg4'           => $arg4,
                'flage'          => $flage,
                'title2'        => $title2,
                'instruction2'  => $instruction2,
                'instruction2_bg'=> $instruction2Bg,
                'title3'        => $title3,
                'instruction3'  => $instruction3,
                'instruction3_bg'=> $instruction3Bg,
                'title4'        => $title4,
                'instruction4'  => $instruction4,
                'instruction4_bg'=> $instruction4Bg,
                'adv_serialize' => '',
                'sign2' => $sign2,
                'sign3' => $sign3,
                'sign4' => $sign4,
                'mark2' => $mark2,
                'mark3' => $mark3,
                'mark4' => $mark4,
                'remarks2' => $remarks2,
                'remarks3' => $remarks3,
                'remarks4' => $remarks4,
           ));

        return $result;
    }
    public static function update1($id, $name, $cityId, $positionId, $flage, $sort, $status, $advSerialize)
    {
        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'name' => ['required'],
        );
        $messages = array(
            'name.required' => 70103,    // 请填写名称
        );

        $validator = Validator::make(
            [
                'name' => $name,
            ], $rules, $messages);

        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();

            $result['code'] = $messages->first();

            return $result;
        }

        /*$image = self::movePublicImage($image);
        if (!$image) {
            $result['code'] = 70105;
            return $result;
        }*/
        Adv::where("id", $id)->update(array(
            'city_id'        => $cityId,
            'position_id'    => $positionId,
            'name'           => $name,
            'image'          => '',
            'bg_color'       => '',
            'type'           => '0',
            'arg'            => '',
            'sort' 	        => $sort,
            'status'         => $status,
            'seller_cate_id' => '0',
            'image1'         => '',
            'type1'          => '0',
            'arg1'           => '',
            'image2'         => '',
            'type2'          => '0',
            'arg2'           => '',
            'image3'         => '',
            'type3'          => '0',
            'arg3'           => '',
            'image4'         => '',
            'type4'          => '0',
            'arg4'           => '',
            'flage'          => $flage,
            'title2'        => '',
            'instruction2'  => '',
            'instruction2_bg'=> '',
            'title3'        => '',
            'instruction3'  => '',
            'instruction3_bg'=> '',
            'title4'        => '',
            'instruction4'  => '',
            'instruction4_bg'=> '',
            'adv_serialize' => serialize($advSerialize)
        ));

        return $result;
    }

    /**
     * 获取广告
     * @param  int $id 广告id
     * @return array   广告
     */
	public static function getById($id) 
    {
		return Adv::where('id', $id)
            ->with('city', 'position')
		    ->first();
	}
    /**
     * 设置状态
     * @param int  $id 广告id
     * @param int  $status 状态
     * @return array   删除结果
     */
	public static function setstatus($id, $status) 
    {
		$result = 
        [
			'code'	=> 0,
			'data'	=> null,
			'msg'	=> ""
		];
        
		Adv::where('id', $id)->update(["status"=>$status]);
        
		return $result;
	}
    /**
     * 删除广告
     * @param int  $id 广告id
     * @return array   删除结果
     */
	public static function delete($id) 
    {
		$result = [
			'code'	=> 0,
			'data'	=> null,
			'msg'	=> ""
		];

        if(!is_array($id)){
            $id = [$id];
        }

		Adv::whereIn('id', $id)->delete();
		return $result;
	}
    /**
     * 广告列表
     * @param string $clientType 客户端类型
     * @param  string $code 页码
     * @param  int $page 页码
     * @param  int $pageSize 每页数
     * @return array          广告信息
     */
    public static function OneselfAdvlists($code, $page,$pageSize)
    {
        $list = Adv::orderBy('id', 'desc');

        if ($code !== '') {
            $list->whereIn("position_id", function($query)use($code)
            {
                $query->select("id")
                    ->from('adv_position')
                    ->where('client_type', $code);

            });
        }

        $totalCount = $list->count();

        $list = $list->with('city', 'position')
            ->skip(($page - 1) * $pageSize)
            ->take($pageSize)
            ->get()
            ->toArray();

        return ["list"=>$list, "totalCount"=>$totalCount];
    }
}
