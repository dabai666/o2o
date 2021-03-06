@extends('wap.community._layouts.base')

@section($css)
    <style type="text/css">
        /*.tabs .tab{display: block;}*/
        .y-scr{width: 25%;overflow: hidden;}
        .y-scroll{margin-right: -10px;}
        .y-scr p{line-height: 40px;display: block;text-align: center;border-bottom: 1px solid #ccc;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
        .y-scr p.active{color: #ff2d4b;background: #fff;}
        .tabs{overflow-y: scroll;overflow-x: hidden;}
        .x-goodstab .x-sortlst .list-block{overflow: hidden;}
    </style>
    <style>
		.div-ul-li{
			max-height:35px;
			overflow:hidden;
		}
        .div-ul-li ul li{
            /*以上三行实现自适应start*/
            min-width: 25%;/*设置宽度*/
            text-align: center;/*设置对齐方式*/
            float:left;/*设置浮动未left*/
            /*以上三行实现自适应end*/
            list-style-type:none;/*去掉li的消圆点*/
            display: inline;/*设置成横向排列*/
            margin-top: 10px;
        }
        .button123 {
            /*border: solid 2px #ddd;*/
            /*border: solid 1px #0bbe06;*/
            background: #f3efee;
            /*border-radius: 9px;*/
            font-size: 14px;
            padding: 2px 8px;
            margin: 0;
            display: inline-block;
            line-height: 20px;
            transition: all 1s cubic-bezier(0.175, 0.885, 0.32, 1) 0s
        }
        .a{
            background: #e4e2e3;
        }
        .b{
            background: #f2efee;
        }
        .a1{
            color: red;
        }
    </style>
@stop

@section('show_top')
    @include('wap.community.goods.sellergoodshead')
    @include('wap.community._layouts.base_cart')
@stop

@section('content')
    <script type="text/javascript">
        //BACK_URL = "{!! $nav_back_url !!}";
    </script>
    <?php
    $cartgoods = [];
    foreach($cart["data"]["goods"] as $good)
    {
        if($good["normsId"]){
            $cartgoods[$good["goodsId"]][$good["normsId"]]  = ["num"=>$good["num"], "price"=>$good["price"]];
        }else{
            $cartgoods[$good["goodsId"]]  = ["num"=>$good["num"], "price"=>$good["price"]];
        }

        //$cartgoods[$good["goodsId"]][$good["normsId"]] = $good["num"];
    }
    ?>
    <div class="content" id=''>
        <!-- 菜单列表 -->
        <div class="x-sjfltab x-goodstab clearfix">
            <div class="y-scr fl pr" id="scroll_menu">
                <div class="y-scroll">
                    @foreach($cate as $ckey => $item)
                        <p data-firstLevel="{{ $item['name'] }}" class="herfid{{$ckey}} firstLevel @if($ckey == 0) active @endif " href="{{ $item['id'] }}">{{$item['name']}}</p>
                    @endforeach
                </div>
                <input type="hidden" id="firstLevelId" value="{{ $cate[0]['name'] }}">
            </div>
            <div id="nav2" style="position:absolute;width:75%;z-index:200;right:0; background-color:#fff;">
                    <div style="display: flex;width: 100%;height: 40px;" >
                        <div style="width: 50%;text-align: center;" class="flage a" data-flage="1" id="navheight">
                                    <span  style="font-size: 15px;">
                                        <div style="height: 10px;"></div>
                                        <input style="width: 100%;" type="radio" value="1" class="none" name="flage">
                                        商品品牌
                                    </span>
                        </div>
                        <div style="width: 50%;text-align: center;" class="flage b" data-flage="2">
                                    <span  style="font-size: 15px;">
                                        <div style="height: 10px;"></div>
                                        <input style="width: 100%;" type="radio" value="2" class="none"  name="flage">
                                        按分类筛选
                                    </span>
                        </div>
                        <input  value="1" class="none" id="flage">
                    </div>
                    <div style="padding-bottom: 10px;position:absolute;background:#fff;width:100%;">
                        <div class="div-ul-li" id="brand">
                            <ul>
								<li class="showall"><span>展开</span>&nbsp;<img src="../images/jtzk.png" style="width:.65rem;height:16px;"/></li>
								<li class="cutout none"><span>收起</span>&nbsp;<img src="../images/jtsq.png" style="width:.65rem;height:16px;"/></li>
                                @if($brandList)
                                    @foreach($brandList as $k => $v)
                                        <li><input type="button" value="{{ $v['name'] }}" data-brand-id="{{ $v['id'] }}" class="button123 brand @if($k == 0) a1  teshu @endif"></li>
                                    @endforeach
                                @endif
                            </ul>
                        </div>
                        <div class="div-ul-li none" id="classify">
                            <ul>
								<li class="showall"><span>展开</span>&nbsp;<img src="../images/jtzk.png" style="width:.65rem;height:16px;"/></li>
								<li class="cutout none"><span>收起</span>&nbsp;<img src="../images/jtsq.png" style="width:.65rem;height:16px;"/></li>
                                @if($classifyList)
                                    @foreach($classifyList as $k => $v)
                                        <li ><input type="button" value="{{ $v['name'] }}" data-classify-id="{{ $v['id'] }}" class="button123 classify" ></li>
                                    @endforeach
                                @endif
                            </ul>
                        </div>
                        <input id="brandId" type="hidden" value="-1">
                        <input id="classifyId" type="hidden" value="-1">
                    </div>
                    <!--<hr style="border:1px solid lightgrey;"/>
                    <div id="bb" style="display: flex;width: 100%;height: 40px;">
                        <div style="width: 49.3%;text-align: center;margin-top: 10px;color: #313233;" id="cancel">清&nbsp;空</div>
                        <div style="width: 0.4%;color:#e3e3e3;text-align: center;margin-top: 10px; "></div>
                        <div style="width: 49.3%;text-align: center;margin-top: 10px;color: #313233" id="confirm">确&nbsp;认</div>
                    </div>
                    <hr style="border:1px solid lightgrey;"/>-->
            </div>
            <div id="screenheight" style="height:80px"></div>
            <div class="tabs c-bgfff fl" id="scroll_flage">
                <div id="wdddmain" style="margin-bottom: 100px;">
                    <?php $leftsort = 0;
                    $i = 0;
                    ?>
                    @foreach($cate1 as $ckey => $item)
                        @if(count($item['goods']) > 0)
                            <div id="tab_{{$ckey}}" data-tabid = "{{$ckey}}" class="y-tab @if($item['id'] == Input::get('cateId')) active @else @if(Input::get('cateId') == "" && $leftsort == 0) active @endif  @endif">
                                <div class="list-block media-list x-sortlst f14 nobor pr "><!--y-pull pull-to-refresh-content-->
                                    <ul>
                                        @foreach($item['goods'] as $k=>$v)
                                            <?php
                                            //存在规格和折扣 获取规格最低价 根据折扣结算出新的特价
                                            if(count($v['norms']) > 0 && !empty($v['activity']))
                                            {
                                                $f = true;
                                                foreach ($v['norms'] as $key => $value) {
                                                    $salePrice = $value['price'] * $v['activity']['sale'] / 10;

                                                    $v['norms'][$key]['salePrice'] = $salePrice;

                                                    if($f)
                                                    {
                                                        $v['activity']['minNormsPrice'] = $salePrice;
                                                        $v['price'] = $value['price'];
                                                        $f = false;
                                                    }
                                                    elseif(!$f && $salePrice <= $v['activity']['minNormsPrice'])
                                                    {
                                                        $v['activity']['minNormsPrice'] = $salePrice; //最低折扣价
                                                        $v['price'] = $value['price']; //最低原价
                                                    }

                                                }
                                            }
                                            ?>
                                            <li class="item-content">
                                                <div class="item-inner pl0">
                                                    <div class="item-title">
                                                        <a onclick="$.href('{{u('Goods/detail',['goodsId'=>$v['id'],'type'=>$v['type']])}}')" href="#" style="display: block;position: absolute;width: 70%;height: 3rem;"></a>
                                                        <div>
                                                            <div class="goodspic fl mr5">
                                                                <img class="lazyload" data-original="@if($v['image']) {{ formatImage($v['image'],150,150) }} @else {{ asset('wap/community/client/images/wykdimg.png') }} @endif">
                                                            </div>
                                                            <span class="goodstit">{{$v['name']}}</span>
                                                            @if($v['model'] && $v['model'] !== null)
                                                            <span class="goodsmodel" style="font-size: .6rem;color: #ccc;display: block;margin-bottom: -0.5rem;">{{$v['model']}}</span>
                                                            @endif
                                                        </div>
                                                        <div class="mt5">
                                                            <span class="c-red f15" >
                                                                @if(empty($v['activity']))
                                                                    @if($v['salePrice'] > 0)
                                                                        <span id="goodsddd_{{ $v['id'] }}">
                                                                            ￥{{ number_format($v['salePrice'], 2) }}
                                                                        </span>
                                                                        <span style="color: #999;font-size: .6rem;">@if($v['goodsUnit']) /{{ $v['goodsUnit'] }} @else /件 @endif</span>
                                                                        <s style="color: #999;font-size: .6rem;">￥@if($v['norms']) {{ number_format($v['norms'][0]['price'],2) }}@else {{ number_format($v['price'],2) }} @endif</s>
                                                                    @else
                                                                        <span id="goodsddd_{{ $v['id'] }}">
                                                                            ￥@if($v['norms']) {{ number_format($v['norms'][0]['price'],2) }}@else {{ number_format($v['price'],2) }} @endif
                                                                        </span>
                                                                        <span style="color: #999;font-size: .6rem;">@if($v['goodsUnit']) /{{ $v['goodsUnit'] }} @else /件 @endif</span>
                                                                    @endif
                                                                @else
                                                                    @if(empty($v['activity']['minNormsPrice']))
                                                                        ￥{{number_format($v['activity']['salePrice'], 2)}} <!-- 折扣价 -->
                                                                    @else
                                                                        ￥{{number_format($v['activity']['minNormsPrice'], 2)}} <!-- 规格最低价 -->
                                                                    @endif
                                                                    <del class="f12 c-gray ml5">￥{{number_format($v['price'], 2)}}</del>
                                                                @endif
                                                            </span>
                                                            @if($seller['serviceTimesCount'] > 0)
                                                                @if((count($v['norms']) < 1) && (count($v['goodsProcessingCharges']) < 1))
                                                                    <div class="x-num fr c-red goodsId_show{{$v['id']}}" style="border-color: red;">
                                                                        <i class="icon iconfont c-gray subtract fl <?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>">&#xe622;</i>
                                                                        <span class="val tc pl0 fl <?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>" data-goodsid="{{$v['id']}}" data-normsid="0" data-price="{{ round($v['price'], 2) }}" data-saleprice="{{ round($v['activity']['salePrice'], 2) }}"><?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "0"; else echo $cartgoods[$v['id']][0]['num'] ? $cartgoods[$v['id']][0]['num'] : $cartgoods[$v['id']]['num']; ?></span>
                                                                        <i class="icon iconfont c-red add fl">&#xe61f;</i>
                                                                    </div>
                                                                @else
                                                                    <div class="fr c-red f12 y-xgg totalPrice" style="border-color: red;" data-ids="{{$v['id']}}" data-name="{{$v['name']}}">选规格</div>
                                                                @endif
                                                            @else
                                                                <span class="c-gray f12 fr">商家休息中</span>
                                                            @endif

                                                            @if(!empty($v['activity']))
                                                                <div class="y-specialprice f12"><a href="" class="f12">{{$v['activity']['sale']}}折特价</a></div>
                                                            @endif
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            @if((count($v['norms']) > 0) || (count($v['goodsProcessingCharges']) > 0))
                                                    <!-- 有子菜单 -->
                                            <?php $t = 0; ?>
                                            <div class="show_item_norms_{{$v['id']}} none">
                                                <div class="y-xzggtc tl">
                                                    @if($v['norms'])
                                                        <p class="f14">选择规格</p>
                                                        <ul class="y-ggpsize clearfix normsss" >
                                                            @foreach($v['norms'] as $nk => $n)
                                                                <li  class="@if($nk == 0) active @endif show_item_id_{{ $n['id']}}" data-ns="{{$cartgoods[$v['id']][$n['id']]['num']  or 0 }}" data-salePrice="{{round($n['salePrice'], 2)}}" data-prs="{{$n['price']}}" onclick='$.showItemNorms({{$v['id']}},"{{ $n['id'] }}","{{round($n['price'], 2)}}", "@if($n['salePrice'] > 0) {{round($n['salePrice'], 2)}} @else {{round($n['price'], 2)}} @endif")'>
                                                                    <a href="#">{{$n['name']}}</a>
                                                                </li>
                                                            @endforeach
                                                        </ul>
                                                    @endif
                                                    @if(count($v['goodsProcessingCharges']) > 0)
                                                        <p class="f14">加工方式</p>
                                                        <ul class="y-ggpsize clearfix">
                                                            @foreach($v['goodsProcessingCharges'] as $kkkk => $vvvv)
                                                                <li class="process" data-id="{{$v['id']}}" data-process-id="{{ $vvvv['id'] }}" data-process-price="{{ $vvvv['price'] }}" data-goods-id="{{ $v['id'] }}">
                                                                    <a href="#">{{$vvvv['name']}}</a>
                                                                </li>
                                                            @endforeach
                                                        </ul>
                                                    @endif
                                                </div>
                                                <div class="y-gmnum  pb10 clearfix">
                                                    @if(empty($v['activity']))
                                                        <span class="f14 c-red">
                                                            ￥<span class="money_toal" id="money_toal_{{$v['id']}}" data-process-price="" data-norms-price="@if($v['norms'][0]['salePrice']) {{ number_format($v['norms'][0]['salePrice'], 2) }} @else {{ number_format($v['norms'][0]['price'], 2) }} @endif">@if($v['norms'][0]['salePrice']) {{ number_format($v['norms'][0]['salePrice'], 2) }} @else {{ number_format($v['norms'][0]['price'], 2) }} @endif</span>
                                                        </span>
                                                    @else
                                                        <span class="f14 c-red">
                                                            ￥<span class="money_toal" id="money_toal_{{$v['id']}}">{{ number_format($v['norms'][0]['salePrice'], 2) }}</span>
                                                        </span>
                                                        <del class="c-gray f12 ml5">￥<span class="delPrice">{{ number_format($v['norms'][0]['price'], 2) }}</span></del>
                                                    @endif

                                                    <span class="f14 msg_show msg_show{{$v['id']}} none" style="color: red;font-size: 0.2rem !important;">抱歉：商品库存不足</span>
                                                    <div class="y-num fr goodsId_show{{$v['id']}} " >
                                                        <i class="icon  iconfont c-gray subtract fl <?php if(!$cartgoods[$v['id']][$v['norms'][0]]['num'] && $cartgoods[$v['id']]['num']) echo "none"; ?>">&#xe621;</i>
                                                        <span id="goodsId_process_show_{{ $v['id'] }}" class="show_item_id_mnum val tc pl0 fl <?php if(!$cartgoods[$v['id']][$v['norms'][0]]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>" data-newold="false"  data-goodsid="{{$v['id']}}" data-normsid="{{$v['norms'][0]['id']}}" data-processid="" data-price="{{ round($v['norms'][0]['price'], 2) }}" data-processingprice="0" data-saleprice="{{ round($v['norms'][0]['salePrice'], 2) }}"><?php if(!$cartgoods[$v['id']][$v['norms'][0]] && !$cartgoods[$v['id']]) echo "0"; else echo $cartgoods[$v['id']][$v['norms'][0]['id']]['num'] ? $cartgoods[$v['id']][$v['norms'][0]['id']]['num'] : $cartgoods[$v['id']]['num']; ?></span>
                                                        <i class="icon iconfont c-red add fl">&#xe61e;</i>
                                                    </div>
                                                    @if(!empty($v['activity']))
                                                        <div class="y-specialprice f12 ml0"><a href="">{{$v['activity']['sale']}}折特价</a></div>
                                                    @endif
                                                </div>
                                            </div>
                                            @endif
                                        @endforeach
                                    </ul>
                                </div>
                            </div>
                            <?php $leftsort++; ?>
                        @endif
                    @endforeach
                </div>
            </div>
        </div>
    </div>
    @include('wap.community.goods.share')
@stop
@section("ajax")
    @stop
@section("js_ajax")
    <script src="{{ asset('wap/community/client/js/cel.js') }}"></script>
    <script src="{{ asset('wap/community/newclient/js/jquery.lazyload.js') }}"></script>
    <script>
        Zepto(function($){
            //处理收藏问题
            if(parseInt("{{ $is_conllect }}") > 0){
                $(".collect_opration .collect").addClass("on");
                $(".collect_opration .collect").css('color','red');
                $(".collect_opration .collect").removeClass('c-white');
                $(".collect_opration .collect").html('&#xe654;');
            }else{
                $(".collect_opration .collect").removeClass("on");
                $(".collect_opration .collect").css('color','');
                $(".collect_opration .collect").addClass('c-white');
                $(".collect_opration .collect").html('&#xe653;');
            }
            setHeight(true);//设置高度
            var type = " {{ $option['type'] }}";
            var id = " {{ $option['id'] }}";
            //var firstInto = true;
            var userId = "{{ $userId }}";
            //var dispatching = parseFloat("{{ $seller['serviceFee'] }}") - parseFloat("{{ $cart['totalPrice'] }}");
            $(document).on('click','.process', function() {
                        var id = $(this).attr('data-id');
                        var pid = id;
                        var processid = $(this).attr('data-process-id');
                        var normsId = $("#goodsId_process_show_"+id).attr('data-normsid');
                var processPrice = 0;
                if ($(this).hasClass('active')) {
                    $('.process').removeClass('active');
                    $(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processid', 0);
                    $(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processingprice', 0);
                } else {
                    $('.process').removeClass('active');
                    var processPrice = parseFloat($(this).attr('data-process-price')) ? parseFloat($(this).attr('data-process-price')) : 0;
                    $(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processid', processid);
                    $(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processingprice', processPrice);
                    processPrice = parseFloat($(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processingprice'));
                    $(this).addClass('active');
                }
                var norms_price = 0;
                norms_price = parseFloat($(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-salePrice')) > 0 ? parseFloat($(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-salePrice')) : parseFloat($(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-price'));
//                $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-price',price);
//                $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-salePrice',salePrice);
                /*var flage = true;
                $(".modal_show_item_norms_" + id + ".normsss li").each(function () {
                    if (flage) {
                        alert(1);
                        if ($(this).hasClass('active')) {
                            norms_price = parseFloat($(this).attr('data-saleprice')) > 0 ? parseFloat($(this).attr('data-saleprice')) : parseFloat($(this).attr('data-prs'));
                            flage = false;
                            alert(norms_price);
                        }
                    }
                    alert(flage);
                });*/
                if(norms_price <= parseFloat(0) && (isNaN('norms_price') || norms_price == null || norms_price == '')){
                    norms_price = parseFloat($("#goodsddd_" + id).html());
                }
                /*if(isNaN('norms_price') || norms_price == null || norms_price == ''){
                    norms_price = parseFloat($("#goodsddd_" + id).html());
                }*/
                if(isNaN(norms_price)){
                    norms_price = parseFloat(0);
                }
//                alert(norms_price);
//                alert(typeof(norms_price));
//                alert(processPrice);
//                alert(typeof(processPrice));
                var total_money = norms_price + processPrice;
                $(".modal_show_item_norms_" + id + " .money_toal").html(total_money);
                $.post("{{u('Goods/getVal')}}", { sellerId:"{{Input::get('id')}}",goodsId: pid, normsId: normsId, processId:$(".goodsId_show" + id + " #goodsId_process_show_" + id).attr('data-processid')}, function(res) {
                    if(res.code == 0){
                        var val = res.data;
                        if (val > 0) {
                            $(".modal_show_item_norms_" + pid + " .subtract ").removeClass('none');
                            $(".modal_show_item_norms_" + pid + " .show_item_id_mnum ").removeClass('none');
                            $(".modal_show_item_norms_" + pid + " .show_item_id_mnum ").text(val);
                        } else {
                            $(".modal_show_item_norms_" + pid + " .subtract ").addClass('none');
                            $(".modal_show_item_norms_" + pid + " .show_item_id_mnum ").addClass('none');
                            $(".modal_show_item_norms_" + pid + " .show_item_id_mnum ").text(0);
                        }
                    }
                });
             });
            //左导航
            $(document).on('click',".firstLevel",function(){
                $('.firstLevel').removeClass('active');
                $(this).addClass('active');
                var firstLevelId = $(this).attr('data-firstLevel');
                $("#firstLevelId").val(firstLevelId);
                start();
            });
            //头部导航
            $('.flage').bind('click',function(){
//                alert(1);return ;
                $('.flage').removeClass('a');
                $('.flage').removeClass('b');
                $('.flage').addClass('b');
                $(this).removeClass('a');
                $(this).removeClass('b');
                $(this).addClass('a');

                /*$('.flage').removeClass('a');
                 $('.flage').removeClass('b');*/
                var flage = $(this).attr('data-flage');
                if(flage == 2) {
                    $("#brand").addClass('none');
                    $("#classify").removeClass('none');
                    setHeight(false);//设置高度
                    /* $(this).addClass('b');
                     $("#classify").addClass('a');*/
                }else{
                    $("#classify").addClass('none');
                    $("#brand").removeClass('none');
                    setHeight(true);//设置高度
                    /* $("#brand").addClass('a');
                     $("#classify").addClass('b');*/
                }
                $("#flage").val(flage);
            });
            $("#classify").on("click","input", function() {
                $('.classify').removeClass('a1');
                $(this).addClass('a1');
                var classifyId = $(this).attr('data-classify-id');
                $('#classifyId').val(classifyId);
                confirm();
            });
            $("#brand").on("click","input", function() {
                var id = parseInt($(this).attr('data-brand-id'));
                if(id > 0){
                    $(".teshu").removeClass('a1');
                }else{
                    $(".brand").removeClass('a1');
                }
                if($(this).hasClass("a1")){
                    $(this).removeClass('a1');
                }else{
                    $(this).addClass('a1');
                }
                confirm();
            });
            function confirm(){
                var data = new Object;
                data.page = 1;
                data.type = type;
                data.id = id;
                data.userId = userId;
                var flage = $("#flage").val();
                var firstLevelId = $("#firstLevelId").val();
                data.name = firstLevelId;
                if(flage == 1){
                    var mycars=new Array();
                    var i=0;
                    $("#brandListIdArr li").each(function(){
                        if($(this).find('input').hasClass('a1')){
                            mycars[i] = $(this).find('input').attr('data-brand-id');
                            i = i + 1;
                        }
                    });
                    data.brandId = mycars;
                }else{
                    var classifyId = $("#classifyId").val();
                    data.classifyId = classifyId;
                }
                getList(data,false);
            }
            function setHeight(flage){
                var height1;
                if(flage){
                    height1 = parseInt($("#brand").height())  + parseInt($("#navheight").height());
                }else{
                    height1 = parseInt($("#classify").height())  + parseInt($("#navheight").height());
                }
//                alert(height1);
                //$('#screenheight').css('height',height1);
                /*var height = parseInt($(".bar-nav").height());
                 height += parseInt($(".bar-tab").height());
                 $(".x-goodstab .tab").css("margin-top",parseInt(height1) + 8);
                 $(".x-goodstab .tab").css("height",parseInt($(window).height())-height-height1);
                 $(".x-goodstab .buttons-tab").css({"height":parseInt($(window).height())-height,"overflow": "scroll"});*/
            }
            function getList(data,flage){
                if(flage){
                    getBrand(data);
                    getClassify(data);
                }
                $.post("{{ u('Goods/getGoodsList') }}", data, function(result){
                    groupLoading = false;
                    result  = $.trim(result);
                    if (result != "") {
                        groupPageIndex = 2;
                    }
                    $('#wdddmain').html(result);
                    $(".pull-to-refresh-layer").addClass('none');
                    $.pullToRefreshDone('.pull-to-refresh-content');
                    var flage = parseInt($("#flage").val());
                    if(flage == 1){
                        setHeight(true);//设置高度
                    }else{
                        setHeight(false);//设置高度
                    }
                });
            }
            function getBrand(data){
                $.post("{{ u('Goods/getBrand') }}", data, function(result){
                    result  = $.trim(result);
                    $('#brand').html(result);
					brandShrink();
                });
            }
            function getClassify(data){
                $.post("{{ u('Goods/getClassify') }}", data, function(result){
                    result  = $.trim(result);
                    $('#classify').html(result);
					classifyShrink();
                });
            }
            function start(){
                var data = new Object;
                data.page = 1;
                data.type = type;
                data.id = id;
                data.brandId = -1;
                data.userId = userId;
                var flage = $("#flage").val();
                var name = $("#firstLevelId").val();
//                var secondLevelId = $("#secondLevelId").val();
                data.name = name;
//                data.secondLevelId = secondLevelId;
                getList(data,true);
            }
			function brandShrink(){
				$('#brand .showall').click(function(){
					$('#brand').attr('style','max-height:12rem;overflow:auto;');
					$('#brand .showall').addClass('none');
					$('#brand .cutout').removeClass('none');
				});
				$('#brand .cutout').click(function(){
					$('#brand').attr('style','max-height:35px;overflow:hidden;');
					$('#brand .showall').removeClass('none');
					$('#brand .cutout').addClass('none');
				});
				
			}
			function classifyShrink(){
				$('#classify .showall').click(function(){
					$('#classify').attr('style','max-height:12rem;overflow:auto;');
					$('#classify .showall').addClass('none');
					$('#classify .cutout').removeClass('none');
				});
				$('#classify .cutout').click(function(){
					$('#classify').attr('style','max-height:35px;overflow:hidden;');
					$('#classify .showall').removeClass('none');
					$('#classify .cutout').addClass('none');
				});
			}
			brandShrink();
			classifyShrink();
//            start();
        })
    </script>
    <script type="text/javascript">
        Zepto(function($){
            $("img.lazyload").lazyload({
                placeholder:"{{asset('wap/community/newclient/images/loading.gif')}}"
            });

            //导航和content位置
            var toph = $(".y-sjlistnav").height();
            $(".bar-header-secondary").css("top",toph);
            toph += $(".bar-header-secondary").height();
            $(".content").css({"bottom":0,"top":toph+1,"overflow":"hidden"});
            //菜单高度
            var height = $(".bar-footer").height();
            height += toph;
            $(".y-scroll").css("height",$(window).height()-height);
            $(".tabs").css("height",$(window).height()-height);
            $('.tabs').scrollTop(0);
            $('#wdddmain').css('position','absolute');
            $('#wdddmain').css('width','100%');


            var contentHeight = parseInt($(window).height()) - (parseInt($(".bar-nav").height()) + parseInt($(".bar-header-secondary").height()) + parseInt($("#nav2").height()) + parseInt($(".bar-footer").height()));
            $("#scroll_flage").css("height",contentHeight);

            //菜单点击
            var is_do = 0;
            // $(document).on('click','.y-scroll p', function(){
                // var id = $(this).attr("href");
                // // // alert(id);
                // var topheight = $(id).offset().top+$('.tabs').scrollTop()-$(".y-sjlistnav").height()-$(".bar-header-secondary").height();

                // // alert(topheight);
                // is_do = 1;
                // if(id == "#tab"){
                    // // $('.tabs').scrollTop(0);
                    // $('.tabs').animate({scrollTop:0}, 600);
                // }else{
                    // // $('.tabs').scrollTop(-100);
                    // $('.tabs').animate({scrollTop:topheight}, 600);
                // }
                // $('.y-scroll p').removeClass("active");
                // $(this).addClass("active");
            // });

            //滑动显示头部
            var start = 0,move = 0;
            $(document).off('touchstart',".tabs");
            $(document).on('touchstart',".tabs", function (e) {
                var point = e.touches ? e.touches[0] : e;
                start = point.screenY;
            });

            var startnavh = $(".y-sjlistnav").height();
            // if($(window).width() >= 414){
            //     startnavh = 160;
            // }
            var bhsh = $(".bar-header-secondary").height();
            var scrobox = '';
//            $(document).off('touchmove',".tabs");
            $(".tabs").scroll(function(){
                scrobox = $(this).scrollTop();
                if(is_do == 1){
                    return false;
                }else{
                    // $(".y-tab").each(function(){
                        // var topz = $("#tab_"+$(this).attr('data-tabid')+" .x-goodstit").offset().top;
                        // if(topz != null){
                            // if(topz<= 200 && topz >= 0 ){
                                // y = $(this).attr('data-tabid');
                            // }
                        // }
                    // });
                    // $(".y-scroll .herfid"+y).addClass("active").siblings().removeClass("active");
                }
            });
            /*$(document).on('touchmove',".tabs", function (e) {
                var point = e.touches ? e.touches[0] : e;
                move = point.screenY;
                var s = move - start, nav = $(".y-sjlistnav"), navh = nav.height(), navimg = nav.find(".y-sjxq .item-media img");
                if(navh >= 44 && navh <= startnavh){
                    var y;
                    $(".tabs").scroll(function(){
                        scrobox = $(this).scrollTop();

                        if(is_do == 1){
                            return false;
                        }else{
                            $(".y-tab").each(function(){
                                var topz = $("#tab_"+$(this).attr('data-tabid')+" .x-goodstit").offset().top;
                                if(topz != null){
                                    if(topz<= 200 && topz >= 0 ){
                                        y = $(this).attr('data-tabid');
                                    }
                                }
                            });
                            $(".y-scroll .herfid"+y).addClass("active").siblings().removeClass("active");
                        }
                    });
                    is_do = 0;
                    if(s > 0  && scrobox > 90){
                    }else{
                        //nav高度
                        var navheight = navh+s;
                        if(navheight >= startnavh) navheight = startnavh;
                        if(navheight <= 44) navheight = 44;
                        nav.css("height", navheight);
                        //nav里面的图片
                        var logow = navimg.attr("width")*1+s/2;
                        if(logow >= 45) logow = 45;
                        if(logow <= 0) logow = 0;
                        navimg.attr("width",logow);
                        //透明度
                        $(".y-opacity").css("opacity",navheight/startnavh);
                        //导航
                        $(".bar-header-secondary").css("top",navheight);
                        $(".content").css("top",bhsh+navheight+1);
                        //内容高度
                        var main = $(window).height()-navheight-bhsh-$(".bar-footer").height();
                        $(".y-scroll").css("height",main);
                        $(".tabs").css("height",main);
                    }
                }
            });*/
            $.showTop = function(){
                var top = $(".tabs .active").offset().top+$('.tabs').scrollTop()-$(".y-sjlistnav").height()-$(".bar-header-secondary").height();
                $('.tabs').scrollTop(0);
            }
            $.showTop();
            // 弹窗
            $(document).on('click','.y-xgg', function () {
                var id = $(this).data('ids');
                var pid = id;
                var name = $(this).data('name');
                var html = $(".show_item_norms_" + id).html();
                var normsId = $("#goodsId_process_show_"+id).attr('data-normsid');
                $.modal({
                    extraClass:"modal_show_item_norms_"+id,
                    title:  '<div class="y-paytop"><i class="icon iconfont c-gray fr">&#xe604;</i><p class="c-black f18 tl">'+name+'</p></div>',
                    text:html

                });
                $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).addClass('active');
                var val  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('ns');
                var prs  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('prs');
                var salePrice  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('saleprice');
                if(salePrice){
                    prs = salePrice;
                }
                if(!prs){
                    prs = parseFloat($("#goodsddd_"+id).html());
                    $("#goodsId_process_show_"+id).attr('data-saleprice',prs);
                }
                if(val > 0){
                    $(".modal_show_item_norms_"+id+" .subtract ").removeClass('none');
                    $(".modal_show_item_norms_"+id+" .show_item_id_mnum ").removeClass('none');
                    $(".modal_show_item_norms_"+id+" .show_item_id_mnum ").text(val);
                    var m = val * prs;
                }
                $(".modal_show_item_norms_"+id+" .money_toal").html(prs);
                $(".modal_show_item_norms_"+id+" .msg_show").addClass("none");
                $(".process ").removeClass('active');
                $.post("{{u('Goods/getVal')}}", { sellerId:"{{Input::get('id')}}",goodsId: pid, normsId: normsId, processId:0}, function(res){
                    if(res.code == 0){
                        val = parseInt(res.data);
                        if(val > 0){
                            $(".modal_show_item_norms_"+pid+" .subtract ").removeClass('none');
                            $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").removeClass('none');
                            $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").text(val);
                        }else{
                            $(".modal_show_item_norms_"+pid+" .subtract ").addClass('none');
                            $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").addClass('none');
                            $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").text(0);
                        }
                    }
                });
                return false;
            });
            $(document).on('click','.y-paytop .icon', function () {
                $(".modal").removeClass("modal-in").addClass("modal-out").remove();
                $(".modal-overlay").removeClass("modal-overlay-visible");
                $(" .y-ggpsize li").removeClass('active');
            });
        })
        $.showItemNorms = function(pid,id,price,salePrice){

            $(".msg_show"+pid).addClass('none');
            $(".modal_show_item_norms_"+pid +" .y-ggpsize li").removeClass('active');
            $(".show_item_id_"+id +"").addClass('active');
            var val  = $(".modal_show_item_norms_"+pid+" .show_item_id_"+id).attr('data-ns');
            var processId = 0;
            $('.goodsId_show'+pid).each(function(){
                if($(this).hasClass('active')){
                    processId = $(this).attr('data-process-id');
                    alert(processId);
                }
            });
            $.post("{{u('Goods/getVal')}}", { sellerId:"{{Input::get('id')}}",goodsId: pid, normsId: id, processId:processId}, function(res){
                if(res.code == 0){
                    val = parseInt(res.data);
                    $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-normsid',id);
                    $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-price',price);
                    $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-salePrice',salePrice);
                    var m = val * price;
                    if(salePrice > 0) {
                        //特价商品
                        $(".modal_show_item_norms_"+pid+" .money_toal").html(salePrice);
                        $(".modal_show_item_norms_"+pid+" .delPrice").html(price);
                    } else {
                        //正常商品
                        $(".modal_show_item_norms_"+pid+" .money_toal").html(price);
                    }

                    if(val > 0){
                        $(".modal_show_item_norms_"+pid+" .subtract ").removeClass('none');
                        $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").removeClass('none');
                        $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").text(val);
                    }else{
                        $(".modal_show_item_norms_"+pid+" .subtract ").addClass('none');
                        $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").addClass('none');
                        $(".modal_show_item_norms_"+pid+" .show_item_id_mnum ").text(0);
                        if(salePrice > 0) {
                            //特价商品
                            $(".modal_show_item_norms_"+pid+" .money_toal").attr('data-norms-price',salePrice);
                            $(".modal_show_item_norms_"+pid+" .money_toal").html(salePrice);
                            $(".modal_show_item_norms_"+pid+" .delPrice").html(price);
                        } else {
                            //正常商品
                            price = salePrice ?  salePrice : price;
                            $(".modal_show_item_norms_"+pid+" .money_toal").html(price);
                            $(".modal_show_item_norms_"+pid+" .money_toal").attr('data-norms-price',price);
                        }
                    }
                }
            });
        }

        <?php
        echo "var cartgoods = ";
        echo json_encode((array)$cartgoods);
        echo ";"
        ?>
// 计算合计
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
        function CalculationTotal(goodsid, normsId, num, price, processingprice)
        {
//            alert(goodsid);
//            alert(normsId);
//            alert(num);
//            alert(price);
//            alert(processingprice);
            if (typeof(cartgoods[goodsid]) == "undefined")
            {
                cartgoods[goodsid] = new Object();
            }

            if (normsId == "0") normsId = "null";
            if(isNaN(processingprice)) processingprice = parseFloat(0);
            cartgoods[goodsid][normsId] = { num: num, price: price, processingprice:processingprice};

            var totalAmount = 0;

            var totalPrice = 0.0;

            for(var goods in cartgoods)
            {
                for (var item in cartgoods[goods])
                {
                    totalAmount += parseInt(cartgoods[goods][item].num);

                    totalPrice += cartgoods[goods][item].num * cartgoods[goods][item].price;
//                    var money = cartgoods[goods][item].num * cartgoods[goods][item].processingprice;
//                    alert(money);
                    totalPrice += money;
                }
            }

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
        // 处理返回值
        function HandleResult(res) {
            if (res.code < 0) {
                // $.toast("请登录", function(){
                // setTimeout(function () { $.router.load("{{u('User/login')}}", true); }, 2000);
                // });
                alert('您未登录，无法加入购物车');
                window.location.href = "{{u('User/login')}}";
            }
            else if (res.code > 0)
            {
                $.toast(res.msg);
            }

            return false;
        }

        // 减少数量
        $(document).on("touchend", ".subtract", function () {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) - 1;
            $(".msg_show"+sender.data("goodsid")).addClass('none');

            if (value <= 0)
            {
                value = 0;

                $(this).siblings(".add").siblings().addClass("none");
            }
            var processId = $("#goodsId_process_show_"+sender.data("goodsid")).attr('data-processid');
            if(!$('.goodsId_show'+sender.data("goodsid")).hasClass('active')){
                processId = 0;
            }
            $.post("{{u('Goods/saveCartTwo')}}", { sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}",goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), processId:processId, num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
//                    var pr = 0;
                    sender.html(value);
//                    if(sender.data("saleprice") <= 0){
//                        pr = sender.data("price");
//                    }else{
//                        pr = sender.data("saleprice");
//                    }
//                    alert(res.data('processingPrice'));
//                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr), parseFloat(sender.data("processingprice")));
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    if(value == 0){
                        $("#dsyId-"+sender.data("goodsid")).hide();
                        $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(0);
                        $(".show_item_norms_"+sender.data("goodsid") +" .subtract").addClass("none");
                        $(".show_item_id_"+sender.data("normsid")).attr("data-ns",0);
                        $("#goodsId_process_show_"+sender.data("goodsid")).addClass('none');
                    }else{
                        tianchong(res.data['list']);
//                        tianchong(res.data['list'][0]['goods']);
                        $(".show_item_norms_"+sender.data("goodsid") +" .subtract").addClass("none");
                    }
                }
                HandleResult(res);
            } );
        });
        // 添加数量
        $(document).on("touchend", ".add", function () {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");
            var processId = $("#goodsId_process_show_"+sender.data("goodsid")).attr('data-processid');
            if(!$('.goodsId_show'+sender.data("goodsid")).hasClass('active')){
                processId = 0;
            }
            var value = parseInt(sender.html()) + 1;
            $.post("{{u('Goods/saveCartTwo')}}", {sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}", goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), processId:processId, num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
//                    var pr = 0;
                    sender.html(value);
//                    if(sender.data("saleprice") <= 0){
//                        pr = sender.data("price");
//                    }else{
//                        pr = sender.data("saleprice");
//                    }
////                    alert(pr);
//                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr), parseFloat(sender.data("processingprice")));
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(value);
                    var m = value * sender.data("price");
                    thisVal.siblings().removeClass("none");

                    $(".show_item_id_"+sender.data("normsid")).attr("data-ns",value);
                    tianchong(res.data['list']);
                }else{
                    $(".msg_show"+sender.data("goodsid")).removeClass('none');
                }
                HandleResult(res);
            } );

        });

        function tianchong(datas){
            var str = '';
            for(var j in datas){
                //[0]['goods']
                if("{{$option['id']}}" == datas[j]['id']){
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
//                str +=  '<p style="font-size: 10px;margin-top: -3px;">(加工:'+data[i]["processingName"]+' 价格:￥';
                        //' '+data[i]["processingPrice"]+')</p>
                        str += '</div><div class="item-after"><span class="c-red fl">￥<span  id="cartTotalPrice_DsyPrice_';
                        str += data[i]["goodsId"]+' class="cartTotalPrice_DsyPrice_'+data[i]["normsId"]+'">';
                        if(parseInt(data[i]['sale']) == parseInt(10)){
//                    var price = parseInt(data[i]['num']) * parseFloat(data[i]['price']);
                            var price = parseFloat(data[i]['price']) + parseFloat(data[i]['processingPrice']);
                            str += price.toFixed(2);
                        }else{
                            var price = parseFloat(parseFloat(data[i]['price'])  * parseFloat(data[i]['sale']) /10) + parseFloat(data[i]['processingPrice']);
                            str += price.toFixed(2);
                        }
                        str += '</span> </span> <div class="x-num fr ml5"> <i class="icon iconfont c-gray subtract1 fl">&#xe622;</i>';
                        str += '<span class="val tc pl0 fl cartTotalPrice_DsyNum_'+data[i]["normsId"]+'" data-newold="true" data-goodsid="'+data[i]["goodsId"];
                        str += '" data-normsid="'+data[i]["normsId"]+' " data-price="'+data[i]["price"]+'" data-saleprice="'+price+'" data-servicetime="'+data[i]["serviceTime"];
                        str += '" id="cartTotalPrice_DsyNum_'+data[i]["goodsId"]+'-'+parseInt(data[i]["normsId"])+'-'+processId+'" data-processid="'+processId+'">'+data[i]["num"]+'</span>';
                        str +='<i class="icon iconfont c-red fl add1">&#xe61f;</i></div> </div> </div> </div> </li>';
                    }
                }
            }
            if(str != ''){
                $("#ul_li_ul").html(str);
            }
        }
        // 减少数量
        $(document).on("touchend", ".subtract1", function () {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) - 1;
            $(".msg_show"+sender.data("goodsid")).addClass('none');

            if (value <= 0)
            {
                value = 0;

                $(this).siblings(".add").siblings().addClass("none");
            }
//            var processId = $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")).attr('data-processid');
            $.post("{{u('Goods/saveCartTwo')}}", { sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}",goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), processId:sender.data("processid"), num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
//                    var pr = 0;
                    sender.html(value);
//                    if(sender.data("saleprice") <= 0){
//                        pr = sender.data("price");
//                    }else{
//                        pr = sender.data("saleprice");
//                    }
//                    alert(res.data('processingPrice'));
//                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr), parseFloat(sender.data("processingprice")));
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    if(value == 0){
                        $("#dsyId-"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).hide();
                        $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(0);
                        $(".show_item_norms_"+sender.data("goodsid") +" .subtract").addClass("none");
                        $(".show_item_id_"+sender.data("normsid")).attr("data-ns",0);
                        $("#goodsId_process_show_"+sender.data("goodsid")).addClass('none');
                    }else{
//                        $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")).text(value);
                        $(".show_item_norms_"+sender.data("goodsid") +" .subtract").addClass("none");
                        $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).text(value);

                    }
                }
                HandleResult(res);
            } );
        });
        // 添加数量
        $(document).on("touchend", ".add1", function () {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) + 1;
            $.post("{{u('Goods/saveCartTwo')}}", {sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}", goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), processId:sender.data("processid"), num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
//                    var pr = 0;
                    sender.html(value);
//                    if(sender.data("saleprice") <= 0){
//                        pr = sender.data("price");
//                    }else{
//                        pr = sender.data("saleprice");
//                    }
////                    alert(pr);
//                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr), parseFloat(sender.data("processingprice")));
                    CalculationTotal1(parseFloat(res.data['totalPrice']),parseFloat(res.data['totalAmount']));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(value);
                    var m = value * sender.data("price");
                    thisVal.siblings().removeClass("none");
                    $(".show_item_id_"+sender.data("normsid")).attr("data-ns",value);
                    $("#cartTotalPrice_DsyNum_"+sender.data("goodsid")+'-'+parseInt(sender.data("normsid"))+'-'+parseInt(sender.data("processid"))).text(value);
                }else{
                    $(".msg_show"+sender.data("goodsid")).removeClass('none');
                }
                HandleResult(res);
            } );

        });

        $(document).on("touchend",".x-goodsb",function(){
            if ($(this).hasClass("active"))
            {
                $(this).removeClass("active");
                $(this).parent().siblings(".showgoods").addClass("none");
                $(this).find(".up").removeClass("none");
                $(this).find(".down").addClass("none");
            }
            else
            {
                $(this).addClass("active");
                $(this).parent().siblings(".showgoods").removeClass("none");
                $(this).find(".up").addClass("none");
                $(this).find(".down").removeClass("none");
            }
            $(this).parents("li").addClass("none");
        });

        $(document).on("touchend",".collect_opration .collect",function(){
            var obj = new Object();
            var collect = $(this);
            obj.id = "{{$seller['id']}}";
            obj.type = 2;
            if(collect.hasClass("on")){
                $.post("{{u('UserCenter/delcollect')}}",obj,function(result){
                    if(result.code == 0){
                        collect.removeClass("on");
                        collect.addClass('c-white');
                        collect.html('&#xe653;');
                        $.toast(result.msg,function(){
                            collect.html('&#xe653;');
                        });

                    } else if(result.code == 99996){
                        $.router.load("{{u('User/login')}}", true);
                    } else {
                        $.toast(result.msg);
                    }
                },'json');
            }else{
                $.post("{{u('UserCenter/addcollect')}}",obj,function(result){
                    if(result.code == 0){
                        collect.addClass("on");
                        collect.css('color','red');
                        collect.removeClass('c-white');
                        collect.html('&#xe654;');
                        $.toast(result.msg,function(){
                            collect.html('&#xe654;');
                        });
                    } else if(result.code == 99996){
                        $.router.load("{{u('User/login')}}", true);
                    } else {
                        $.toast(result.msg);
                    }
                },'json');
            }
        });
    </script>
@stop