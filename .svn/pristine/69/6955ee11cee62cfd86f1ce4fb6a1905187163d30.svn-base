<?php
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Services\LogisticsCompanyService;
use YiZan\Services\ShopBrandService;

class LogisticsCompanyController extends BaseController{
    public function getList(){
        $data = LogisticsCompanyService::getList(
            (int)$this->request('page'),
            (int)$this->request('pageSize')
        );
        return $this->outputData($data);
    }

    public function getListById(){
        $data = LogisticsCompanyService::getListById(
            $this->request('id')
        );
        return $this->outputData($data);
    }
    public function delete(){
        $data = LogisticsCompanyService::delete(
            $this->request('id')
        );
        return $this->outputData($data);
    }
    public function save(){
        $result = LogisticsCompanyService::save(
            intval($this->request('id')),
            strval($this->request('name')),
            strval($this->request('logo')),
            strval($this->request('aging')),
            strval($this->request('tel')),
            strval($this->request('qq')),
            strval($this->request('introduction')),
            strval($this->request('contacts'))
        );
        return $this->output($result);
    }
}