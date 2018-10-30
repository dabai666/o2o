<?php 
namespace YiZan\Services\System;

use YiZan\Models\System\SystemConfig;

use Lang,Validator;
/**
 * 系统配置信息
 */
class SystemConfigService extends \YiZan\Services\SystemConfigService 
{
    public static function getLists($group) 
    {
        return SystemConfig::where('group_code', 'like', '%,'.$group.',%')
            ->where('is_show', '1')
            ->orderBy("sort")
            ->get()
            ->toArray();
    }

	/**
	 * 更新配置信息
     * @param array $configs 系统配置列表
     * @return array   修改结果
	 */
	public static function update($configs) 
    {
        $result = array(
			'code'	=> self::SUCCESS,
			'data'	=> null,
			'msg'	=> Lang::get('api_system.success.update_info')
        );
        
        if(is_array($configs))
        {
            foreach ($configs as $config)
            {
                SystemConfig::where('code', $config["code"])->update(
                    [
                        //'name'          => $config["name"],
                        'val'           => $config["val"]/*,
                        'show_type'     => $config["show_type"],
                        'default_vals'  => $config["default_vals"],
                        'default_names' => $config["default_names"],
                        'is_show'       => $config["is_show"],
                        'sort'          => $config["sort"],
                        'tooltip'       => $config["tooltip"]*/
                    ]);
            }
        }
        
        SystemConfig::resetConfig();
        
        return $result;
    }

    public static function getListsOne($code){
        $data = SystemConfig::where('code', $code)
            ->where('is_show', '1')
            ->orderBy("sort")
            ->get()
            ->toArray();
        return $data;
    }

    public static function updateOne($configs){
        $arr = array();
        $configs = json_decode($configs['data']);
        $arr['image'] = $configs->image;
        $arr['seckill_produce'] = $configs->seckill_produce;

        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'image' => ['required'],
        );

        $messages = array(
            'image.required' => 70104,//请上传图片
        );

        $validator = Validator::make(
            [
                'image' => $arr['image']

            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();

            return $result;
        }
        SystemConfig::where('code', 'seckill_banner')->update(['val'=> $arr['image']]);
        SystemConfig::where('code', 'seckill_produce')->update(['val'=> $arr['seckill_produce']]);

    }



}
