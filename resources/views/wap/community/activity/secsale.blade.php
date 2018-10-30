@extends('wap.community._layouts.base')
@section('show_top')
    <header class="bar bar-nav" style="background: rgb(253,44,73);">
        <span class="button button-link button-nav pull-left back" id="url_back" onclick="jumpUrl();" data-transition='slide-out' style="color: #ffffff;">
            <span class="icon iconfont">&#xe600;</span>
        </span>
        <h1 class="title f16" style="color: #ffffff;">促销商品</h1>
    </header>
@stop

@section($css)
    <style type="text/css">
        /*头部透明*/
        .y-toptransparent.bar.bar-nav~.content{top: 0;}
        .y-toptransparent.bar.bar-nav .button-nav{line-height: 2.2rem;padding-top: 0;}
        .y-toptransparent.bar.bar-nav .title{background: rgba(225,225,225,.6);border-radius: .75rem;line-height: 1.5rem;top: .3rem;padding-left: .75rem;}
        /*时间样式*/
        .flex{
            display:flex;
        }
        .justify-content{
            justify-content: space-between;
        }
        .width50{
            width:50%;
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
        .goodsdetail{
            margin-top:5px;
        }
        .goodsdetail>dl>dt{
            padding:0 8px;
        }
        .flex-wrap{
            flex-wrap: wrap;
        }
    </style>
    @stop

    @section('content')

    @include('wap.community._layouts.bottom')
            <!--促销商品页 start-->
    @if($data)
        <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:block;">
            @foreach($data as $k => $v)
                    <!--banner start-->
                <div>
                    <img src="{{ $v['image'] }}" style="width:100%;height: 150px;"/>
                </div>
                <!--banner end-->
                <div class="flex justify-content flex-wrap" >
                    @foreach($v['goodsList'] as $kk => $vv)
                            <!--一个div代表一个商品 start-->
                    <div class="goodsdetail" style="width:100%;background: #fff;">
                        <div style="width:25%;display: inline-block;position: relative;">
                            <img src="{{ $vv['image'] }}" style="width:100%;height: 100%;vertical-align: middle;height: 5.5rem;"/>
                            @if($v['icon'])
                            <img src="{{ $v['icon'] }}" style="position: absolute;width: 2rem;height: 2rem;top:0;" />
                            @endif
                        </div>
                        <div style="width: 50%;display: inline-block;height: 100%;vertical-align: middle;margin-left: .2rem;padding: .4rem 0;">
                            <a href="{{ u('Seller/detail',['id'=>$vv['seller']['id']]) }}">
                                <i class="icon iconfont c-red vat mr5">&#xe632;</i>
                                <span class="font12 orange">{{ $vv['seller']['name'] }}</span>
                            </a>
                            <a href="#" style="margin-top: .2rem;display: block;">
                                <p style="font-size: .9rem;color:#000;">{{ $vv['name'] }}</p>
                                <p style="font-size: .5rem;color:#999;">
                                    ¥@if($vv['salePrice'] > 0) {{ $vv['salePrice'] }} @else {{ $vv['price'] }} @endif
                                    /{{ $vv['goodsUnit'] }}({{ $vv['weight'] }}kg)
                                </p>
                                <p style="font-size: .9rem;">
                                    <span style="color:#fff;background: #FE514C;font-size: .7rem;padding: .1rem;border-radius: .2rem;">降</span>
                                    <b class="colorred">¥<span class="font14" style="letter-spacing: -0.1rem;">@if($vv['salePrice'] > 0) {{ $vv['salePrice'] }} @else {{ $vv['price'] }} @endif</span></b>
                                    <span style="font-size: .7rem;color:#999;">/{{ $vv['goodsUnit'] }}</span>
                                    <s class="font12">¥{{ $vv['price'] }}</s>
                                </p>
                                {{--<dt class="flex justify-content">--}}
                                    {{--<p class="font12">{{ $vv['useStock'] }}人付款</p>--}}
                                    {{--<p class="font12">{{ $vv['totalShare'] }}人分享</p>--}}
                                {{--</dt>--}}
                            </a>
                        </div>
                        <div style="width: auto;display: inline-block;height: 100%;vertical-align: inherit;" >
                            @if($v['timeStatus'] >= 0)
                            <a href="{{ u('Goods/detail',['goodsId'=>$vv['id'],'type'=>'1']) }}" style="background: #FE514C;border-radius: 0.25rem;color:#fff;padding:.4rem .2rem;font-size:.6rem;" >+现在抢购</a>
                            @else
                            <a href="#" style="background: #ccc;border-radius: 0.25rem;color:#fff;padding:.4rem .2rem;font-size:.6rem;text-align: center;width: 3rem;display: block;" >已 结 束</a>
                            @endif
                        </div>
                    </div>

                    <!--一个div代表一个商品 end-->
                    @endforeach
                @endforeach
            </div>
        </div>
    @else
        <div style="margin-top: 30%;">
            <p style="text-align: center;">活动已结束~~~</p>
        </div>
    @endif
@stop

@section($js)
    <script type="text/tpl" id="x-tkmodaltext-udb">
        <div class="x-tkmodaltext">
            <p class="f18 x-tktitle mb5">{{$content}}</p>
            <p class="f12 tc">可用于抵扣在线支付金额!</p>
        </div>
    </script>
    <script type="text/tpl" id="x-tkmodaltitle-udb">
        <img src="{{ asset('wap/community/newclient/images/couponspic.png') }}" class="x-yhqtktop"><i class="icon iconfont c-white x-over">&#xe604;</i>
    </script>
                @include('wap.community._layouts.gps')
                <script type="text/javascript" src="{{ asset('wap/community/newclient/js/jweixin-1.0.0.js') }}"></script>


                <script type="text/javascript">
                    //可写js
                    //倒计时
                    function jumpUrl(){
                        window.location.href = "{{ $url }}";
                    }
                    window.onload=function(){
                        /*$("#url_back").bind('click',function(){
                            window.location.href = "{{ $url }}";
                        });*/
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
                                var maxTime=60*60*1000;
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
                    }
                </script>




                <!--<script type="text/javascript">
                    if("{{$content}}"){
                        $.alert($("#x-tkmodaltext-udb").html(),$("#x-tkmodaltitle-udb").html(),function () {
                            $.href("{{u("Coupon/index")}}");
                        });
                        $(".modal-button,.modal-button-bold").html("立即查看");
                    }
                    $(document).off('click','.x-over');
                    $(document).on('click','.x-over', function () {
                        $(".modal").removeClass("modal-in").addClass("modal-out").remove();
                        $(".modal-overlay").removeClass("modal-overlay-visible");
                    });
                    var BACK_URL = "{{u('Index/index')}}";
                    window.opendoorpage = true;//当前页可以开门

                    //微信分享配置文件
                    wx.config({
                        debug: false, // 调试模式
                        appId: "{{$weixin['appId']}}", // 公众号的唯一标识
                        timestamp: "{{$weixin['timestamp']}}", // 生成签名的时间戳
                        nonceStr: "{{$weixin['noncestr']}}", // 生成签名的随机串
                        signature: "{{$weixin['signature']}}",// 签名
                        jsApiList: ['checkJsApi','scanQRCode'] // 需要使用的JS接口列表
                    });
                    $.sao = function(){
                        if(window.App){
                            window.App.qr_code_scan();
                        }else{
                            wx.ready(function () {
                                wx.scanQRCode({
                                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                                    scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                                    success: function (res) {
                                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                                        if(result.indexOf('http')!=-1){
                                            $.href(result);
                                        }else{
                                            $.alert(result);
                                        }
                                    }
                                });
                            })
                        }
                    }
                    function js_qr_code_scan(val){
                        if(val.indexOf('http')!=-1){
                            App.open_type('{"url":"' + val + '", "open_url_type": "1"}');
                        }else{
                            $.alert(val);
                        }
                    }

                    //精确定位
                    $(function(){
                        if(window.App){
                            $("#saosao").css('display','block');
                        }
                        $("#indexAdvSwiper").swiper({"pagination":".swiper-pagination-adv", "autoplay":2500});
                        $("#indexNavSwiper").swiper({"pagination":".swiper-pagination-nav"});

                        //回到顶部
                        $(".content").scroll(function(){
                            var windowheight =  $(window).height();
                            var topheight = $(".content").scrollTop();
                            if (topheight > windowheight*2) {
                                $(".y-backtop").removeClass("none");
                            }else{
                                $(".y-backtop").addClass("none");
                            }
                        })

                        var qqcGeocoder = null;
                        var clientLatLng = null;
                        var now_mapPointStr = "{{$orderData['mapPointStr']}}";
                        @if(!empty($orderData['mapPointStr']))
                        @if($args['show_prog'] == 1)
                            $.gpsPosition(function(gpsLatLng, city, address, mapPointStr){
                            var ln = mapPointStr.split(",");
                            var strln = ln[0].substring(0,5)+","+ln[1].substring(0,6);
                            var ls = now_mapPointStr.split(",");
                            var strls = ls[0].substring(0,5)+","+ls[1].substring(0,6);
                            if(strln != strls){
                                $.toast('您的定位地址已经发生改变~');
                            }
                        })
                                @else
                                  var clientLatLngs = "{{ $orderData['mapPointStr'] }}".split(',');
                        clientLatLng = new qq.maps.LatLng(clientLatLngs[0], clientLatLngs[1]);
                        @endif
                    @else
                        $.gpsPosition(function(gpsLatLng, city, address, mapPointStr){
                            $.router.load("{{u('Index/index')}}?address="+address+"&mapPointStr="+mapPointStr+"&city="+city, true);
                        })
                        @endif

                        $(document).on("touchend",".data-content ul li",function(){
                            var id = parseInt($(this).data('id'));
                            if (id > 0)
                            {
                                $.router.load("{{u('Seller/detail')}}" + "?staffId=" + id, true);
                            }
                        });

                        $.computeDistanceBegin = function ()
                        {
                            if (clientLatLng == null) {
                                return;
                            }

                            $(".compute-distance").each(function ()
                            {
                                var mapPoint = new qq.maps.LatLng($(this).attr('data-map-point-x'), $(this).attr('data-map-point-y'));
                                $.computeDistanceBetween(this, mapPoint);
                                $(this).removeClass('compute-distance');
                            })
                        }

                        $.computeDistanceBetween = function (obj, mapPoint)
                        {
                            var distance = qq.maps.geometry.spherical.computeDistanceBetween(clientLatLng, mapPoint);
                            if (distance < 1000)
                            {
                                $(obj).html(Math.round(distance) + 'M');
                            } else
                            {
                                $(obj).html(Math.round(distance / 1000 * 100) / 100 + 'Km');
                            }
                        }

                        $.SwiperInit = function (box, item, url)
                        {
                            $(box).infinitescroll({
                                itemSelector: item,
                                debug: false,
                                dataType: 'html',
                                nextUrl: url
                            }, function (data)
                            {
                                $.computeDistanceBegin();
                            });
                        }

                        // $.computeDistanceBegin();

                        //重新定位
                        $.relocation = function(){
                            //异步Session清空
                            $.post("{{ u('Index/relocation') }}",function(){
                                $.router.load("{{ u('Index/index') }}", true);
                            })
                        }


                        //是否有展开箭头
                        $.lieach = function(){
                            $(".list-block ul li.each").each(function(){
                                var innerh = $(this).find(".y-mjyh li").length;
                                if (innerh >= 3) {
                                    $(this).find(".y-mjyh .y-i1").removeClass("none");
                                    $(this).find(".y-mjyh li").last().addClass("none");
                                }
                            })
                        }
                        $.lieach();

                        // 促销展开与收起
                        $(document).off('click','.y-mjyh');
                        $(document).on('click','.y-mjyh', function () {
                            if($(this).find("li").length <= 2){
                                return false;
                            }
                            if($(this).hasClass("active")){
                                $(this).removeClass("active");
                                $(this).find(".y-unfold").addClass("none").siblings("i.y-i1").removeClass("none");
                                $(this).find("li").last().addClass("none");
                            }else{
                                $(this).addClass("active");
                                // $(this).css("height",44);
                                $(this).find(".y-unfold").removeClass("none").siblings("i.y-i1").addClass("none");
                                $(this).find("li").last().removeClass("none");
                            }
                        });

                        //上拉
                        var groupLoading = false;
                        var groupPageIndex = 2;
                        var nopost = 0;
                        $(document).off('infinite', '.infinite-scroll-bottom');
                        $(document).on('infinite', '.infinite-scroll-bottom', function() {
                            if(nopost == 1){
                                return false;
                            }
                            // 如果正在加载，则退出
                            if (groupLoading) {
                                return false;
                            }
                            //隐藏加载完毕显示
                            $(".allEnd").addClass('none');

                            groupLoading = true;

                            $('.infinite-scroll-preloader').removeClass('none');
                            $.pullToRefreshDone('.pull-to-refresh-content');

                            var data = new Object;
                            data.page = groupPageIndex;
                            data.status = "{{ $args['status'] }}";

                            $.post("{{ u('Index/indexList') }}", data, function(result){
                                groupLoading = false;
                                $('.infinite-scroll-preloader').addClass('none');
                                result  = $.trim(result);
                                if (result != '') {
                                    groupPageIndex++;
                                    $('#wdddmain').append(result);
                                    $.computeDistanceBegin();
                                    $.refreshScroller();
                                }else{
                                    $(".allEnd").removeClass('none');
                                    nopost = 1;
                                }
                            });
                        });


                        //ajax加载商家或者商品列表
                        var ajaxData = {page:1, status:"{{ $args['status'] }}"};
                        var ajaxObj = $("#wdddmain");
                        var ajaxUrl = "{{ u('Index/indexList') }}";
                        $.ajaxListFun(ajaxObj, ajaxUrl, ajaxData, function(result){
                            $.computeDistanceBegin();
                        });

                    });


                    if(window.App && parseInt({{$loginUserId}})>0){
                        var result = getDoorKeys();
                        window.App.doorkeys(result.responseText);
                    }

                    //滑动时头部的显示
                    $(".content").scroll(function(){
                        var top=$(".content").scrollTop();
                        var opacity=top/100;
                        if (opacity>=0.7) {
                            $(".y-toptransparent").css("background","rgba(255,45,75,.7)");
                            $(".y-toptransparent .title").css("background","rgba(225,225,225,.8)");
                        }else{
                            $(".y-toptransparent").css("background","rgba(255,45,75,"+opacity+")");
                            $(".y-toptransparent .title").css("background","rgba(225,225,225,0.6)");
                        };
                    });
                </script>-->
@stop