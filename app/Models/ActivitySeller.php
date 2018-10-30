<?php 
namespace YiZan\Models;

class ActivitySeller extends Base{
    public function activity(){
        return $this->belongsTo('YiZan\Models\Activity', 'activity_id', 'id');
    }
}
