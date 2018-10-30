@if($lists)
    @foreach($lists as $k => $v)
        <div>
            <a href="{{u('Goods/detail')}}?goodsId={{ $v['id'] }}&showurl=2">
                <div style="display: flex;">
                    <div style="clear: both;float: left;margin-left: 10px;margin-top: 10px;">
                        <div style="display: flex;">
                            <div>
                                <img src="{{ $v['images'][0] }}" style="width: 60px;height: 60px;">
                            </div>
                            <div style="margin-left: 5px;margin-top: 5px;">
                                <p style="columns:120px 2;font-size: 15px;max-height:45px;font-family:'微软雅黑';color:rgb(58,59,59);text-overflow:ellipsis; overflow:hidden;">{{ $v['name'] }}</p>
                                <p style="color:red;font-size: 13px;font-weight:bold;">￥@if($v['salePrice'] > 0){{ number_format($v['salePrice'],2) }}@else{{ number_format($v['price'],2) }}@endif</p>
                            </div>
                        </div>
                    </div>
                    <div style="float: right;margin-top: 30px;margin-right: 20px;"><i class="icon iconfont vat ml5">&#xe602;</i></div>
                </div>
                <hr style="clear:both;border:1px solid lightgrey;"/>
            </a>
        </div>
    @endforeach
    <div class="pa w100 tc allEnd none">
        <p class="f12 c-gray mt5 mb5">数据加载完毕</p>
    </div>
@else
    <div class="x-null pa w100 tc">
        <p class="f12 c-gray mt10">很抱歉！没有找到内容！</p>
    </div>
@endif