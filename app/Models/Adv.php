<?php namespace YiZan\Models;

class Adv extends Base
{
    protected $visible = ['id', 'name', 'image', 'bg_color', 'type', 'arg', 'url','image1','type1','arg1','image2','type2','arg2','image3','type3','arg3','image4','type4','arg4','title2','instruction2','instruction2_bg','title3','instruction3','instruction3_bg','title4','instruction4','instruction4_bg','adv_serialize','sign2','sign3','sign4','mark2','mark3','mark4','remarks2','remarks3','remarks4'];
    protected $appends = array('url');
    /**
     * 广告url
     */
    public function getUrlAttribute()
    {
        $type = $this->attributes['type'];
        $args 	= $this->attributes['arg'];
        $url = '';
        switch ($type) {
            case '1' : $url = u('wap#Seller/index', ['id' => $args]);  break;
            case '2' : $url = ''; break;
            case '3' : $url = u('wap#Goods/detail', ['goodsId' => $args]); break;
            case '4' : $url = u('wap#Seller/detail', ['id' => $args]); break;
            case '5' : $url = $args; break;
            case '6' : $url = u('wap#Goods/detail', ['goodsId' => $args]); break;
            case '7' : $url = u('wap#Article/detail', ['id' => $args]); break;
            case '8' : $url = u('wap#UserCenter/signin'); break;
            case '9' : $url = u('wap#Integral/index'); break;
        }
        return $url;
    }
}
