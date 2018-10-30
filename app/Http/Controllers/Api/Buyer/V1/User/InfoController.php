<?php 
namespace YiZan\Http\Controllers\Api\Buyer\User;

use YiZan\Http\Controllers\Api\Buyer\UserAuthController;
use YiZan\Services\Buyer\UserService;
use YiZan\Services\UserDetailService;
use YiZan\Services\UserTagService;

class InfoController extends UserAuthController {
	/**
	 * 更新会员信息
	 */
	public function update() {
		$result = UserService::updateInfo($this->user, [
				'name'   => $this->request('name'), 
				'avatar' => $this->request('avatar')
			]);
		return $this->output($result);
	}

    /**
     * 检验
     */
    public function verifymobile() {

        $result = UserService::verifymobile(
            $this->request('mobile'),
            $this->request('verifyCode')
        );
        return $this->output($result);
    }

    //获取会员注册详细信息
    public function getdetail(){

        $result = UserDetailService::detail($this->userId);
        return $this->output($result);
    }

    //保存会员注册详细信息
    public function savedetail(){
    	$result = UserDetailService::save(
            $this->userId,
            $this->request('shopname'),
            $this->request('personcharge'),
            $this->request('shoptype'),
            $this->request('addressid'),
            $this->request('phone')
        );
        return $this->output($result);
    }

    //获取门店类型
    public function getshoptype(){

        $result = UserTagService::getList();
        return $this->output($result);
    }


}