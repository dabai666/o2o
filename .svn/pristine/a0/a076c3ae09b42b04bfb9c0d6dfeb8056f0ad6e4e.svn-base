<?php
namespace YiZan\Http\Controllers\Api\Buyer;
use YiZan\Services\Buyer\StaffStimeService;
use YiZan\Services\StorageServiceService;
use YiZan\Utils\Time;

class StorageServiceController extends BaseController {
    public function getList(){
        $result = StorageServiceService::getList(
            $this->request('page'),
            $this->request('pageSize')
        );
        return $this->outputData($result);
    }
    public function getListById(){
        $data = StorageServiceService::getListById($this->request('id'));
        return $this->outputData($data);
    }
}