<?php
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Services\StorageServiceService;

class StorageServiceController extends BaseController{
    public function getList(){
        $data = StorageServiceService::getList(
            $this->request('page'),
            $this->request('pageSize')
        );
        return $this->outputData($data);
    }

    public function getListById(){
        $data = StorageServiceService::getListById(
            $this->request('id')
        );
        return $this->outputData($data);
    }
    public function delete(){
        $data = StorageServiceService::delete(
            $this->request('id')
        );
        return $this->outputData($data);
    }
    public function save(){
        $result = StorageServiceService::save(
            intval($this->request('id')),
            strval($this->request('name')),
            strval($this->request('url')),
            strval($this->request('img'))
        );
        return $this->output($result);
    }
}