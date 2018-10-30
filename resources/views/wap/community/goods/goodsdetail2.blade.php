@extends('wap.community._layouts.base')
@section('css')
    <style type="text/css">
        .button123 {
            border: solid 2px #ddd;
            /*border: solid 1px #0bbe06;*/
            background: transparent;
            border-radius: 9px;
            font-size: 14px;
            padding: 2px 15px;
            margin: 0;
            display: inline-block;
            line-height: 20px;
            transition: all 1s cubic-bezier(0.175, 0.885, 0.32, 1) 0s
        }
        .button1234{
            border: solid 2px #ddd;
            /*border: solid 1px #0bbe06;*/
            background: transparent;
            border-radius: 5px;
            font-size: 14px;
            padding: 3px 15px;
            margin: 0;
            display: inline-block;
            line-height: 20px;
            transition: all 1s cubic-bezier(0.175, 0.885, 0.32, 1) 0s
        }
        .checked{
            background: #cccccc;
            border: solid 1px #797979;
        }
    </style>
@stop
@section('show_top')
    <?php
    //存在规格和折扣 获取规格最低价 根据折扣结算出新的特价
    if(count($data['norms']) > 0 && !empty($seller['activity']['special']))
    {
        $f = true;
        foreach ($data['norms'] as $key => $value) {
            $salePrice = $value['price'] * $seller['activity']['special']['sale'] / 10;

            $data['norms'][$key]['salePrice'] = $salePrice;

            if($f)
            {
                $seller['activity']['special']['minNormsPrice'] = $salePrice;
                $data['price'] = $value['price'];
                $f = false;
            }
            elseif(!$f && $salePrice <= $seller['activity']['special']['minNormsPrice'])
            {
                $seller['activity']['special']['minNormsPrice'] = $salePrice; //最低折扣价
                $data['price'] = $value['price']; //最低原价
            }

        }
    }

    if(Input::get('backindex') == 1)
    {
        $nav_back_url = u('Index/index');

    }

    $goodsId = input::get('goodsId');
    ?>
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left" href="javascript:$.href('@if(!empty($nav_back_url)) {{$nav_back_url}} @else {{ u('Goods/index',['id'=>$data['sellerId'],'type'=>1,'urltype'=>1]) }} @endif')" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <h1 class="title f16">商品详细</h1>
        <a class="button button-link button-nav pull-right open-popup collect_it collect_opration @if($data['iscollect']) on @endif" data-id="{{$data['id']}}" data-popup=".popup-about" href="#">
            <!-- 分享 -->
            <i class="icon share iconfont c-black">&#xe616;</i>
            @if($data['iscollect'] == 1)
                <i class="icon collect iconfont c-red m0">&#xe654;</i><!-- 已收藏图片  -->
            @else
                <i class="icon collect iconfont c-black m0">&#xe653;</i><!-- 未收藏图标 -->
            @endif
        </a>
    </header>
    <div style="position: fixed;left:10%;right:10%;top:20%;bottom: 20%;z-index: 999999;" id="alert" class="none">
        <div style="width: 100%;height: 100%;background: #fff;border-radius: 10px;height: auto;">
            <div style="margin-right: 10px;margin-left: 10px;">
                <div class="list-block media-list">
                    <ul>
                        <li>
                            <div class="item-inner pr10">
                                <div class="item-title f14">
                                    <div style="display:flex;width: 100%;margin-left: 10px;">
                                        <div style="margin-top: 3px;width:30%;">{{ $data['name'] }}</div>
                                        <div style="width:60%;"></div>
                                        <div style="width:10%;margin-right: 15px;" id="cancel"><img src="{{ asset('wap/community/newclient/images/cancel.png') }}" style="width: 30px;height: 30px;"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        @if($data['norms'])
                            <li>
                                <div class="item-inner pr10">
                                    <div class="item-title-row y-qgdtxfl" >
                                        <div class="item-title f14">
                                            <div class="item-title f14">
                                                <span class="f15">选择规格:</span>
                                                <div style="margin-top: 10px;">
                                                    @foreach($data['norms'] as $k => $v)
                                                        @if($k > 0) @if((($k+1)/3) == 0) <br> @endif @endif
                                                        <label class="button1234 norms" id="normsid_{{ $v['id'] }}" data-price="{{ $v['salePrice'] or $v['price']}}" data-original-price="{{ $v['price'] }}" data-sale-price="{{ $v['salePrice'] }}"><input type="radio" value="{{ $v['id'] }}" class="none" name="norms">{{ $v['name'] }}</label>
                                                    @endforeach
                                                    <div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                            </li>
                        @endif
                        <li>
                            <div class="item-inner pr10">
                                <div class="item-title-row y-qgdtxfl" >
                                    <div class="item-title f14">
                                        <div class="item-title f14">
                                            <span class="f15">进行加工:</span>
                                            @if($data['goodsProcessingCharges'])
                                                <div style="margin-top: 10px;">
                                                    <label class="button1234 process" id="processid_-1" data-price="0"><input type="radio" value="-1" class="none" name="process" checked="checked">无</label>
                                                    @foreach($data['goodsProcessingCharges'] as $k => $v)
                                                        @if($k > 0) @if((($k+1)/3) == 0) <br> @endif @endif
                                                        <label class="button1234 process" id="processid_{{ $v['id'] }}" data-price="{{ $v['price'] or 0}}"><input type="radio" value="{{ $v['id'] }}" class="none" name="process">{{ $v['name'] }}</label>
                                                    @endforeach
                                                </div>
                                            @else
                                                <div style="margin-top: 10px;">
                                                    <label class="button1234 process" id="processid_-1" data-price="0"><input type="radio" value="-1" class="none" name="process" checked="checked">无</label>
                                                </div>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <div class="hidden">
                        @if($data['norms'])
                            <input id="normshidden" class="none" value="{{ $data['norms'][0]['id'] }}">
                        @endif
                        <input id="processhidden" class="none" value="-1">
                    </div>
                    <div style="display:flex;width:100%;bottom: 0px;margin-top:20px;">
                        <div style="width: 30%;margin-left: 10px;" class="c-red">￥<span class="price_total"></span></div>
                        <div style="width:70%;margin-right: 10px;">
                            <div class="x-pnum pl10 pr10">
                                <div class="fr x-num">
                                    <i class="icon iconfont c-gray subtract1 @if($cart['goods'][$option['goodsId']]['num'] == 0) none @endif" data-id="{{$data['norms'][0]['id']}}" data-price="{{ number_format($data['norms'][0]['price'],2) }}">&#xe621;</i>
                                    <span class="val tc pl0 none" id="normsval_span1">0</span>
                                    <input value="0" class="val tc pl0 none" id="normsval1"  readonly="readonly" />
                                    <i class="icon iconfont c-red add1" data-id="{{$data['norms'][0]['id']}}"  data-price="{{ round($data['norms'][0]['price'], 2) }}" data-salePrice="{{ round($data['norms'][0]['salePrice'], 2) }}">&#xe61e;</i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <nav class="bar bar-tab y-xqynav">
        <a class="tab-item c-white  y-xqybtn " href="{{ u('GoodsCart/index') }}" style="background: #4f5150;" >
            <div class="x-cart pr mr10 y-cart">
                <div>
                    <i class="icon iconfont c-white">&#xe673;</i>
                    <span class="badge pa c-bgfff c-red" id="cartTotalAmount">{{ $cart['totalAmount'] }}</span>
                </div>
            </div>
            <span class="c-white f18 y-maxw40" style="margin-left: 10px;">￥<span id="cartTotalPrice">{{number_format($cart['totalPrice'], 2) }}</span></span>
        </a>
        <a onclick="$.shoppingcartOne();" class="tab-item c-white c-bgff9000 y-xqybtn  @if($option['shareUserId'])none @endif" href="#" external>
            <span class="tab-label" >加入购物车</span>
        </a>
        <a onclick="$.shoppingcartOne(1);" class="tab-item c-white c-bg y-xqybtn" external>
            <span class="tab-label">选好了</span>
        </a>
    </nav>
@stop

@section('content')
    <script type="text/javascript">
        BACK_URL = "{!! Request::server('HTTP_REFERER') !!}";
    </script>
    <div class="content" id=''>
        <div style="height: 60px;"></div>
        <div class="swiper-container commAdvSwiper" data-space-between='0'>
            <div class="swiper-wrapper">
                @foreach($data['images'] as $key => $value)
                    <div class="swiper-slide pageloading">
                        <img _src="{{ formatImage($value,640) }}" src="{{ formatImage($value,640) }}" />
                    </div>
                @endforeach
            </div>
            <div class="swiper-pagination swiper-pagination-comm"></div>
        </div>
        <div class="list-block media-list">
            <ul>
                <li>
                    <a href="#" class="item-link item-content" external>
                        <div class="item-inner pr10">
                            <div class="item-text c-black lh20 mb5 "><span style="font-size: 26px;">{{ $data['name'] }}</span></div>
                            <div class="item-title-row y-qgdtxfl" style="margin-top: -10px;">
                                @if(empty($seller['activity']['special']))
                                    <div class="item-title f14">
                                        <div class="item-title f14">
                                            <span class="f16" style="color:#686868;">促销价格:</span><span class="f18 c-red">￥<span id="salePirce">@if($data['norms']) {{ $data['norms'][0]['salePrice'] or $data['norms'][0]['price']}}@else{{ $data['salePrice'] or $data['price'] }}@endif </span></span>
                                            <span class="f17" style="text-decoration:line-through;">￥<span id="orightPirce">@if($data['norms']) {{ $data['norms'][0]['price'] or 0}}@else {{ $data['originalprice'] or 0}} @endif</span></span>
                                        </div>
                                    </div>
                                @else
                                    @if(empty($seller['activity']['special']['minNormsPrice']))
                                        <div class="item-title f14 c-red">
                                            @if(empty($data['norms']))
                                                ￥<span class="f24">{{ number_format($data['price'] * $seller['activity']['special']['sale'] / 10,2) }}</span>
                                            @else
                                                ￥<span class="f24">{{ number_format($data['norms'][0]['price'] * $seller['activity']['special']['sale'] / 10,2) }}</span>
                                            @endif
                                            @if($seller['activity']['special']['sale'] > 0)
                                                <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                                            @endif
                                            <div><del class="c-gray f12">￥{{ $data['price'] }}</del></div>
                                        </div>
                                    @else
                                        <div class="item-title f14 c-red">
                                            ￥<span class="f24">{{ number_format($seller['activity']['special']['minNormsPrice'], 2) }}</span>
                                            @if($seller['activity']['special']['sale'] > 0)
                                                <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                                            @endif
                                            <div><del class="c-gray f12">￥{{ $data['price'] }}</del></div>
                                        </div>
                                    @endif
                                @endif
                                <div style="margin-right: 10px;">
                                    @if($data['norms'])
                                        <input type="button" value="选规格" class="button123">
                                    @endif
                                </div>
                                <!--<div class="item-after y-twoh44 share mr5">
                                    <i class="icon iconfont va-2 mr5 f20"></i>
                                    <p>分享</p>
                                </div>-->
                                <!--<div class="item-after share">
                            <p class="c-black f13">
                                <i class="icon iconfont c-red va-2 mr5">&#xe616;</i>
                                推销返利
                            </p>
                            <p class="c-red f12">推销回报:￥
                                元
                            </p>
                        </div>-->
                            </div>

                        </div>
                    </a>
                </li>
                <li>
                    <div style="margin-left: 10px;margin-top: 10px;">
                        <div style="color: #999999;">商品参数</div>
                        <div style="display: flex;width: 100%;margin-top: 5px;font-size: 13px;">
                            <div style="color: #3b3b3b;">品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</div>
                            <div style="margin-left: 5px;color: #797979;">{{ $data['shopBrand']['name'] }}</div>
                        </div>
                        <div style="display: flex;width: 100%;margin-top: 5px;font-size: 13px;">
                            <div style="color: #3b3b3b;">商品重量：</div>
                            <div style="margin-left: 5px;color: #797979;">{{ number_format($data['weight'],2) }}公斤</div>
                        </div>
                        <div>
                            &nbsp;
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        @if(!empty($seller['activity']['full']) || !empty($seller['activity']['special']) || !empty($seller['activity']['new']))
            <div class="list-block media-list y-nocenter">
                <ul>
                    <li class="item-content">
                        <div class="item-media f14 c-gray">促销</div>
                        <div class="item-inner">
                            <?php $first = true; ?>
                            @if(!empty($seller['activity']['full']))
                                <div class="item-title f14">
                                    <img src="{{ asset('wap/community/newclient/images/ico/jian.png') }}" width="16" class="icon iconfont c-gray va-3 mr5">
                                <span>
                                    在线支付
                                    @foreach($seller['activity']['full'] as $key => $value)
                                        @if($first)
                                            <?php $first = false; ?>
                                            满{{$value['fullMoney']}}减{{$value['cutMoney']}}元
                                        @else
                                            ,满{{$value['fullMoney']}}减{{$value['cutMoney']}}元
                                        @endif
                                    @endforeach
                                </span>
                                </div>
                            @endif
                            @if(count($seller['activity']['special']) > 0)
                                <div class="item-title f14">
                                    <img src="{{ asset('wap/community/newclient/images/ico/tei.png') }}" width="16" class="icon iconfont c-gray va-3 mr5">
                                    <span>商家特价优惠</span>
                                </div>
                            @endif
                            @if(!empty($seller['activity']['new']))
                                <div class="item-title f14">
                                    <img src="{{ asset('wap/community/newclient/images/ico/xin.png') }}" width="16" class="icon iconfont c-gray va-3 mr5">
                                    <span>新用户在线支付立减{{$seller['activity']['new']['cutMoney']}}元</span>
                                </div>
                            @endif
                        </div>
                        <i class="icon iconfont c-gray f13 mt5 mr10 y-unfold none y-i1">&#xe602;</i>
                        <i class="icon iconfont c-gray f13 mt5 mr10 y-unfold none">&#xe601;</i>
                    </li>
                </ul>
            </div>
        @endif
        <input type="text" value="@if($cart['goods'][$option['goodsId']]['num']){{max(intval($cart['goods'][$option['goodsId']]['num']),1)}}@else 0 @endif" readonly="readonly" id="goodsval" class="val tc pl0 none" />
        <input type="hidden" class="goods_stock" value="{{$data['stock']}}" />

        <div class="list-block f14 nobor">
            <ul>
                <li>
                    <a href="{{ u('Seller/detail',['id'=>$data['sellerId']]) }}" class="item-link item-content">
                        <div class="item-inner pr10">
                            <div class="item-title">
                                <i class="icon iconfont c-gray vat mr5">&#xe632;</i><span>{{ $data['seller']['name'] }}</span>
                            </div>
                            <i class="icon iconfont c-gray f13 mr-2">&#xe602;</i>
                        </div>
                    </a>
                </li>
            </ul>
            <!-- 回到顶部 -->
            <a href="javascript:$('.content').scrollTop(0)" class="y-backtop none"></a>
        </div>
        <div style="margin-bottom: 10px;">商品详情</div>
        <div class="c-bgfff pb10 y-img">
            <p class="p10">{!!$data['brief']!!}</p>
        </div>
    </div>

    <!-- 规格弹框1 -->
    <div class="f-bgtk size-frame1 show_item_norms_item none">
        <div class="x-closebg">
            <div class="x-probox c-bgfff">
                <div class="x-prott pr">
                    <div class="x-propic">
                        <img src="{{$data['images'][0]}}" />
                    </div>
                    <div class="x-prottr pt10">
                        @if(!empty($data['norms']))
                            @if(empty($seller['activity']['special']))
                                <p class="c-red pt5 f14">￥<span class="f20 money_toal" id="money_toal_">{{ number_format($data['norms'][0]['price'], 2) }}</span></p>
                            @else
                                <p class="c-red pt5 f14">
                                    ￥<span class="f20 money_toal" id="money_toal_">{{ $data['norms'][0]['price'] * $seller['activity']['special']['sale'] / 10 }}</span>
                                </p>
                                <p><del class="c-gray f13 delPrice">￥{{ $data['norms'][0]['price'] }}</del>
                                    @if($seller['activity']['special']['sale'] > 0)
                                        <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                            @endif
                        @endif
                        <p class="f12 c-black">库存<span class="goods_stock">{{$data['norms'][0]['stock']}}</span>件</p>
                        @else
                            @if(empty($seller['activity']['special']))
                                <p class="c-red pt5 f14">￥<span class="f20 money_toal" id="money_toal_">{{ number_format($data['price'], 2) }}</span></p>
                            @else
                                <p class="c-red pt5 f14">
                                    ￥<span class="f20 money_toal" id="money_toal_">{{ $seller['activity']['special']['salePrice'] }}</span>
                                </p>
                                <p><del class="c-gray f13 delPrice">￥{{ $data['price'] }}</del>
                                    @if($seller['activity']['special']['sale'] > 0)
                                        <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                            @endif
                        @endif
                        <p class="f12 c-black">库存<span class="goods_stock">{{$data['stock']}}</span>件</p>
                        @endif
                        <i class="icon iconfont x-closeico c-gray">&#xe604;</i>
                    </div>
                </div>
                <div class="y-max-height">
                    @if(!empty($data['norms']))
                        <div class="x-prott pr">
                            <p class="f14">请选择商品属性</p>
                            <div class="x-psize clearfix c-gray f12 y-ggpsize2">
                                @foreach($data['norms'] as $key => $item)
                                    <span class="@if($key == 0) c-bg @endif show_item_id_{{$item['id']}}_norms" data-info="{{$item['inCart']}}" data-id="{{$item['id']}}" data-prs="{{$item['price']}}" data-stock="{{$item['stock']}}" data-salePrice="{{ round($item['salePrice'], 2) }}" onclick="$.showItemNorms_item({{$item['id']}},{{ round($item['salePrice'], 2) }})">{{$item['name']}}</span>
                                @endforeach
                            </div>
                        </div>
                        <div class="x-pnum pl10 pr10">
                            <span class="f14">购买数量</span>
                            <div class="fr x-num">
                                <i class="icon iconfont c-gray subtract_norms  none" data-id="{{$data['norms'][0]['id']}}" data-price="{{ number_format($data['norms'][0]['price'],2) }}">&#xe621;</i>
                                <span class="val tc pl0 none" id="normsval_span">1</span>
                                <input type="hidden" value="0" class="val tc pl0 " id="normsval"  readonly="readonly" />
                                <i class="icon iconfont c-red add_norms " data-id="{{$data['norms'][0]['id']}}"  data-price="{{ round($data['norms'][0]['price'], 2) }}" data-salePrice="{{ round($data['norms'][0]['salePrice'], 2) }}">&#xe61e;</i>
                            </div>
                        </div>
                    @else
                        <div class="x-pnum pl10 pr10">
                            <span class="f14">购买数量</span>
                            <div class="fr x-num">
                                <i class="icon iconfont c-gray subtract @if($cart['goods'][$option['goodsId']]['num'] == 0) none @endif" data-id="{{$data['norms'][0]['id']}}" data-price="{{ number_format($data['norms'][0]['price'],2) }}">&#xe621;</i>
                                <span class="val tc pl0 none" id="normsval_span">{{$cart['goods'][$option['goodsId']]['num']}}</span>
                                <input type="hidden" value="{{$cart['goods'][$option['goodsId']]['num']}}" class="val tc pl0 " id="normsval"  readonly="readonly" />
                                <i class="icon iconfont c-red add" data-id="{{$data['norms'][0]['id']}}"  data-price="{{ round($data['norms'][0]['price'], 2) }}" data-salePrice="{{ round($data['norms'][0]['salePrice'], 2) }}">&#xe61e;</i>
                            </div>
                        </div>
                    @endif
                </div>
                <div class="x-pbtn c-white" id="cz_btn">
                </div>
            </div>
        </div>
    </div>
    @include('wap.community.goods.share')
@stop

@section($js)
    <script type="text/javascript">
        BACK_URL = "{!! Request::server('HTTP_REFERER') !!}";
    </script>
    <script type="text/javascript">
        $(function() {
            //规格弹出
            $(".button123").bind('click',function(){
                var normsid = $("#normshidden").val();
                var processid = $("#processhidden").val();
                $("button123").removeClass('checked');
//                alert("#normsid_"+normsid);
//                alert("#processid_"+processid);
                $("#normsid_"+normsid).addClass('checked');
                $("#processid_"+processid).addClass('checked');
                $("#alert").removeClass('none');
            });
            //增加
            $(".add1").bind('click',function(){
                var val = $("#normsval1").val();
                if(val  == ""){
                    val = 0;
                    $(".subtract1").removeClass("none");
                }
                val = parseInt(val) + 1;
                if (val > parseInt($('.goods_stock').val())) {
                    $.alert('商品库存不足');
                    return;
                }
                $("#goodsval1").val(val);
                $.funcMoney3(0,val,0);
                funcMoney4();
            });
            //减少
            $(".subtract1").bind('click',function(){
                var val = $("#normsval1").val();
                val = parseInt(val) - 1;
                if(val < 1){
                    val = 1;
                    $.alert('数量必须大于1！');
                    return false;
                }
                $("#goodsval1").val(val);
                $.funcMoney3(0,val,0);
                funcMoney4();
            });
            //取消弹框
            $("#cancel").bind('click',function(){
                /* var normsid = $(".norms:checked").val();
                 var processid = $(".process:checked").val();
                 $("#normshidden").val(normsid);
                 $("#processhidden").val(processid);*/
                $("#alert").addClass('none');
            });
            //规格选择
            $('input[name="norms"]').bind('click',function(){
                var id = $(this).val();
                $(".norms").removeClass('checked');
                $("#normshidden").val(id);
                $("#normsid_"+id).addClass('checked');
                var number = parseFloat($("#normsval1").val());
                if(number > 0){
                    funcMoney4();
                }
            });
            //加工选择
            $('input[name="process"]').bind('click',function(){
                var id = $(this).val();
                $(".process").removeClass('checked');
                $("#processhidden").val(id);
                $("#processid_"+id).addClass('checked');
                var number = parseFloat($("#normsval1").val());
                if(number > 0){
                    funcMoney4();
                }
            });
            //购物车和立即购买
            $.funcMoneyOne = function(id,value,price,status,processId){
                $.post("{{u('Goods/saveCartOne')}}", { goodsId: {{$data['id']}}, normsId: id, num: value, processId:processId, serviceTime:0, shareUserId:"{{$option['shareUserId']}}"},function(res){
                    if(res.code < 0){
                        $(".show_item_norms_item,.modal-overlay").remove();
                        $.router.load("{{u('User/login',['shareUserId' => $option['shareUserId']])}}", true);
                        return;
                    }
                    if(res.code > 0){
                        $.toast('添加失败！'+res.msg);
                        return false;
                    }
                    if(res.code == 0){
                        if(value > 0){
                            $(".show_item_norms_item .subtract_norms ").removeClass('none');
                            $(".show_item_norms_item .val ").removeClass('none');
                            $(".show_item_norms_item #normsval_span ").text(value);
                            $(".show_item_norms_item #normsval").val(value);
                            $(".show_item_id_"+id+"_norms").attr("data-info",value);
                        }else{
                            $(".show_item_norms_item .subtract_norms ").addClass('none');
                            $(".show_item_norms_item .val ").addClass('none');
                            $(".show_item_norms_item #normsval_span ").text(0);
                            $(".show_item_norms_item #normsval").val(0);
                            $(".show_item_id_"+id+"_norms").attr("data-info",0);
                        }

                        var totalPrice = 0;
                        var totalAmount = 0;
                        var cartIds = '';
                        for(var i = 0; i < res.data.list.length; i++){
                            if(res.data.list[i].id == "{{$data['seller']['id']}}"){
                                var cartGoods = res.data.list[i].goods;
                                for(var j = 0; j < cartGoods.length; j++){
                                    totalAmount += parseInt(cartGoods[j].num);
                                    if(cartGoods[j].sale <= 0){
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat(cartGoods[j].price);
                                    }else{
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat((cartGoods[j].price * cartGoods[j].sale) / 10);
                                    }
                                    cartIds += cartGoods[j].id+",";
                                }
                                break;
                            }
                        }
                        cartIds = cartIds.substring(0,cartIds.length-1);

                        $(".show_item_norms_item").addClass('none');
                        if(status == 1){
                            $.href('{{u('Order/order')}}?cartIds='+cartIds);
                        }else{
                            $.toast('添加成功，在购物车等亲~');

                            if(goodsNorms == 1){ //有规格
                                $("#normsval1").val(value);
                            }else{ //没有规格
                                $("#goodsval").val(value);
                            }
                        }

                        $("#cartTotalAmount").html(totalAmount);
                        $("#cartTotalPrice").html(totalPrice.toFixed(2));
                    }else{
                        $(".show_item_norms_item .msg_show").removeClass("none");
                    }
                },'json' );
            };
            //设置数量及显示
            $.funcMoney3 = function(id,value,price){
                $(".subtract1").removeClass('none');
                $("#normsval_span1").removeClass('none');
//                $(".show_item_norms_item .val ").removeClass('none');
                $("#normsval_span1").text(value);
                $("#normsval1").val(value);
//                $(".show_item_id_"+id+"_norms").attr("data-info",value);
            }
            //更新各显示数据
            function funcMoney4(){
                var normsid = $("#normshidden").val();
                var norms_price = parseFloat($("#normsid_"+normsid).attr('data-price'));
                var norms_original_price = $("#normsid_"+normsid).attr('data-original-price');
                var norms_sale_price = $("#normsid_"+normsid).attr('data-sale-price');
                var processid = $("#processhidden").val();
                var process_price = parseFloat($("#processid_"+processid).attr('data-price'));
                var number = parseFloat($("#normsval1").val());
                var money = norms_price*number + process_price*number;
                $(".price_total").html(money);
//                alert(norms_original_price);
//                alert(norms_sale_price);
                $("#orightPirce").html(norms_original_price);
                $("#salePrice").html(norms_sale_price);//salePirce orightPirce
            }

            $.shoppingcartOne = function(status){
                if(status == ""){
                    status = 0;
                }
                if(goodsNorms == 1){ //有规格
                    var val = $("#normsval1").val();
                    if(val == 0){
                        $.toast('请选择数量!');
                        return false;
                    }
                }else{ //没有规格
                    var val = $("#goodsval").val();
                    if(val == 0){
                        $.toast('请选择数量!');
                        return false;
                    }
                }

                var normsid = $("#normshidden").val();
                var price = parseFloat($("#normsid_"+normsid).attr('data-price'));
                var processid = $("#processhidden").val();
                $.funcMoneyOne(normsid,val,price,status,processid);
            }





            //回到顶部
            $(".content").scroll(function(){
                var windowheight =  $(window).height();
                var topheight = $(".content").scrollTop();
                if (topheight > windowheight) {
                    $(".y-backtop").removeClass("none");
                }else{
                    $(".y-backtop").addClass("none");
                }
            })

            $(".commAdvSwiper").swiper({"pagination": ".swiper-pagination-comm"});
            $(".content").css("top", 0);

            var cartIds = "{{$cartIds}}";
            var goodsNorms = "<?php echo !empty($data['norms']) ? 1 : 0; ?>";
            $.showItemNorms_item = function(id){
                $(".show_item_norms_item .msg_show").addClass("none");
                $(".show_item_norms_item .y-ggpsize2 span").removeClass('active');
                $(".show_item_id_"+id +"_norms").addClass('active');
                $(".add_norms").attr("data-id",id);
                $(".subtract_norms").attr("data-id",id);
                var val  = $(".show_item_id_"+id +"_norms").attr('data-info');
                var prs  = $(".show_item_id_"+id +"_norms").attr('data-prs');
                var stock  = $(".show_item_id_"+id +"_norms").attr('data-stock');
                var salePrice  = $(".show_item_id_"+id +"_norms").attr('data-salePrice');

                $(".show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .add_norms").attr('data-salePrice',salePrice);
                $(".add_norms").attr("data-price",prs);
                $(".subtract_norms").attr("data-salePrice",salePrice);

                if(salePrice > 0){
                    $(".show_item_norms_item .money_toal").html(salePrice);
                    $(".show_item_norms_item .delPrice").html('￥'+prs);
                    $(".show_item_norms_item .goods_stock").html(stock);
                }else{
                    $(".show_item_norms_item .money_toal").html(prs);
                    $(".show_item_norms_item .goods_stock").html(stock);
                }
            }

            //滑动显示头部
            var start = 0,move = 0,opacity = 1,opacity2 = 0;
            $(document).off('touchstart',".content");
            $(document).on('touchstart',".content", function (e) {
                var point = e.touches ? e.touches[0] : e;
                start = point.screenY;
            });
            var scrobox = '';
            $(document).off('touchmove',".content");
            $(document).on('touchmove',".content", function (e) {
                var point = e.touches ? e.touches[0] : e;
                move = point.screenY;
                var s = move - start;
                $(".content").scroll(function(){
                    scrobox = $(this).scrollTop();
                });
                if(s < 0 && scrobox >20){
                    if (opacity <= 0.1) {
                        opacity2 += 0.3;
                        if (opacity2 > 1) { opacity2 = 1; }
                        $(".y-qgdxqymnav").removeClass("y-qgdcommdetailnav").css("opacity",opacity2);
                    }else{
                        opacity -= 0.3;
                        if (opacity < 0) { opacity = 0; }
                        $(".y-qgdxqymnav").addClass("y-qgdcommdetailnav").css("opacity",opacity);
                    }
                }else{
                    if (opacity2 <= 0.1) {
                        opacity += 0.3;
                        if (opacity > 1) { opacity = 1; }
                        $(".y-qgdxqymnav").addClass("y-qgdcommdetailnav").css("opacity",opacity);
                    }else{
                        opacity2 -= 0.3;
                        if (opacity2 < 0) { opacity2 = 0; }
                        $(".y-qgdxqymnav").removeClass("y-qgdcommdetailnav").css("opacity",opacity2);
                    }
                }
            });

            //弹出规格1
            $(".y-choicegg").click(function(){
                $(".size-frame1").removeClass('none');
                $(".show_item_norms_item .y-ggpsize2 span").eq(0).addClass('active');
                var val  = $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-info');
                var prs  = $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-prs');
                var salePrice  =  $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-salePrice');
                if(salePrice <= 0){
                    prs = prs;
                }else{
                    prs = salePrice;
                }

                if(goodsNorms == 1){
                    $(".show_item_norms_item .money_toal").html(prs);
                }else{
                    $(".show_item_norms_item .val").removeClass('none');
                }
                $(".show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .subtract").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .subtract").attr('data-salePrice',salePrice);

                var string = '<button class="join f16 c-bgff9000 @if($option['shareUserId'])none @endif" onclick="$.shoppingcartOne()">加入购物车</button><button class="join f16 c-bg @if($option['shareUserId'])w100 @endif" onclick="$.shoppingcartOne(1)">立即购买</button>';
                $("#cz_btn").html(string);
                return false;
            })

            //弹出规格2
            $(".y-addshoppingcart").click(function(){
                $(".size-frame1").removeClass('none');
                $(".show_item_norms_item .y-ggpsize2 span").eq(0).addClass('active');
                var val  = $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-info');
                var prs  = $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-prs');
                var salePrice  =  $(".show_item_norms_item .y-ggpsize2 span").eq(0).attr('data-salePrice');
                if(salePrice <= 0){
                    prs = prs;
                }else{
                    prs = salePrice;
                }

                $(".show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .subtract").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .add_norms").attr('data-salePrice',salePrice);
                $(".show_item_norms_item .add").attr('data-salePrice',salePrice);
                if(goodsNorms == 0){
                    $(".show_item_norms_item .val").removeClass('none');
                }

                var string = '<button class="join f16 c-bg w100" onclick="$.shoppingcart()">确定</button>';
                $("#cz_btn").html(string);
                return false;
            })

            // 数量加载
            $(document).on("click",".subtract",function(){
                var val = $("#goodsval").val();
                val = parseInt(val) - 1;
                if(val < 1){
                    val = 1;
                    $.alert('数量必须大于1！');
                    return false;
                }
                $("#goodsval").val(val);
                $.funcMoney2(0,val,0);
            });

            $(document).on("click",".add",function(){
                var val = $("#goodsval").val();
                if(val  == ""){
                    val = 0;
                    $(".subtract").removeClass("none");
                }
                val = parseInt(val) + 1;
                if (val > parseInt($('.goods_stock').val())) {
                    $.alert('商品库存不足');
                    return;
                }
                $("#goodsval").val(val);
                $.funcMoney2(0,val,0);
            });

            //规格数量加载
            $(document).on("click",".subtract_norms",function(){
                $(".msg_show").addClass("none");
                $.toast('',100);//勿删
                var val = $("#normsval").val();
                val = parseInt(val) - 1;
                if(val < 0){
                    val = 1;
                    $.alert('数量必须大于0！');
                    return false;
                }
                var ids =  $(this).attr("data-id");
                var price =  $(this).attr("data-price");
                $.funcMoney2(ids,val,price);
            });

            $(document).on("touchend",".add_norms",function(){
                $.toast('',100);//勿删
                var val = $("#normsval").val();
                val = parseInt(val) + 1;
                var ids =  $(this).attr("data-id");
                var price = 0;
                if($(this).attr("data-salePrice") <= 0){
                    price = $(this).attr("data-price");
                }else{
                    price = $(this).attr("data-salePrice");
                }
                $.funcMoney2(ids,val,price);
            });

            var serviceFee = "{{ $seller['serviceFee'] }}";

            $.funcMoney2 = function(id,value,price){
                $(".show_item_norms_item .subtract_norms ").removeClass('none');
                $(".show_item_norms_item .subtract ").removeClass('none');
                $(".show_item_norms_item .val ").removeClass('none');
                $(".show_item_norms_item #normsval_span ").text(value);
                $(".show_item_norms_item #normsval").val(value);
                $(".show_item_id_"+id+"_norms").attr("data-info",value);
            }
            $.shoppingcart = function(status){
                if(status == ""){
                    status = 0;
                }
                if(goodsNorms == 1){ //有规格
                    var val = $("#normsval").val();
                    if(val == 0){
                        $.toast('请选择数量!');
                        return false;
                    }
                }else{ //没有规格
                    var val = $("#goodsval").val();
                    if(val == 0){
                        $.toast('请选择数量!');
                        return false;
                    }
                }

                var ids = '';
                var price = 0;
                $(".y-ggpsize2 span").each(function(i){
                    if($(this).hasClass("active")){
                        ids =  $(this).attr("data-id");
                        if($(this).attr("data-salePrice") <= 0){
                            price = $(this).attr("data-price");
                        }else{
                            price = $(this).attr("data-salePrice");
                        }
                    }
                })
                $.funcMoney(ids,val,price,status);
            }

            $.funcMoney = function(id,value,price,status){
                $.post("{{u('Goods/saveCart')}}", { goodsId: {{$data['id']}}, normsId: id, num: value, serviceTime:0, shareUserId:"{{$option['shareUserId']}}"},function(res){
                    if(res.code < 0){
                        $(".show_item_norms_item,.modal-overlay").remove();
                        $.router.load("{{u('User/login',['shareUserId' => $option['shareUserId']])}}", true);
                        return;
                    }
                    if(res.code > 0){
                        $.toast('添加失败！'+res.msg);
                        return false;
                    }
                    if(res.code == 0){
                        if(value > 0){
                            $(".show_item_norms_item .subtract_norms ").removeClass('none');
                            $(".show_item_norms_item .val ").removeClass('none');
                            $(".show_item_norms_item #normsval_span ").text(value);
                            $(".show_item_norms_item #normsval").val(value);
                            $(".show_item_id_"+id+"_norms").attr("data-info",value);
                        }else{
                            $(".show_item_norms_item .subtract_norms ").addClass('none');
                            $(".show_item_norms_item .val ").addClass('none');
                            $(".show_item_norms_item #normsval_span ").text(0);
                            $(".show_item_norms_item #normsval").val(0);
                            $(".show_item_id_"+id+"_norms").attr("data-info",0);
                        }

                        var totalPrice = 0;
                        var totalAmount = 0;
                        var cartIds = '';
                        for(var i = 0; i < res.data.list.length; i++){
                            if(res.data.list[i].id == "{{$data['seller']['id']}}"){
                                var cartGoods = res.data.list[i].goods;
                                for(var j = 0; j < cartGoods.length; j++){
                                    totalAmount += parseInt(cartGoods[j].num);
                                    if(cartGoods[j].sale <= 0){
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat(cartGoods[j].price);
                                    }else{
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat((cartGoods[j].price * cartGoods[j].sale) / 10);
                                    }
                                    cartIds += cartGoods[j].id+",";
                                }
                                break;
                            }
                        }
                        cartIds = cartIds.substring(0,cartIds.length-1);

                        $(".show_item_norms_item").addClass('none');
                        if(status == 1){
                            $.href('{{u('Order/order')}}?cartIds='+cartIds);
                        }else{
                            $.toast('添加成功，在购物车等亲~');

                            if(goodsNorms == 1){ //有规格
                                $("#normsval").val(value);
                            }else{ //没有规格
                                $("#goodsval").val(value);
                            }
                        }

                        $("#cartTotalAmount").html(totalAmount);
                        $("#cartTotalPrice").html(totalPrice.toFixed(2));
                    }else{
                        $(".show_item_norms_item .msg_show").removeClass("none");
                    }
                },'json' );
            };

            //收藏
            $(document).on("touchend",".collect",function(){
                var obj = new Object();
                var collect = $(this);
                obj.id = "{{$data['id']}}";
                obj.type = 1;

                if(collect.hasClass("c-red")){
                    $.post("{{u('UserCenter/delcollect')}}",obj,function(result){
                        if(result.code == 0){
                            $.toast("已取消收藏～");

                            collect.removeClass("c-red");
                            collect.html('<span class="icon icon-cart iconfont f18">&#xe651;</span><span class="tab-label">收藏</span>');
                        } else if(result.code == 99996){
                            $.router.load("{{u('User/login')}}", true);
                        } else {
                            $.alert(result.msg);
                        }
                    },'json');
                }else{
                    $.post("{{u('UserCenter/addcollect')}}",obj,function(result){
                        if(result.code == 0){
                            $.toast("收藏成功，可以在我的收藏找到TA啦～");
                            collect.addClass("c-red");
                            collect.html('<span class="icon icon-cart iconfont f18">&#xe652;</span><span class="tab-label">已收藏</span>');
                        } else if(result.code == 99996){
                            $.router.load("{{u('User/login')}}", true);
                        } else {
                            $.alert(result.msg);
                        }
                    },'json');
                }
            });

            //跟新购物车 caiq
            function updateCart(goodsNum){
                $.showIndicator();
                $.post("{{u('Goods/saveCart')}}", { goodsId: {{$data['id']}}, normsId: 0, num: goodsNum, serviceTime: '' }, function(res){
                    if(res.code == 0){
                        var totalPrice = 0;
                        var totalAmount = 0;

                        for(var i = 0; i < res.data.list.length; i++){
                            if(res.data.list[i].id == "{{$data['seller']['id']}}"){
                                var cartGoods = res.data.list[i].goods;
                                for(var j = 0; j < cartGoods.length; j++){
                                    totalAmount += parseInt(cartGoods[j].num);
                                    if(cartGoods[j].sale <= 0){
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat(cartGoods[j].price);
                                    }else{
                                        totalPrice += parseInt(cartGoods[j].num) * parseFloat((cartGoods[j].price * cartGoods[j].sale) / 10);
                                    }
                                    cartIds += cartGoods[j].id+",";
                                }
                            }
                        }
                        cartIds = cartIds.substring(0,cartIds.length-1);

                        $.toast('添加成功，在购物车等亲~');

                        if(goodsNorms == 1){ //有规格
                            $("#normsval").val(goodsNum);
                        }else{ //没有规格
                            $("#goodsval").val(goodsNum);
                        }

                        $('.total_amount').text(totalAmount);
                        $('#cartTotalPrice').text(totalPrice.toFixed(2));
                    }else if(res.code < 0){
                        $.alert("请先登录！");
                        setTimeout('toLogin()', 2000);
                        return;
                    }else{
                        $.toast('添加失败！'+res.msg);
                    }
                    $.hideIndicator();
                });
            }

            // 关闭规格弹框
            $(".x-closebg .x-closeico").click(function(){
                $(this).parents(".f-bgtk").addClass('none');
            });
            // 规格选择
//            $(".x-psize span").click(function(){
//                $(this).addClass("c-bg").siblings().removeClass("c-bg");
//            });
        })
    </script>
@stop