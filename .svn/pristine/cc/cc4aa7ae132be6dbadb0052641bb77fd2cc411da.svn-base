@if($lists)
    @foreach($lists as $k => $v)
        <div>

            <span >
                <div style="clear: both;float: left;margin-left: 10px;margin-top: 10px;">
                    <div style="display: flex;">
                        <div>
                            <img src="{{ $v['image'] }}" style="width: 60px;height: 60px;">
                        </div>
                        <div style="margin-left: 20px;margin-top: 5px;">
                            <p>{{ $v['name'] }}</p>
                            <p>￥{{ $v['salePrice'] }}</p>
                        </div>
                    </div>
                </div>
                <div style="float: right;margin-top: 30px;margin-right: 20px;">
                    <div>
                        <i class="icon iconfont c-gray subtract1 @if(!$v['cart']) none @endif" id="subtract_{{ $v['id'] }}" data-id="{{ $v['id'] }}" data-price="{{ $v['price'] }}" data-salePrice="">&#xe621;</i>
                        <span class="val tc pl0 @if(!$v['cart']) none @endif" id="normsval_span_{{ $v['id'] }}">@if($v['cart']) {{ $v['cart'][0]['num'] }} @else 0 @endif</span>
                        <input type="hidden" value="@if($v['cart']) {{$v['cart'][0]['num']}} @else 0 @endif" class="val tc pl0 " id="normsval_{{ $v['id'] }}"  readonly="readonly" />
                        <i class="icon iconfont c-red add1" data-id="{{ $v['id'] }}"  data-price="{{ $v['price'] }}" data-salePrice="">&#xe61e;</i>
                    </div>
                </div>
                <hr style="clear:both;border:1px solid lightgrey;"/>
            </span>
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