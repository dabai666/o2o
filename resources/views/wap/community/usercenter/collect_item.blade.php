@foreach($list as $vo)
    @if($args['type'] == 2)
        <li @if($vo['isDelivery'] == 0)style="background:#f3f3f3;" data-isurl="0" @else data-isurl="1" @endif data-id="{{$vo['id']}}">
            <a href="#" class="item-link item-content">
                <div class="item-media todetail" data-id="{{$vo['id']}}">
                    <img src="{{ formatImage($vo['logo'],73,73) }}" onerror='this.src="{{ asset("wap/community/newclient/images/no.jpg") }}"' width="73">
                </div>
                <div class="item-inner">
                    <div class="item-title-row todetail" data-id="{{$vo['id']}}">
                        <div class="item-title f14">{{$vo['name']}}</div>
                        <div class="item-after"><i class="icon iconfont c-gray2 f20 y-wdscr" data-id="{{$vo['id']}}" data-type="{{$args['type']}}">&#xe630;</i></div>
                    </div>
                    <div class="item-title-row f12 c-gray mt5 mb5">
                        <div class="item-title">
                            <div class="y-starcont">
                                <div class="c-gray4 y-star">
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                </div>
                                <div class="c-red f12 y-startwo" style="width:{{$vo['score'] * 20}}%;">
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                    <i class="icon iconfont vat mr2 f12">&#xe654;</i>
                                </div>
                            </div>
                            @if($vo['orderCount'] > 0)
                                <span class="c-gray f12">已售{{$vo['orderCount']}}</span>
                            @else
                                <span class="c-gray f12"></span>
                            @endif
                        </div>
                        <div class="item-after">
                            <i class="icon iconfont c-gray2 f18">&#xe60d;</i>
                            <span class="compute-distance" data-map-point-x="{{ $vo['mapPoint']['x'] }}" data-map-point-y="{{ $vo['mapPoint']['y'] }}"></span>
                        </div>
                    </div>
                    <div class="item-subtitle c-gray">
                        <span class="mr10">{!! $vo['freight'] !!}</span>
                    </div>
                </div>
            </a>
        </li>
    @else
        <li data-id="{{$vo['id']}}">
            <a href="#" class="item-link item-content">
                <div class="item-media todetail" data-id="{{$vo['id']}}">
                    <img src="{{$vo['logo']}}" onerror='this.src="{{ asset("wap/community/newclient/images/no.jpg") }}"' width="73">
                </div>
                <div class="item-inner">
                    <div class="item-title-row mt10 todetail" data-id="{{$vo['id']}}">
                        <div class="item-title f14">{{$vo['name']}}</div>
                        <div class="item-after"><i class="icon iconfont c-gray2 f20 y-wdscr" data-id="{{$vo['id']}}" data-type="{{$args['type']}}">&#xe630;</i></div>
                    </div>
                    <!-- <div class="item-subtitle mb10 mt10 y-f14">
                        <span class="c-red">￥{{$vo['price']}}</span>
                    </div> -->
					<div class="item-title-row mt10 todetail" data-id="{{$vo['id']}}">
                        <div class="item-title f14">
							<span class="c-red">￥</span>
							<span class="c-red goodsprice{{$vo['id']}}" data-sellerid="{{$vo['sellerId']}}" data-type="{{$vo['type']}}" data-name="{{$vo['name']}}">{{$vo['price']}}</span></div>
                        <div class="item-after">
							@if((count($vo['norms']) < 1) && (count($vo['goodsProcessingCharges']) < 1))
								<div class="x-num fr" style="border-color: red;">
									<span class="icon iconfont c-red addx fr" style="font-size:1.1rem;" data-id="{{$vo['id']}}">&#xe61e;</span>
									@if($cart[$vo['sellerId']]['goods'][$vo['id']])
										<span class="numberx fr" style="width:1.3rem;text-align:center;">{{$cart[$vo['sellerId']]['goods'][$vo['id']]['num']}}</span>
										<span class="icon iconfont c-red subtractx fr" style="font-size:1.1rem;" data-id="{{$vo['id']}}">&#xe621;</span>
									@else 
										<span class="numberx fr none" style="width:1.3rem;text-align:center;">0</span>
										<span class="icon iconfont c-red subtractx fr none" style="font-size:1.1rem;" data-id="{{$vo['id']}}">&#xe621;</span>
									@endif
								</div>
							@else
								<div class="fr c-red f12 y-xgg totalPrice choose-norms" style="border-color: red;" data-ids="{{$vo['id']}}" data-sellerid="{{$vo['sellerId']}}" data-type="{{$vo['type']}}" data-name="{{$vo['name']}}">选规格</div>
							@endif
						</div>
                    </div>
                </div>
            </a>
        </li>
    @endif
@endforeach


