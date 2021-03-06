@extends('wap.community._layouts.base')

@section('css')
    <style>
        .swiper-container-horizontal > .swiper-pagination{bottom: 15px;}
        .x-psize45 span .c-bg{
            color:#fff;
            border:1px solid #ff2d4b;
        }
        .x-psize45 span{
            line-height:1.6rem;
            padding:0 .5rem;
            border-radius:.15rem;
            font-size:.6rem;
            margin:.25rem .9rem 0 0;
            display:inline-block;
            border:1px solid rgb(238,238,238);
        }
        .spec span,.goodsprocess span{padding: 0.2rem;border: 1px solid #999;border-radius: .2rem;margin-right: .2rem;}
        .chooise{color: red; border:1px solid red !important;}
    </style>
@stop
@section('show_top')
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left" href="javascript:$.href('@if($nav_back_url){{$nav_back_url}}@else{{ u('Goods/index',['id'=>$data['sellerId'],'type'=>1,'urltype'=>1]) }}@endif')" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <h1 class="title f16">商品详细</h1>
        <a class="button button-link button-nav pull-right open-popup collect_it collect_opration @if($data['iscollect']) on @endif" data-id="{{$data['id']}}" data-popup=".popup-about" href="#">
            <!-- 分享 -->
            <i class="icon share iconfont c-black">&#xe616;</i>
        </a>
    </header>
@stop
@section('content')
    <script type="text/javascript">
        BACK_URL = "{!! u('Goods/index',['id'=>$seller['id'],'type'=>1]) !!}";
        //BACK_URL = "{!! Request::server('HTTP_REFERER') !!}";
    </script>
    <?php
    //存在规格和折扣 获取规格最低价 根据折扣结算出新的特价
    if(count($data['norms']) > 0 && !empty($seller['activity']['special'])) {
        $f = true;
        foreach ($data['norms'] as $key => $value) {
            $salePrice = $value['price'] * $seller['activity']['special']['sale'] / 10;
            $data['norms'][$key]['salePrice'] = $salePrice;
            if($f){
                $seller['activity']['special']['minNormsPrice'] = $salePrice;
                $data['price'] = $value['price'];
                $f = false;
            }
            elseif(!$f && $salePrice <= $seller['activity']['special']['minNormsPrice']){
                $seller['activity']['special']['minNormsPrice'] = $salePrice; //最低折扣价
                $data['price'] = $value['price']; //最低原价
            }
        }
    }
    ?>
    @include('wap.community._layouts.base_cart_item')
    <div class="content" class="swiper-container my-swiper" data-space-between='0'>
        <div class="x-bigpic pr" style="border-bottom: 1px solid #ccc;">
            @if($data['images'][1])
                <div id="indexAdvSwiper" class="swiper-container my-swiper" data-space-between='0'>
                    <div class="swiper-wrapper">
                        @foreach($data['images'] as $key => $value)
                            <div class="swiper-slide pageloading">
                                <img _src="{{ formatImage($value,640) }}" src="{{ formatImage($value,640) }}" />
                            </div>
                        @endforeach
                    </div>
                    <div class="swiper-pagination swiper-pagination-adv"></div>
                </div>
            @else
                <div class="swiper-slide pageloading swiper-slide-active">
                    <img src="{{ formatImage($data['images'][0],640,640) }}" />
                </div>
            @endif
        </div>

        <!-- 选择数量 -->
        <div class="list-block x-goods m0 nobor">
            <ul style="background: #f0eff5;">
                <li class="item-content" style="margin-bottom: .2rem;">
                    <div class="item-inner" style="padding-top: 0;">
                        <div class="item-title f14">{{$data['name']}}</div>
                        <div style="border-left: 1px solid #ccc; padding: .5rem;padding-right: 0;">
                            <a class="collect_it @if($data['iscollect']) on @endif" data-id="{{$data['id']}}" href="#">
                                @if($data['iscollect'] == 1)
                                    <i class="icon collect iconfont c-red m0">&#xe69b;</i><!-- 已收藏图片  -->
                                @else
                                    <i class="icon collect iconfont c-black m0">&#xe69b;</i><!-- 未收藏图标 -->
                                @endif
                            </a>
                        </div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-inner">
                        <div class="item-title f12" style="color: #999;">选择规格</div>
                    </div>
                </li>
                <li class="item-content spec">
                    <div class="f12" style="color: #999;">
                        @if($data['norms'])
                            @foreach($data['norms'] as $key => $item)
                                <span data-price="{{ $item['price'] }}" data-id="{{ $item['id'] }}">{{$item['name']}}</span>
                            @endforeach
                        @else
                            <span data-price="@if($data['autoType'] == 1) {{ $data['salePrice'] }} @elseif(!empty($seller['activity']['special'])) {{ $data['price'] * $seller['activity']['special']['sale'] / 10 }} @else {{ $data['price'] }} @endif" data-id="0">{{ $data['model'] ? $data['model'] : '无' }}</span>
                        @endif
                    </div>
                </li>
                @if(!empty($data['goodsProcessingCharges']))
                    <li class="item-content">
                        <div class="item-inner">
                            <div class="item-title f12" style="color: #999;">选择加工方式</div>
                        </div>
                    </li>
                    <li class="item-content goodsprocess">
                        <div class="f12" style="color: #999;">
                            @foreach($data['goodsProcessingCharges'] as $key => $item)
                                <span data-price="{{ $item['price'] }}" data-id="{{ $item['id'] }}">{{$item['name']}}</span>
                            @endforeach
                        </div>
                    </li>
                @endif
                <li class="item-content spec-price">
                    <div class="item-inner">
                        <div class="item-title" style="color: #999;border-top: 1px solid #f2f2f2;border-bottom: 1px solid #f2f2f2;padding:.5rem 0;width: 100%;">
                            <div class="c-red pull-left">
                                @if($data['autoType'] == 1)
                                    <span>促销价：</span>
                                @endif
                                ￥<span class="chooise-price">0.00</span>
                                <span class="chooise-spec f12" style="color: #999;"></span>
                            </div>
                            <div class="pull-right">
                                <span class="icon iconfont c-red subtractx none" style="font-size:1.1rem;">&#xe621;</span>
                                <span class="numberx none">0</span>
                                <span class="icon iconfont c-red addx" style="font-size:1.1rem;">&#xe61e;</span>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
            <span class="norms_stock none">{{$data['stock']}}</span>
            <input type="hidden" class="goods_stock" value="{{$data['stock']}}" />
        </div>
        @if(!isset($hide))
            <div style="background: #fff;">
                <div style="margin-left: 10px;color: #999999;text-align: center;">
                    <span style="color: red;">•</span>&nbsp;商品参数&nbsp;<span style="color: red;">•</span>
                </div>
                <div style="margin:0 1rem;padding: .3rem 0;border-bottom: 1px solid #f1f1f1;">
                    <span style="color: #ccc;padding-left: .5rem;">品牌&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
                    <span>{{ $data['shopBrand']['name'] }}</span>
                </div>
                <div style="margin:0 1rem;padding: .3rem 0;border-bottom: 1px solid #f1f1f1;">
                    <span style="color: #ccc;padding-left: .5rem;">规格&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
                    <span>{{ $data['model'] }}</span>
                </div>
                <div style="margin:0 1rem;padding: .3rem 0;border-bottom: 1px solid #f1f1f1;">
                    <span style="color: #ccc;padding-left: .5rem;">包装&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
                    <span>{{ $data['goodsUnit'] }}</span>
                </div>
            </div>
        @endif
        @if(!empty($seller['activity']['full']) || !empty($seller['activity']['special']) || !empty($seller['activity']['new']))
            <div class="list-block media-list y-nocenter">
                <ul>
                    <li class="item-content">
                        <div class="item-media f12 c-gray">促销</div>
                        <div class="item-inner y-minHnone">
                            <?php $first = true; ?>
                            @if(!empty($seller['activity']['full']))
                                <div class="item-title f12">
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
                                <div class="item-title f12">
                                    <img src="{{ asset('wap/community/newclient/images/ico/tei.png') }}" width="16" class="icon iconfont c-gray va-3 mr5">
                                    <span>商家特价优惠</span>
                                </div>
                            @endif
                            @if(!empty($seller['activity']['new']))
                                <div class="item-title f12">
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
        <div class="list-block f14 nobor" onclick="$.href('{{ u('Seller/detail',['id'=>$seller['id'],'showurl'=>Input::get('showurl')]) }}')">
            <ul>
                <li class="item-content active">
                    <div class="item-inner pr10">
                        <div class="item-title">
                            <i class="icon iconfont c-gray vat mr5">&#xe632;</i><span>{{$seller['name']}}</span>
                        </div>
                        <i class="icon iconfont c-gray f13 mr-2">&#xe602;</i>
                    </div>
                </li>
            </ul>
        </div>
        <input type="hidden" class="goods_stock" value="{{$data['stock']}}" />

        <!-- 商品详情 -->
        <div class="content-block-title f14 c-black">商品详情</div>
        <div class="c-bgfff pb10 y-img">
            <div class="p10 y-img">{!!$data['brief']!!}</div>
        </div>
    </div>
    <!-- 规格弹框1 -->
    <div class="f-bgtk size-frame1 show_item_norms_item_udb none">
        <div class="x-closebg">
            <div class="x-probox c-bgfff">
                <div class="x-prott pr">
                    <div class="x-propic">
                        <img src="{{$data['images'][0]}}" />
                    </div>
                    <div class="x-prottr pt10">
                        @if(!empty($data['norms']))
                            @if(empty($seller['activity']['special']))
                                <p class="c-red pt5 f14">￥<span class="f20 money_toal" id="money_toal_{{$data['norms'][0]['id'] or $data['id']}}">@if($data['norms']){{ number_format($data['norms'][0]['salePrice'] or $data['norms'][0]['price'], 2) }}@else {{ number_format($data['salePrice'] or $data['price'], 2) }} @endif</span></p>
                            @else
                                @if($seller['activity']['special']['sale'] > 0)
                                    <p class="c-red pt5 f14">
                                        ￥<span class="f20 money_toal" id="money_toal_{{$data['norms'][0]['id']}}">{{ $data['norms'][0]['price'] * $seller['activity']['special']['sale'] / 10 }}</span>
                                    </p>
                                @else
                                    <p class="c-red pt5 f14">
                                        ￥<span class="f20 money_toal" id="money_toal_{{$data['norms'][0]['id']}}">{{ $data['norms'][0]['price'] }}</span>
                                    </p>
                                @endif
                                <p>
                                    <del class="c-gray f13 delPrice">￥{{ $data['norms'][0]['price'] }}</del>
                                    @if($seller['activity']['special']['sale'] > 0)
                                        <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                                    @endif
                            @endif
                        <p class="f12 c-black">库存<span class="goods_stock">{{$data['norms'][0]['stock']}}</span>件</p>
                        @else
                            @if(empty($seller['activity']['special']))
                                    <p class="c-red pt5 f14">￥<span class="f20 money_toal" id="money_toal_{{$data['norms'][0]['id'] or $data['id']}}">{{ number_format($data['salePrice'] or $data['price'], 2) }}</span></p>
                            @else
                                <p class="c-red pt5 f14">
                                    ￥<span class="f20 money_toal" id="money_toal_{{$data['norms'][0]['id']}}">{{ $seller['activity']['special']['salePrice'] }}</span>
                                </p>
                                <p><del class="c-gray f13 delPrice">￥{{ $data['price'] }}</del>
                                    @if($seller['activity']['special']['sale'] > 0)
                                        <span class="c-red f12 ml5">{{ $seller['activity']['special']['sale']}}折特价</span>
                                    @endif
                             @endif
                            <p class="f12 c-black">库存<span class="goods_stock">{{(int)$data['stock']}}</span>件</p>
                        @endif
                        <i class="icon iconfont x-closeico c-gray">&#xe604;</i>
                    </div>
                </div>
                <div class="y-max-height">
                    @if(!empty($data['norms']) || !empty($data['goodsProcessingCharges']))
                        <div class="x-prott pr">
                            <p class="f14">请选择商品属性</p>
                            @if(!empty($data['norms']))
                                <p>选择规格</p>
                                <div class="x-psize clearfix c-gray f12 y-ggpsize2 select-item">
                                    @foreach($data['norms'] as $key => $item)
                                        <span class="@if($key == 0) c-bg @endif show_item_id_{{$item['id']}}_norms_udb" data-info="{{$item['inCart']}}" data-id="{{$item['id']}}" data-prs="{{$item['price']}}" data-stock="{{$item['stock']}}" data-salePrice="{{ round($item['salePrice'], 2) }}" onclick="$.showItemNorms_item_udb({{$item['id']}},{{ round($item['salePrice'], 2) }})">{{$item['name']}}</span>
                                    @endforeach
                                </div>
                            @endif
                            @if(!empty($data['goodsProcessingCharges']))
                                <p>加工方式</p>
                                <div class="x-psize45 clearfix c-gray f12 y-ggpsize2 select-process">
                                    @foreach($data['goodsProcessingCharges'] as $key => $item)
                                        <span class="process_cart" data-id="{{$item['id']}}" data-prs="{{$item['price']}}"  data-salePrice="{{ round($item['salePrice'], 2) }}">{{$item['name']}}</span>
                                    @endforeach
                                </div>
                            @endif
                        </div>
                        <div class="x-pnum pl10 pr10">
                            <span class="f14">购买数量</span>
                            <div class="fr x-num">
                                <i class="icon iconfont c-gray subtract_norms_cz  @if(!$cart['goods'][$data['id']]['num']) none  @endif" data-id="{{$data['norms'][0]['id'] or $data['id']}}" data-price="{{ number_format($data['norms'][0]['price'] or $data['price'],2) }}">&#xe621;</i>
                                <span class="val tc pl0 @if(!$cart['goods'][$data['id']]['num']) none @endif" id="normsval_span">@if($cart['goods'][$data['id']]['num']){{$cart['goods'][$data['id']]['num'] or 0 }} @endif</span>
                                <input type="hidden" value="0" class="val tc pl0 " id="normsval"  readonly="readonly" />
                                <i class="icon iconfont c-red add_norms_cz " data-id="{{$data['norms'][0]['id'] or $data['id']}}"  data-price="{{ round($data['norms'][0]['price'], 2) }}" data-salePrice="{{ round($v['norms'][0]['salePrice'], 2) }}" data-process-id="">&#xe61e;</i>
                            </div>
                        </div>
                    @else
                        <div class="x-pnum pl10 pr10">
                            <span class="f14">购买数量</span>
                            <div class="fr x-num">
                                <i class="icon iconfont c-gray subtract_cz @if($cart['goods'][$option['goodsId']]['num'] == 0) none @endif" data-id="{{$data['id']}}" data-price="{{ round($data['price'], 2) }}" data-salePrice="{{ round($data['norms']['salePrice'], 2) }}">&#xe621;</i>
                                <span class="val tc pl0 @if(!$cart['goods'][$option['goodsId']]['num'])none @endif" id="normsval_span">{{$cart['goods'][$option['goodsId']]['num'] or 0}}</span>
                                <input type="hidden" value="{{$cart['goods'][$option['goodsId']]['num']}}" class="val tc pl0 " id="normsval"  readonly="readonly" />
                                <i class="icon iconfont c-red add_cz" data-id="{{$data['id']}}"  data-price="{{ round($data['price'], 2) }}" data-salePrice="{{ round($data['norms']['salePrice'], 2) }}" data-process-id="">&#xe61e;</i>
                            </div>
                        </div>
                    @endif
                </div>
                <div class="x-pbtn c-white none udb_btn_show" id="cz_btn">
                    <button class="join f16 c-bg w100" onclick="$.shoppingcart()">确定</button>
                </div>
            </div>
        </div>
    </div>
    @include('wap.community.goods.share')
@stop

@section($js)
    <script src="{{ asset('js/dot.js') }}"></script>
    <script type="text/javascript">
        var normsInCart = [];
        @foreach($data['norms'] as $key => $item)
            normsInCart[{{$item['id']}}] = {{$item['inCart']}};
        @endforeach
    </script>
    <script type="text/javascript">
        var cartIds = "{{$cartIds}}";
        var goodsNorms = "<?php echo !empty($data['norms']) ? 1 : 0; ?>";
        var flage = 0;
        $(document).on('click', '.process', function() {
            var id, prs;
            var $obj = $('[data-norms-price]');
            var ns = $obj.attr('data-norms-price');
            var flage1 = true;
            $(".show_item_norms_item li").each(function () {
                if (flage1) {
                    if ($(this).hasClass('active')) {
                        ns = parseFloat($(this).attr('data-saleprice')) > 0 ? parseFloat($(this).attr('data-saleprice')) : parseFloat($(this).attr('data-prs'));
                        flage1 = false;
                    }
                }
            });
            if ($(this).hasClass('active')) {
                prs = 0;
                id = 0;
                $(this).removeClass('active');
            } else {
                prs = parseFloat($(this).attr('data-prs'));
                id = $(this).attr('data-id');
                $(this).addClass('active').siblings().removeClass('active');

            }
            var total = prs + ns;
            $obj.attr('data-process-price', prs);
            $('.add_norms').attr('data-process-id',id);
            $(".money_toal").html(total);
        });
        $(document).on("click",'.process_cart',function(){
            var prs = 0;
            if(goodsNorms == 0){
                var salePrice = parseInt("{{$data['salePrice']}}");
                var price = parseInt("$data['price']");
            }else{
                var salePrice = 0;
                var price = 0;
                $(".select-item span").each(function(){
                    if($(this).hasClass('active') == true){
                        salePrice = parseInt($(this).attr("data-saleprice"));
                        price = parseInt($(this).attr("data-prs"));
                    }
                });
            }
            if(salePrice > 0){
                prs = salePrice;
            }else{
                prs = price;
            }
            if($(this).hasClass('active') == true){
                $(".show_item_norms_item_udb .money_toal").html(prs);
                $(".show_item_norms_item_udb .add_norms_cz").attr('data-process-id',0);
                $(this).removeClass('active');
                $(this).removeClass('c-bg');
            }else{
                $(this).addClass('active').siblings().removeClass('active');
                $(this).addClass('c-bg').siblings().removeClass('c-bg');
                prs = prs + parseInt($(this).attr("data-prs"));
                $(".show_item_norms_item_udb .money_toal").html(prs);
                $(".show_item_norms_item_udb .add_norms_cz").attr('data-process-id',$(this).attr('data-id'));
            }
        });
        if(goodsNorms == 0){
            $(".show_item_norms_item_udb .money_toal").html($(".teshuchuli").attr("data-prs"));
        }
        //弹出规格2
        $(".y-addshoppingcart").click(function(){
            $(".x-cart").removeClass("active");
            $(".f-bgtk").addClass("none");
            $(".size-frame1").removeClass('none');
            if(goodsNorms == 1){
                $(".show_item_norms_item_udb .y-ggpsize2 span").removeClass('active').removeClass('c-bg');
                $(".show_item_norms_item_udb .y-ggpsize2 span").eq(0).addClass("active").addClass("c-bg");
                var val  = $(".show_item_norms_item_udb .y-ggpsize2 span").eq(0).attr('data-info');
                var salePrice = parseInt("{{$data['norms'][0]['salePrice']}}");
                var price = parseInt("{{$data['norms'][0]['price']}}");
                if(val <=0){
                    $(".show_item_norms_item_udb .subtract_cz,.subtract_norms_cz").addClass("none");
                    $(".show_item_norms_item_udb #normsval_span").addClass("none");
                    $(".show_item_norms_item_udb #normsval_span").html(0);
                }else{
                    $(".show_item_norms_item_udb .subtract_cz,.subtract_norms_cz").removeClass("none");
                    $(".show_item_norms_item_udb #normsval_span").removeClass("none");
                    $(".show_item_norms_item_udb #normsval_span").html(val);
                }
            }else{
                $(".show_item_norms_item_udb .val").removeClass('none');
                var prs = "{{$data['price']}}";
                var salePrice = parseInt("{{$data['salePrice']}}");
                $.post("{{u('Goods/getCart1')}}", { goodsId: "{{$data['id']}}", sellerId: "{{$data['sellerId']}}"}, function(res){
                    if(res.code < 0){
                        $(".show_item_norms_item,.modal-overlay").remove();
                        $.router.load("{{u('User/login')}}", true);
                        return;
                    }
                    var n = parseInt(res.data);
                    if(n<=0){
                        $(".show_item_norms_item_udb .subtract_cz").addClass("none");
                        $(".show_item_norms_item_udb #normsval_span").addClass("none");
                        $(".show_item_norms_item_udb #normsval_span").html(0);
                    }else{
                        $(".show_item_norms_item_udb .subtract_cz").removeClass("none");
                        $(".show_item_norms_item_udb #normsval_span").html(n);
                    }
                },'json' );
            }
            if(salePrice > 0){
                prs = salePrice;
            }
            $(".show_item_norms_item_udb .money_toal").html(prs);
            $(".udb_btn_show").removeClass("none");
            $(".y-shopbtm").addClass("none");
            return false;
        })
        //弹出规格1
        $(".y-choicegg").click(function(){
            $(".size-frame2").removeClass('none');
        })
        // 关闭规格弹框
        $(".x-closebg .x-closeico").click(function(){
            $(this).parents(".f-bgtk").addClass('none');
            $(".udb_btn_show").addClass("none");
            $(".y-shopbtm").removeClass("none");
            //$("#goodsval").val($("#cartTotalAmount").html());
            $(".show_item_norms_item_udb #normsval_span").html($("#goodsval{{$data['id']}}").val());
        });

        // 规格选择
        $(".x-psize span").click(function(){
            $(this).addClass("c-bg").siblings().removeClass("c-bg");
        });

        // 数量加载
        $(document).on("click",".subtract_cz",function(){
            var val = $(".show_item_norms_item_udb #normsval_span").html();
            val = parseInt(val) - 1;
            if(val <= 0){
                val = 1;
                $.toast('数量必须大于0！');
                return false;
            }
            $(".show_item_norms_item_udb #normsval_span").html(val);
            $.funcMoney2(0,val,0);
        });

        $(document).on("click",".add_cz",function(){
            var val = $(".show_item_norms_item_udb #normsval_span").html();
            if(val  == ""){
                val = 0;
                $(".show_item_norms_item_udb .subtract").removeClass("none");
            }
            val = parseInt(val) + 1;
            if (val > parseInt($('.goods_stock').val())) {
                $.toast('商品库存不足');
                return;
            }
            $(".show_item_norms_item_udb #normsval_span").html(val);
            $.funcMoney2(0,val,0);
        });

        //规格数量加载
        $(document).on("click",".subtract_norms_cz",function(){
            $(".msg_show").addClass("none");
            $.toast('',100);//勿删
            var val = $(".show_item_norms_item_udb #normsval_span").html();
            val = parseInt(val) - 1;
            if(val <= 0){
                val = 1;
                $.toast('数量必须大于0！');
                return false;
            }
            var ids =  $(this).attr("data-id");
            var price =  $(this).attr("data-price");
            $.funcMoney2(ids,val,price);
        });

        $(document).on("touchend",".add_norms_cz",function(){
            $.toast('',100);//勿删
            var val = $(".show_item_norms_item_udb #normsval_span").html();
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

        $.funcMoney2 = function(id,value,price){
            $(".show_item_norms_item_udb .subtract_norms_cz ").removeClass('none');
            $(".show_item_norms_item_udb .subtract_cz ").removeClass('none');
            $(".show_item_norms_item_udb .val ").removeClass('none');
            $(".show_item_norms_item_udb #normsval_span ").text(value);
            $(".show_item_norms_item_udb #normsval").val(value);
        }
        $.shoppingcart = function(status){
            var val = $(".show_item_norms_item_udb #normsval_span").html();
            if(val == 0){
                $.toast('请选择数量!');
                return false;
            }

            var ids = 0;
            var price = 0;
            if(goodsNorms == 1){
                $(".y-ggpsize2 span").each(function(i){
                    if($(this).hasClass("active")){
                        ids =  $(this).attr("data-id");

                        if($(this).attr("data-salePrice") <= 0){
                            price = $(this).attr("data-price");
                        }else{
                            price = $(this).attr("data-salePrice");
                        }
                        return false;
                    }
                })
            }
            var processId = $(".add_norms_cz").attr('data-process-id');
            $.funcMoney(ids,val,price,processId,status);
        }
        //备份
        $.shoppingcart1 = function(status){
            var val = $(".show_item_norms_item_udb #normsval_span").html();
            if(val == 0){
                $.toast('请选择数量!');
                return false;
            }

            var ids = 0;
            var price = 0;
            if(goodsNorms == 1){
                $(".y-ggpsize2 span").each(function(i){
                    if($(this).hasClass("active")){
                        ids =  $(this).attr("data-id");

                        if($(this).attr("data-salePrice") <= 0){
                            price = $(this).attr("data-price");
                        }else{
                            price = $(this).attr("data-salePrice");
                        }
                        return false;
                    }
                })
            }

            $.funcMoney(ids,val,price,status);
        }

        $("#indexAdvSwiper").swiper({"pagination":".swiper-pagination-adv", "autoplay":2000});

        var serviceFee = "{{ $seller['serviceFee'] }}";
        // 弹窗
        $(document).on('click','.y-xgg', function () {
            $(".msg_show").addClass("none");
            var  html =  $(".show_item_norms_item").html();
            $.modal({
                extraClass:"show_item_norms_item",
                title:  '<div class="y-paytop"><i class="icon iconfont c-gray fr">&#xe604;</i><p class="c-black f18 tl">{{$data['name']}}</p></div>',
                text: html
            });
            $(".show_item_norms_item .y-ggpsize li").eq(0).addClass('active');
            $.post("{{u('Goods/getCart1')}}", { goodsId: "{{$data['id']}}", sellerId: "{{$data['sellerId']}}"}, function(res){
                if(res.code < 0){
                    $(".show_item_norms_item,.modal-overlay").remove();
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                var val = parseInt(res.data);
                var prs  = $(".show_item_norms_item .y-ggpsize li").eq(0).attr('data-prs');
                var salePrice  =  $(".show_item_norms_item .y-ggpsize li").eq(0).attr('data-salePrice');
                if(salePrice <= 0){
                    prs = prs;
                }else{
                    prs = salePrice;
                }
                if(val > 0){
                    $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms ").removeClass('none');
                    $(".modal_show_item_norms_item,.show_item_norms_item .val ").removeClass('none');
                    $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(val);
                    $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(val);

                    $(".show_item_norms_item .money_toal").html(prs);
                }else{
                    $(".modal_show_item_norms_item").removeClass('none');
                    $(".show_item_norms_item .subtract_norms ,.show_item_norms_item .val ").addClass('none');
                    $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(0);
                    $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(0);
                    $(".show_item_norms_item .money_toal").html(prs);
                }
                $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
                $(".modal_show_item_norms_item,.show_item_norms_item .add_norms").attr('data-salePrice',salePrice);
            },'json' );
            return false;
        });
        $.showItemNorms_item_udb = function(id){
            $(".process_cart").removeClass('active');
            $(".process_cart").removeClass('c-bg');
            $(".show_item_norms_item_udb .add_norms_cz").attr('data-process-id',0);
            $(".show_item_norms_item_udb .msg_show").addClass("none");
            $(".show_item_norms_item_udb .y-ggpsize2 span").removeClass('active');
            $(".show_item_id_"+id +"_norms_udb").addClass('active');
            $(".add_norms_cz").attr("data-id",id);
            $(".subtract_norms_cz").attr("data-id",id);
            var val  = $(".show_item_id_"+id +"_norms_udb").attr('data-info');
            var prs  = $(".show_item_id_"+id +"_norms_udb").attr('data-prs');
            var stock  = $(".show_item_id_"+id +"_norms_udb").attr('data-stock');
            var salePrice  = $(".show_item_id_"+id +"_norms_udb").attr('data-salePrice');

            $(".show_item_norms_item_udb .subtract_norms_cz").attr('data-salePrice',salePrice);
            $(".show_item_norms_item_udb .add_norms_cz").attr('data-salePrice',salePrice);
            $(".add_norms_cz").attr("data-price",prs);
            $(".subtract_norms_cz").attr("data-salePrice",salePrice);

            if(salePrice > 0){
                $(".show_item_norms_item_udb .money_toal").html(salePrice);
                $(".show_item_norms_item_udb .delPrice").html('￥'+prs);
                $(".show_item_norms_item_udb .goods_stock").html(stock);
            }else{
                $(".show_item_norms_item_udb .money_toal").html(prs);
                $(".show_item_norms_item_udb .goods_stock").html(stock);
            }
            if(val == 0){
                $(".show_item_norms_item_udb .subtract_norms_cz").addClass("none");
                $(".show_item_norms_item_udb #normsval_span").addClass("none").html(val);
            }else{
                $(".show_item_norms_item_udb .subtract_norms_cz").removeClass("none");
                $(".show_item_norms_item_udb #normsval_span").removeClass("none").html(val);
            }
        }
        $.showItemNorms_item = function(id){
            $('[data-norms-price]').attr('data-process-price', 0);
            $(".modal_show_item_norms_item,.show_item_norms_item .msg_show").addClass("none");
            $(".modal_show_item_norms_item,.show_item_norms_item .y-ggpsize li").removeClass('active');
            $(".show_item_id_"+id +"_norms").addClass('active');
            $(".add_norms").attr("data-id",id);
            $(".subtract_norms").attr("data-id",id);
            var val  = $(".show_item_id_"+id +"_norms").attr('data-info');
            var prs  = $(".show_item_id_"+id +"_norms").attr('data-prs');
            var salePrice  = $(".show_item_id_"+id +"_norms").attr('data-salePrice');

            $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms").attr('data-salePrice',salePrice);
            $(".modal_show_item_norms_item,.show_item_norms_item .add_norms").attr('data-salePrice',salePrice);
            $(".add_norms").attr("data-price",prs);
            $(".subtract_norms").attr("data-salePrice",salePrice);

            if(val > 0){
                $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms ").removeClass('none');
                $(".modal_show_item_norms_item,.show_item_norms_item .val ").removeClass('none');
                $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(val);
                $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(val);
            }else{
                $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms ").addClass('none');
                $(".modal_show_item_norms_item,.show_item_norms_item .val ").addClass('none');
                $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(0);
                $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(0);
            }

            if(salePrice > 0) {
                $(".show_item_norms_item .money_toal").attr('data-norms-price',salePrice);
                var price = parseFloat($(".show_item_norms_item .money_toal").attr('data-norms-price'));
                var process = parseFloat($(".show_item_norms_item .money_toal").attr('data-process-price')) ? parseFloat($(".show_item_norms_item .money_toal").attr('data-process-price')) : 0;
                var total_money = price + process;
                $(".show_item_norms_item .money_toal").html(total_money);
                $(".show_item_norms_item .delPrice").html(prs);
            } else {
                $(".show_item_norms_item .money_toal").attr('data-norms-price',prs);
                var price = parseFloat($(".show_item_norms_item .money_toal").attr('data-norms-price'));
                var process = parseFloat($(".show_item_norms_item .money_toal").attr('data-process-price')) ? parseFloat($(".show_item_norms_item .money_toal").attr('data-process-price')) : 0;
                var total_money = price + process;
                $(".show_item_norms_item .money_toal").html(total_money);
            }
        }
        $(document).on('click','.y-paytop .icon', function () {
            $(".modal").removeClass("modal-in").addClass("modal-out").remove();
            $(".modal-overlay").removeClass("modal-overlay-visible");
            $(".msg_show").addClass("none");
        });
        $(document).on("touchend",".choose_complet",function(){
            if(!$(this).hasClass("no-click")){
                //updateCart($("#goodsval{{$data['id']}}").val());
                $.router.load("{{u('GoodsCart/index')}}", true);
            }else{
                return false;
            }
        });

        // 数量加载
        $(document).on("click",".subtract",function(){
            var val = $(this).siblings(".val").val();
            val = parseInt(val) - 1;
            if(val <= 0){
                val = 1;
                $.alert('数量必须大于0！');
                return false;
            }
            $(this).siblings(".val").val(val);
            $.funcMoney(0,val,0);
        });
        $(document).on("click",".add",function(){
            var val = $(this).siblings(".val").val();
            if(val  == ""){
                val = 0;
                $(".subtract").removeClass("none");
            }
            val = parseInt(val) + 1;
            if (val > parseInt($('.goods_stock').val())) {
                $.alert('商品库存不足');
                if(val == 1){
                    $(".subtract").addClass("none");
                }
                return;
            }
            $(this).siblings("#goodsval{{$data['id']}}").val(val);

            $.funcMoney(0,val,0);
        });
        //规格数量加载
        $(document).on("click",".subtract_norms",function(){
            $(".msg_show").addClass("none");
            $.toast('',100);//勿删
            var val = $("#normsval").val();
            if(val == ""){
                val = 0;
            }
            val = parseInt(val) - 1;
            var ids =  $(this).attr("data-id");
            var price =  $(this).attr("data-price");
            var processId = $(this).attr("data-process-id") ? $(this).attr("data-process-id") : 0;
            $.funcMoney(ids,val,price,processId);

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
            var processId = $(this).attr("data-process-id") ? $(this).attr("data-process-id") : 0;
            $.funcMoney(ids,val,price,processId);

        });
        $.funcMoney = function(id,value,price,processId,status){
            $.post("{{u('Goods/saveCartTwo')}}", { goodsId: {{$data['id']}}, normsId: id, processId:processId, num: value, serviceTime: 0, sellerId:"{{$data['sellerId']}}" }, function(res){
                if(res.code < 0){
                    $(".show_item_norms_item,.modal-overlay").remove();
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                var normsId,goodsid = "{{$data['id'] or 0}}";
                if (id == "0" || id == 0 || id == null){
                    normsId = "null";
                }else{
                    normsId  = id;
                }
                if(res.code == 0){
                    tianchong(res.data['list']);
                    if(value > 0){
                        $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .subtract_norms_cz ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .val ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item .val ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval_span ").text(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval").val(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(value);
                        $(".show_item_id_"+id+"_norms_udb").attr("data-info",value);
                        $(".show_item_id_"+id+"_norms").attr("data-info",value);
                        $(".subtract ").removeClass('none');
                        $("#goodsval{{$data['id']}}").val(value).removeClass('none');
                    }else{
                        $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms_cz ").addClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .subtract_norms ").addClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .val ").addClass('none');//.show_item_norms_item,
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval_span ").text(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval").val(0);
                        $(".show_item_id_"+id+"_norms").attr("data-info",0);
                        $(".show_item_id_"+id+"_norms_udb").attr("data-info",0);
                        $(".show_item_norms_item .subtract_norms ,.show_item_norms_item .val ").addClass('none');
                        $("#goodsval{{$data['id']}}").val(0);
                    }
                    var totalPrice = parseFloat(res.data['totalPrice']);
                    var totalAmount = parseInt(res.data['totalAmount']);
                    if (totalPrice < serviceFee) {
                        var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                        $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
                    } else {
                        $(".choose_complet").removeClass("c-gray97").addClass("c-bg").html('选好了');
                    }

                    $("#cartTotalAmount").html(totalAmount);
                    $("#cartTotalPrice").html(totalPrice.toFixed(2));

                }else{
                    $.toast(res.msg);
                    $("#goodsval{{$data['id']}}").val($("#goodsval{{$data['id']}}").val()-1);
                    $(".modal_show_item_norms_item,.show_item_norms_item .msg_show").removeClass("none");
                }
                $(this).parents(".f-bgtk").addClass('none');
                $(".udb_btn_show").addClass("none");
                $(".y-shopbtm").removeClass("none");
                $(".show_item_norms_item_udb").addClass("none");
                $(".x-cart").removeClass("active");
                $(".f-bgtk").addClass("none");
                $('.modal-overlay').removeClass('modal-overlay-visible');//新增2017/2/16
            },'json' );
        };
        function tianchong(datas){
            var str = '';
            for(var j in datas){
                if("{{$data['seller']['id']}}" == datas[j]['id']){
                    var data = datas[j]['goods'];
                    for(var i in data){
                        var processId = parseInt(data[i]["processid"]);
                        if(isNaN(processId) || processId == 'null' || processId == null){
                            processId = 0;
                        }
                        var normsName = data[i]['normsName'];
                        if(normsName == null || normsName == ''){
                            normsName = '无';
                        }
                        var processingName = data[i]['processingName'];
                        if(processingName == null || processingName == ''){
                            processingName = '无';
                        }
                        str += '<li class="item-content dsyId-'+data[i]["normsId"]+'" id="dsyId-'+data[i]["goodsId"]+'-'+parseInt(data[i]["normsId"])+'-'+processId+'"><div class="item-inner"><div class="item-title-row"><div class="item-title">'+data[i]['name'];
                        str += '<p style="font-size: 10px;margin-top: -3px;">规格：'+normsName+' , 加工：'+processingName+'</p>';
                        str += '</div><div class="item-after"><span class="c-red fl">￥<span  id="cartTotalPrice_DsyPrice_';
                        str += data[i]["goodsId"]+' class="cartTotalPrice_DsyPrice_'+data[i]["normsId"]+'">';
                        if(parseInt(data[i]['sale']) == parseInt(10)){
                            var price = parseFloat(data[i]['price']) + parseFloat(data[i]['processingPrice']);
                            str += price.toFixed(2);
                        }else{
                            var price = parseFloat((parseFloat(data[i]['price']) + parseFloat(data[i]['processingPrice'])) * parseFloat(data[i]['sale']) /10);
                            str += price.toFixed(2);
                        }
                        str += '</span> </span> <div class="x-num fr ml5"> <i class="icon iconfont c-gray udb_subtract fl">&#xe622;</i>';
                        str += '<span class="val tc pl0 fl cartTotalPrice_DsyNum_'+data[i]["normsId"]+'" data-newold="true" data-goodsid="'+data[i]["goodsId"];
                        str += '" data-normsid="'+data[i]["normsId"]+' " data-price="'+data[i]["price"]+'" data-saleprice="'+price+'" data-servicetime="'+data[i]["serviceTime"];
                        str += '" id="cartTotalPrice_DsyNum_'+data[i]["goodsId"]+'-'+parseInt(data[i]["normsId"])+'-'+processId+'" data-processid="'+processId+'">'+data[i]["num"]+'</span>';
                        str +='<i class="icon iconfont c-red fl udb_add">&#xe61f;</i></div> </div> </div> </div> </li>';
                    }
                }
            }
            if(str != ''){
                $("#ul_li_ul").html(str);
            }
        }
        //备份
        $.funcMoney1 = function(id,value,price,status){
            $.post("{{u('Goods/saveCart')}}", { goodsId: {{$data['id']}}, normsId: id, num: value, serviceTime: 0 }, function(res){
                if(res.code < 0){
                    $(".show_item_norms_item,.modal-overlay").remove();
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                var normsId,goodsid = "{{$data['id'] or 0}}";
                if (id == "0" || id == 0 || id == null){
                    normsId = "null";
                }else{
                    normsId  = id;
                }
                if(res.code == 0){

                    var newGoodss = [];
                    $.each(res.data.list,function(ks,vs){
                        $.each(vs.goods,function(k,v){
                            if(v.goodsId == goodsid){
                                newGoodss['name'] = v.name;
                                newGoodss['mun'] = v.num;
                                newGoodss['price'] = v.price;
                                newGoodss['goodsId'] = v.goodsId;
                                newGoodss['sale'] = v.sale;
                                newGoodss['servicetime'] = v.serviceTime;
                                newGoodss['normsId'] = v.normsId;
                                return false;
                            }
                        });
                    });
                    if(normsId > 0){
                        var has = $(".page-current li.dsyId-"+normsId);
                    }else{
                        var has = $(".page-current li#dsyId-"+newGoodss['goodsId']);
                    }
                    //修改
                    if(has.html()){

                        if(newGoodss['sale'] == 10){
                            // newDsyM = '';
                            money = newGoodss['price'] * value;
                        }else{
                            money = newGoodss['price'] * value * (newGoodss['sale']/10);
                        }
                        var moneys = 0;
                        if(money == 0 ){
                            moneys  = "0.00";
                        }else{
                            moneys = money.toFixed(2)
                        }
                        if( normsId > 0 ){
                            $(".page-current li.dsyId-"+normsId+" .cartTotalPrice_DsyPrice_"+normsId).html(moneys);
                            $(".page-current li.dsyId-"+normsId+" .cartTotalPrice_DsyNum_"+normsId).html(value);
                        }else{
                            $(".page-current #cartTotalPrice_DsyPrice_"+newGoodss['goodsId']).html(moneys);
                            $(".page-current #cartTotalPrice_DsyNum_"+newGoodss['goodsId']).html(value);
                        }
                    }
                    //追加
                    else{
                        var money =  0;;
                        // var newDsyM = 0;
                        if(newGoodss['sale'] == 10){
                            // newDsyM = '';
                            money = newGoodss['price'] *value;
                        }else{
                            money = newGoodss['price'] * value * (newGoodss['sale']/10);
                        }
                        var moneys = 0;
                        if(money == 0 ){
                            moneys  = "0.00";
                        }else{
                            moneys = money.toFixed(2)
                        }
                        var html = $("#dsyHtml").html()
                            .replace('GOODSId',newGoodss['goodsId'])
                            .replace('GOODSId',newGoodss['goodsId'])
                            .replace('GOODSId',newGoodss['goodsId'])
                            .replace('GOODSId',newGoodss['goodsId'])
                            .replace('GOODSIDS',newGoodss['goodsId'])
                            .replace('NORMSID',newGoodss['normsId'] ? newGoodss['normsId'] : 0)
                            .replace('NORMSID',newGoodss['normsId'] ? newGoodss['normsId'] : 0)
                            .replace('NORMSID',newGoodss['normsId'] ? newGoodss['normsId'] : 0)
                            .replace('NORMSIDS',newGoodss['normsId'] ? newGoodss['normsId'] : 0)
                            .replace('SALEPRICE',newGoodss['price'] * (newGoodss['sale']/10))
                            .replace('DSYPRICE',newGoodss['price'])
                            .replace('SERVICRTIME',newGoodss['servicetime'] ? newGoodss['servicetime'] : 0 )
                            .replace('NAME',newGoodss['name'])
                            .replace('MONERY',moneys)
                            .replace('MUN',newGoodss['mun']);
                        // .replace('DELMONEY',newDsyM);
                        $("#dsyShowUl ul").prepend(html);
                    }

                    if(value > 0){
                        $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .subtract_norms_cz ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .val ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item .val ").removeClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval_span ").text(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval").val(value);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(value);
                        $(".show_item_id_"+id+"_norms_udb").attr("data-info",value);
                        $(".show_item_id_"+id+"_norms").attr("data-info",value);
                        $(".subtract ").removeClass('none');
                        $("#goodsval{{$data['id']}}").val(value).removeClass('none');
                    }else{
                        $(".modal_show_item_norms_item,.show_item_norms_item .subtract_norms_cz ").addClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb .subtract_norms ").addClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item,.show_item_norms_item_udb .val ").addClass('none');
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval_span ").text(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval_span ").text(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item #normsval").val(0);
                        $(".modal_show_item_norms_item,.show_item_norms_item_udb #normsval").val(0);
                        $(".show_item_id_"+id+"_norms").attr("data-info",0);
                        $(".show_item_id_"+id+"_norms_udb").attr("data-info",0);
                        $("#goodsval{{$data['id']}}").val(0);
                    }

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
                            }
                            break;
                        }
                    }
                    if (totalPrice < serviceFee) {
                        var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                        $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
                    } else {
                        $(".choose_complet").removeClass("c-gray97").addClass("c-bg").html('选好了');
                    }

                    $("#cartTotalAmount").html(totalAmount);
                    $("#cartTotalPrice").html(totalPrice.toFixed(2));

                }else{
                    $.toast(res.msg);
                    $("#goodsval{{$data['id']}}").val($("#goodsval{{$data['id']}}").val()-1);
                    $(".modal_show_item_norms_item,.show_item_norms_item .msg_show").removeClass("none");
                }
                $(this).parents(".f-bgtk").addClass('none');
                $(".udb_btn_show").addClass("none");
                $(".y-shopbtm").removeClass("none");
                $(".show_item_norms_item_udb").addClass("none");
                $(".x-cart").removeClass("active");
                $(".f-bgtk").addClass("none");
            },'json' );
        };
        function toLogin(){
            $.router.load("{{u('User/login')}}", true);
        }
        $(document).on("touchend",".norms_choose",function(){
            $(".size-frame").removeClass('none');
        });
        $(document).on("touchend",".x-closeico",function(){
            $(".size-frame").addClass('none');
        });
        $(document).on("touchend",".norms_item",function(){
            var data = JSON.parse($(this).data('info'));
            $(".norms_price").text(data.price);
            $(".norms_stock").text(data.stock);
            $(".current_price").text("￥ "+data.price);
            $("#normsval").val(data.inCart);
            $(".norms_item").removeClass("c-bg");
            $(".x-prottr").css("visibility",'visible');
            $(".x-pnum").css("visibility",'visible');
            $(this).addClass("c-bg");
        });
        $(".norms_item.c-bg").trigger("click");

        //规格加入购物车
        $(document).on('touchend', '.cart_join,.cart_buy_now', function(){
            if($(".norms_item.c-bg").length==0){
                $.alert("请先选择规格！");
                return false;
            }
            if($('.norms_amount').val()<1){
                $.alert("购买数量不能小于1！");
                return false;
            }
            var isBuy = $(this).hasClass("cart_buy_now");
            var data = new Object();
            var norms =  JSON.parse($(".norms_item.c-bg").data('info'));
            data.goodsId = norms.goodsId;
            data.normsId = norms.id;
            data.num = $("#normsval").val();

            $.post("{{u('Goods/saveCart')}}", data, function(res){
                if(res.code < 0){
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                if(isBuy){
                    $.router.load("{!! u('GoodsCart/index')!!}", true);
                }
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
                        }
                        break;
                    }
                }
                if (totalPrice < serviceFee) {
                    var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                    $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
                } else {
                    $(".choose_complet").removeClass("c-gray97").addClass("c-bg").html('选好了');
                }
                $(".total_amount").text(totalAmount);
                $("#cartTotalPrice").text(totalPrice.toFixed(2));
                $(".current_norms").text(norms.name);
                $(".size-frame").addClass('none');


                $(".choose_complet").removeClass("none");

            });
        })

        //收藏
        $(document).on("touchend",".collect_it .collect",function(){
            var obj = new Object();
            var collect = $(this);
            obj.id = "{{$data['id']}}";
            obj.type = 1;

            if(collect.hasClass("c-red")){
                $.post("{{u('UserCenter/delcollect')}}",obj,function(result){
                    if(result.code == 0){
                        collect.removeClass("on");
                        $.alert(result.msg, function(){
                            collect.removeClass('c-red').addClass('c-black').html('&#xe69b;');
                        });
                    } else if(result.code == 99996){
                        $.router.load("{{u('User/login')}}", true);
                    } else {
                        $.alert(result.msg);
                    }
                },'json');
            }else{
                $.post("{{u('UserCenter/addcollect')}}",obj,function(result){
                    if(result.code == 0){
                        collect.addClass("on");
                        $.alert(result.msg, function(){
                            collect.removeClass('c-black').addClass('c-red').html('&#xe69b;');
                        });
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
                            }
                        }
                    }
                    if (totalPrice < serviceFee) {
                        var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                        $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
                    } else {
                        $(".choose_complet").removeClass("c-gray97").addClass("c-bg").html('选好了');
                    }
                    $(".count").val(goodsNum);
                    $('.cartTotalAmount').text(totalAmount);
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
        // 减少数量
        $(document).off("touchend", ".udb_subtract");
        $(document).on("touchend", ".udb_subtract", function (){
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) - 1;
            $(".msg_show"+sender.data("goodsid")).addClass('none');

            if (value <= 0)
            {
                value = 0;

                $(this).siblings(".add").siblings().addClass("none");
            }
            $.post("{{u('Goods/saveCartTwo')}}", { sellerId:"{{$data['sellerId']}}",type:"{{$data['type']}}",goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), num: value, serviceTime: 0,processId:sender.data("processid") }, function(res){
                if(res.code == 0){
                    var pr = 0;
                    sender.html(value);
                    if(sender.data("saleprice") <= 0){
                        pr = sender.data("price");
                    }else{
                        pr = sender.data("saleprice");
                    }
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));

                    if(value == 0){
                        $("#dsyId-"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).hide();
                        $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(0);
                        $(".subtract").addClass("none");
                        $(".show_item_id_"+sender.data("normsid")+"_norms_udb").attr("data-info",0);
                        $(".show_item_id_"+sender.data("normsid")+"_norms").attr("data-info",0);
                        $("#goodsval"+sender.data("goodsid")).val(0).addClass("none");
                    }else{
                        $(".show_item_id_"+sender.data("normsid")+"_norms_udb").attr("data-info",value);
                        $(".show_item_id_"+sender.data("normsid")+"_norms").attr("data-info",value);
                        $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).text(value);
                    }
                    if(sender.data("normsid") <= 0){
                        $("#goodsval"+sender.data("goodsid")).val(value);

                    }else{
                        $(".show_item_id_"+sender.data("normsid")+"_norms_udb").attr("data-info",value);
                        $(".show_item_id_"+sender.data("normsid")+"_norms").attr("data-info",value);
                    }
                    checkCartGoods(sender.data("normsid"),sender.data("processid"));
                }else{
                    $.toast(res.msg);
                    $("#goodsval"+sender.data("goodsid")).val($("#cartTotalAmount").html());
                }
            } );


        });
        // 添加数量
        $(document).off("touchend", ".udb_add");
        $(document).on("touchend", ".udb_add", function ()
        {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) + 1;

            $.post("{{u('Goods/saveCartTwo')}}", { sellerId:"{{$data['sellerId']}}",type:"{{$data['type']}}",goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), num: value, serviceTime: 0,processId:sender.data("processid") }, function(res){
                if(res.code == 0){
                    var pr = 0;
                    sender.html(value);
                    if(sender.data("saleprice") <= 0){
                        pr = sender.data("price");
                    }else{
                        pr = sender.data("saleprice");
                    }
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(value);
                    $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).text(value);
                    var m = value * sender.data("price");
                    thisVal.siblings().removeClass("none");
                    $(".show_item_id_"+sender.data("normsid")).attr("data-ns",value);
                    if(sender.data("normsid") <= 0){
                        $("#goodsval"+sender.data("goodsid")).val(value);

                    }else{
                        $(".show_item_id_"+sender.data("normsid")+"_norms_udb").attr("data-info",value);
                        $(".show_item_id_"+sender.data("normsid")+"_norms").attr("data-info",value);
                    }
                    checkCartGoods(sender.data("normsid"),sender.data("processid"));
                }else{
                    $.toast(res.msg);
                    $("#goodsval"+sender.data("goodsid")).val($("#cartTotalAmount").html());
                    $(".msg_show"+sender.data("goodsid")).removeClass('none');
                }
            } );

        });
        function CalculationTotal1(totalPrice,totalAmount){
            $("#cartTotalAmount").html(totalAmount);

            $("#cartTotalPrice").html(totalPrice.toFixed(2));

            var serviceFee = "{{ $seller['serviceFee'] }}";
            if (totalPrice < serviceFee) {
                var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
            } else {
                $(".choose_complet").removeClass("c-gray97").addClass("c-bg").html('选好了');
            }
        }
        $(function(){
            //是否有展开箭头
            var innerh = $(".y-nocenter .item-inner .item-title").length;
            if (innerh >= 3) {
                $(".y-nocenter .y-i1").removeClass("none");
                $(".y-nocenter .item-inner .item-title").last().addClass("none");
            }
            // 促销展开与收起
            $(document).off('click','.y-nocenter');
            $(document).on('click','.y-nocenter', function () {
                if($(this).find(".item-inner .item-title").length <= 2){
                    return false;
                }
                if($(this).hasClass("active")){
                    $(this).removeClass("active");
                    $(this).find(".y-unfold").addClass("none").siblings(".y-i1").removeClass("none");
                    $(this).find(".item-title").last().addClass("none");
                }else{
                    $(this).addClass("active");
                    // $(this).css("height",44);
                    $(this).find(".y-unfold").removeClass("none").siblings(".y-i1").addClass("none");
                    $(this).find(".item-title").last().removeClass("none");
                }
            });

        })
    </script>
    <script>
        $(".spec").find("span").bind("click",function(){
            $(".spec span").each(function(){
                $(this).removeClass("chooise");
            });
            $(".goodsprocess span").each(function(){
                $(this).removeClass("chooise");
            });
            var price = $(this).data('price');
            var normId = $(this).data('id') ? $(this).data('id') : 0;
            var goodsprocessId = $(".goodsprocess .chooise").attr('data-id') ? $(".goodsprocess .chooise").attr('data-id') : null;
            $(".spec-price .chooise-price").html(price).attr('data-normid', normId);
            $(".spec-price .chooise-spec").html('/' + $(this).html());
            $(this).addClass("chooise");
            checkCartGoods(normId,goodsprocessId);
        });
        $(".goodsprocess").find("span").bind("click",function(){
            $(".goodsprocess span").each(function(){
                $(this).removeClass("chooise");
            });
            var normId = $(".spec .chooise").attr("data-id");
            if(!normId){
                alert("请先选择规格");
                return false;
            }else{
                var normPrice = $(".spec .chooise").attr("data-price");
            }
            var price = $(this).data('price');
            var price = parseFloat(price) + parseFloat(normPrice);
            var goodsprocessId = $(this).data('id') ? $(this).data('id') : null;
            $(".spec-price .chooise-price").html(price).attr('data-processid', goodsprocessId);
            $(this).addClass("chooise");
            checkCartGoods(normId,goodsprocessId);
        });
        $(".addx").bind("click",function(){
            addCartNum();
        });
        $(".subtractx").bind("click",function(){
            subtractCartNum();
        });
        function changeCart(num,normsid,processId){
            $.post("{{u('Goods/saveCartTwo')}}", { sellerId: "{{$data['sellerId']}}",type: "{{$data['type']}}",goodsId: "{{$data['id']}}", normsId: normsid, processId: processId, num: num, serviceTime: 0 }, function(res){
                if(res.code != 0){
                    $(".numberx").html(num -1);
                    alert(res.msg);
                }else{
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    tianchong(res.data['list']);
                    checkCartGoods(normsid,processId);
                }
            });
        }
        function addCartNum(){
            if(checkPrice() === false){
                alert("请选择规格！");
                return false;
            }
            var normId = $(".spec-price .chooise-price").attr("data-normid");
            var processId = $(".goodsprocess .chooise").attr("data-id");
            var num = parseInt($(".numberx").html());
            num > 0 ? num++ : num = 1;
            changeCart(num,normId,processId);
            $(".subtractx").removeClass('none');
            $(".numberx").html(num).removeClass('none');
        }
        function subtractCartNum(){
            if(checkPrice() === false){
                alert("请选择规格！");
                return false;
            }
            var num = parseInt($(".numberx").html());
            num > 1 ? num-- : (num = 0,$(".numberx").html(num).addClass('none'),$(".subtractx").addClass('none'));
            var normId = $(".spec-price .chooise-price").attr("data-normid");
            var processId = $(".goodsprocess .chooise").attr("data-id");
            changeCart(num,normId,processId);
            $(".numberx").html(num);
        }
        function checkPrice(){
            var price = parseFloat($(".spec-price .chooise-price").html());
            var normPrice = $(".spec .chooise").attr('data-price') ? $(".spec .chooise").attr('data-price') : null;
            var processPrice = $(".goodsprocess .chooise").attr('data-price') ? $(".goodsprocess .chooise").attr('data-price') : 0;
            var totalPrice = parseFloat(normPrice) + parseFloat(processPrice);
            console.log(totalPrice);
            if(totalPrice == price){
                return price;
            }else{
                return false;
            }
        }
        //检测购物车中是否存在商品并增加相关数据
        function checkCartGoods(normId,processId){
            processId ? processId = processId : processId = null;
            var normIdChoose = $(".spec .chooise").attr("data-id");
            var processIdChoose = $(".goodsprocess .chooise").attr("data-id") ? $(".goodsprocess .chooise").attr("data-id") : null;
            if(normIdChoose != normId || processIdChoose != processId){
                return;
            }
            var status = false;
            $.post("{{ u('Goods/getCart') }}",function(res){
                $.each(res.data,function(x,y){
                    if(y.id == "{{$data['sellerId']}}"){
                        $.each(y.goods,function(k,v){
                            if(v.goodsId == "{{ $data['id'] }}" && v.normsId == normId && v.processid == processId){
                                $(".numberx").html(v.num).removeClass('none');
                                $(".subtractx").removeClass('none');
                                status = true;
                            }
                        });
                        if(status === false){
                            $(".numberx").html(0).addClass('none');
                            $(".subtractx").addClass('none');
                        }
                    }
                });
            });

        }
    </script>
@stop