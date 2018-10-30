@extends('wap.community._layouts.base')

@section('css')
    <style>
        .swiper-container-horizontal > .swiper-pagination{bottom: 15px;}
    </style>
    <style type="text/css">
        .y-backtop{
            position: fixed;right: .5rem;bottom: 12%;width: 35px;height: 35px;
            background: url('{{asset('/images/ico/top.png')}}') no-repeat center center #fff;
            background-size: 70%;display: block;z-index: 111;border-radius: 100%;
            border: 1px solid #a9a9a9;
        }
        /*头部透明*/
        .y-toptransparent.bar.bar-nav{background: none;}
        .y-toptransparent.bar.bar-nav:after{height: 0;}
        .y-toptransparent.bar.bar-nav~.content{top: 0;}
        .y-toptransparent.bar.bar-nav .button-nav{line-height: 2.2rem;padding-top: 0;}
        .y-toptransparent.bar.bar-nav .title{background: rgba(225,225,225,.6);border-radius: .75rem;line-height: 1.5rem;top: .3rem;padding-left: .75rem;}
        /*时间样式*/
        .time{
            width:100%;
            text-align:center;
            background-color:#3A3A3A;
            color:#fff;
        }
        .flex{
            display:flex;
        }
        .align-item{
            align-items:flex-end;
        }
        .justify-content{
            justify-content: space-between;
        }
        .width{
            width:25%;
            padding:10px 0;
        }
        .width50{
            width:50%;
        }
        .timestart{
            background-color:#FF2D4B;
            color:orange;
        }
        .food{
            width:100%;
            background-color:#fff;
        }
        .img,.img>img{
            width:80px;
            height:80px;
            border-radius:5px;
            vertical-align:top;
            position:relative;
            top:2px;
            margin-right:5px;
            /*border:1px solid #ccc;*/
        }
        .pd{
            padding:10px;
        }
        .border-bottom{
            border-bottom: 1px solid #f3f3f3;
        }
        .btnred{
            padding:5px 8px;
            background-color:#F82243;
            color:#fff;
            border-radius:3px;
        }
        .font12{
            font-size:.6rem;
            color:#999;
        }
        .font14{
            font-size:1rem;
        }
        .orange{
            color:#fca300;
        }
        .colorred{
            color:#F82243;
        }
        .borderred{
            border:1px solid #f82243;
            border-radius:2px;
            color:#f82243;
            font-weight:normal;
            margin-right:5px;
            padding:2px;
        }
        .calbtn{
            width:30px;
            height:30px;
            line-height:30px;
            text-align:center;
            background-color:#F5F5F5;
            margin-right:1px;
        }
        .goodsdetail{
            margin-top:5px;
        }
        .goodsdetail>dl>dt{
            padding:0 8px;
        }
        .flex-wrap{
            flex-wrap: wrap;
        }
        .lh{
            line-height:1.5rem;
        }
        .titleborder-left,.titleborder-right{
            border-bottom-left-radius: 4px;
            border-top-left-radius: 4px;
            text-align:center;
            padding:5px 0;
        }
        .titleborder-right{
            border-bottom-right-radius: 4px;
            border-top-right-radius: 4px;
        }
        .curbg{
            background-color:#FF2D4B;
            color:#fff;
        }
        .bgff{
            background-color:#fff;
        }
        /*a:hover{
            color:#fff;
        }*/
    </style>
@stop
@section('show_top')
    <header class="bar bar-nav" style="background: rgb(253,44,73);">
        <a class="button button-link button-nav pull-left back" href="{{ u('Activity/seckill') }}" data-transition='slide-out' style="color: #ffffff;">
            <span class="icon iconfont">&#xe600;</span>
        </a>
        <h1 class="title f16" style="color: #ffffff;">商品详情</h1>
    </header>
@stop
@section('content')
    <script type="text/javascript">
        //BACK_URL = "{!! u('Goods/index',['id'=>$seller['id'],'type'=>1]) !!}";
        BACK_URL = "{!! Request::server('HTTP_REFERER') !!}";
    </script>
    @include('wap.community._layouts.base_cart_item')
            <!--商品详情页 start-->

    <div class="content" class="swiper-container my-swiper" data-space-between='0'>
        @if($data)
            @foreach($data as $k => $v)
                @foreach($v['goodsList'] as $kk => $vv)
                    <div class="x-bigpic pr">
                        <div id="indexAdvSwiper" class="swiper-container my-swiper" data-space-between='0'>
                            <div class="swiper-wrapper">
                                @foreach($vv['images'] as $kkk => $vvv)
                                    <div class="swiper-slide pageloading">
                                        <!--_src="{{ formatImage($vv['image'],640) }}"-->
                                        <img  src="{{ $vvv }}" style="width: 100%;"/>
                                    </div>
                                @endforeach
                            </div>
                            <div class="swiper-pagination swiper-pagination-adv"></div>
                        </div>
                    </div>
                    <div class="flex align-item" style="width:100%;background-color:#fff;">
                        <!--时间活动  start-->
                        <div class="time flex justify-content" id="Countime">
                            <div class="timestart" style="width:75%;text-align:left;padding-left:10px;color:#fff;">
                                <p style="color:transparent;">dd</p>
                                <p>
                                    <b class="font14">¥<span style="font-size:2rem;font-weight:normal;">@if($vv['salePrice'] > 0) {{ $vv['salePrice'] }} @else {{ $vv['price'] }} @endif</span></b>
                                    <s class="font12">¥{{ $vv['price'] }}</s>
                                </p>
                            </div>
                            <div class="width box" style="color:orange;background: rgb(62,56,60);width: 25%;" time="{{ $v['startTime'] }}" maxtime="{{ $v['maxTime'] }} ">

                            </div>
                        </div>
                        <!--时间活动 end-->
                    </div>
                    <!--banner end-->
                    <div style="margin-top: 10px;">
                        <div class="flex justify-content pd" style="width:100%;background-color:#fff;">
                            <div>
                                <h4 style="white-space: nowrap;text-overflow:ellipsis; overflow:hidden;">{{ $vv['name'] }}</h4>
                                <p class="font12">
                                    <span>剩{{ ($vv['stock']) }}份</span>
                                    <b class="borderred">已售出{{ $vv['useStock'] }}份</b>
                                </p>
                            </div>
                            <div class="flex align-item" style="justify-content: flex-end;">
                                <button class="calbtn reduce" data-goods-id="{{ $vv['id'] }}">-</button><span class="calbtn" id="number">@if($cart['goodsAmount'] > 0) {{ $cart['goodsAmount'] }} @else 1 @endif</span><button class="calbtn add" data-goods-id="{{ $vv['id'] }}">+</button>
                            </div>
                        </div>
                    </div>

                    <div style="margin-top:5px;background-color:#fff;padding:10px;">
                        <div class="item-inner pr10">
                            <div class="item-title">
                                <a href="{{ u('Seller/detail',['id'=>$vv['seller']['id']]) }}">
                                    <i class="icon iconfont c-gray vat mr5">&#xe632;</i>
                                    <span style="white-space: nowrap;text-overflow:ellipsis; overflow:hidden;">{{ $vv['seller']['name'] }}</span>
                                    <i class="icon iconfont c-gray f13 mr-2 flex" style="float:right;">&#xe602;</i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!--商品详情标题 start-->
                    <div class="flex justify-content pd">
                        <p style="border-top:1px solid #ddd;width:40%;height:1px;margin-top:.5rem;"></p>
                        <p style="width:20%;text-align:center;">商品详情</p>
                        <p style="border-top:1px solid #ddd;width:40%;height:1px;margin-top:.5rem;"></p>
                    </div>
                    <!--商品详情描述 end-->
                    <div>
                        <div class="pd" style="width:100%;background-color:#fff;">
                            <p>{!! $vv['brief'] !!}</p>
                        </div>
                    </div>
                @endforeach
            @endforeach
        @else
    商品出问题了
    </div>
    @endif
    <!--商品详情页 end-->
@stop

@section($js)
    <script type="text/javascript">
        $("#indexAdvSwiper").swiper({"pagination":".swiper-pagination-adv", "autoplay":2500});
        if(parseInt("{{ $cart['totalAmount'] }}") > parseInt(0)){
            $("#cartTotalAmount").html("{{ $cart['totalAmount'] }}");
        }
        if(parseFloat("{{ $cart['totalPrice'] }}") > parseFloat(0)){
            $("#cartTotalPrice").html("{{ $cart['totalPrice'] }}");
        }
        //倒计时
        window.onload=function(){
            show();
            function show(){
                var boxes=document.getElementsByClassName('box');
                for(var i=0;i<boxes.length;i++){
                    var date=boxes[i].getAttribute('time');
                    var nowTime=new Date();
                    nowTime=nowTime.getTime();
                    var startTime=new Date(date);
                    var sh=startTime.getHours();
                    var sm=startTime.getMinutes();
                    startTime=startTime.getTime();
                    var maxTime=parseInt(boxes[i].getAttribute('maxtime'));
                    var leaveTime=startTime+maxTime-nowTime;
                    if(startTime-nowTime<=0&&startTime+maxTime-nowTime>=0){
                        var d=parseInt(leaveTime/(24*60*60));
                        var h=parseInt(leaveTime/1000/(60*60));
                        var m=parseInt(leaveTime/1000%3600/60);
                        var s=parseInt(leaveTime/1000%3600%60);
                        m=cleartime(m);
                        h=cleartime(h);
                        s=cleartime(s);
                        boxes[i].className="width box timestart";
                        boxes[i].innerHTML="<p>距离结束</p>"+"<p>"+h+":"+m+":"+s+"</p>";
                        maxTime-=1000;
                    }

                    if (startTime+maxTime-nowTime<=0) {    //判断倒计时是否结束
                        sh=cleartime(sh);
                        sm=cleartime(sm);
                        boxes[i].className="width box";
                        boxes[i].innerHTML="<p>"+sh+":"+sm+"</p>"+"<p>已结束</p>";
                    }
                }
                setTimeout(show,1000);
            }
            function cleartime(j){
                if (j<10) {
                    j="0"+j;
                }
                return j;
            }
            $(".choose_complete").html('立即购买');
        }
        $(".reduce").bind('click',function(){
            var number = parseInt($("#number").html());
            number = number - 1;
            if(number < 1){
                $.alert("数量不能小于1！");
            }else{
                $("#number").html(number);
            }
        });
        $(".add").bind('click',function(){
            var number = parseInt($("#number").html());
            number = number + 1;
            var goodsId = $(this).attr('data-goods-id');
            $.post("{{u('Activity/checkGoodStock')}}", {goodsId:goodsId}, function(res){
                if(res.code < 0){
                    $.alert('请先登录');
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                if(parseInt(res.stock) < number){
                    $.alert("商家库存不足！");
                    return ;
                }
                if(parseInt(res.buyLimit) < number){
                    $.alert("超过购买限制！");
                    return ;
                }
                $("#number").html(number);
            });
        });
        $(".y-addshoppingcart").bind('click',function(){
            saveCart(false);
        });
        $(".choose_complete").bind('click',function(){
            saveCart(true);
        });
        function saveCart(type){
            if(type){
                $(".choose_complete").unbind('click');
            }else{
                $(".y-addshoppingcart").unbind('click');
            }
            var goodsId = $(".reduce").attr('data-goods-id');
            var value = $("#number").html();
            $.post("{{u('Goods/saveCartOne')}}", { goodsId: goodsId, normsId: 0, processId:0, num: value, serviceTime: 0 }, function(res){
                if(res.code < 0){
                    $.alert('请先登录');
                    $.router.load("{{u('User/login')}}", true);
                    return;
                }
                if(res.code == 0) {
                    $("#cartTotalAmount").html(res.data.totalAmount);
                    $("#cartTotalPrice").html(res.data.totalPrice);
                    if(type){
                        $(".choose_complete").bind('click',function(){
                            saveCart(true);
                        });
                        $.router.load("{{u('GoodsCart/index')}}", true);
                    }else{
                        $(".y-addshoppingcart").bind('click',function(){
                            saveCart(false);
                        });
//                        $(".y-addshoppingcart").add("onClick");
                        $.toast('添加成功');
                    }
                }else{
                    $("#cartTotalAmount").html(res.data.totalAmount);
                    $("#cartTotalPrice").html(res.data.totalPrice);
                    $.toast(res.msg);
                    if(type){
                        $(".choose_complete").bind('click',function(){
                            saveCart(true);
                        });
                    }else{
                        $(".y-addshoppingcart").bind('click',function(){
                            saveCart(false);
                        });
                    }
                }
            },'json' );
        }
    </script>
@stop