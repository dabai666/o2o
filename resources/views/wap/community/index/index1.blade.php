@extends('wap.community._layouts.base')
@section('show_top')
    <header class="bar bar-nav y-zgsytop y-toptransparent">
        <a class="button button-link button-nav pull-left ml5" id="saosao" onclick="$.sao()" @if($weixinliu == 1) style="display: block" @else style="display: none" @endif external>
            <i class="icon iconfont">&#xe67c;</i>
        </a>
        <div class="title tl c-white" onclick="$.href('{{ u('Seller/search')}}')">
            <i class="icon iconfont f13">&#xe65e;</i>
            <input type="text" placeholder="搜索商品、店铺">
        </div>
        <a class="button button-link button-nav pull-right mr5" external onclick="$.href('{{ u('UserCenter/systemmessage')}}')">
            <i class="icon iconfont">&#xe660;</i>
            @if(((int)$counts['systemCount'] > 0 || (int)$counts['newMsgCount']))
                <span class="y-redc" style="z-index: 999;border: 1px solid #fff;width: 0.5em;height: 0.5em"></span>
            @endif
        </a>
    </header>
@stop

@section($css)
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
        /*优惠券*/
        .discount{
            overflow: hidden;
            margin:.5rem 0;
        }
        .discount>li{
            width:50%;
            float:left;
            background-color:#fff;
            border-bottom:1px solid #f3f3f3;
            border-right:1px solid #f3f3f3;
        }
        .discount>li img{
			display:block;
			width:100%;
        }
        .discount>li>div>p{
            font-size:1rem;
        }
        .discount>li>div>span{
            color:#999;
            font-size:0.65rem;
        }
        .flex{
            display: flex;
            display:-webkit-flex;
        }
        .justify-content{
            justify-content: space-between;
        }
        .align-item{
            align-items: center;
        }
        .colorange{
            color:#FE8602;
        }
        .ad{
            text-align:center;
            background-color: #fff;
        }
        .ad>dt>dl{
            padding:0.3rem 0.5rem;
            border-right:1px solid #f3f3f3;

        }
        .ad>dt>dl img{
            width:3rem;
            height:3rem;
        }
    </style>
@stop

@section('content')

    @include('wap.community._layouts.bottom')

    @if($cityIsService == 0)
        <div class="x-null pa w100 tc">
            <i class="icon iconfont">&#xe645;</i>
            <p class="f12 c-gray mt10">当前城市未开通服务</p>
            <a class="f14 c-white x-btn db pageloading" href="{{ u('Index/addressmap')}}">切换地址</a>
        </div>
    @else
        <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="">
            <div id="indexAdvSwiper" class="swiper-container my-swiper indexAdvSwiper" data-space-between='0' >
                <div class="swiper-wrapper">
                    @foreach($data['banner'] as $key => $value)
                        <div class="swiper-slide pageloading" onclick="$.href('{{ $value['url'] }}')">
                            <img _src="{{ formatImage($value['image'],640) }}" src="{{ formatImage($value['image'],640) }}" />
                        </div>
                    @endforeach
                </div>
                <div class="swiper-pagination swiper-pagination-adv"></div>
            </div>
            <div class="tc c-bgfff y-xsyaddr">
                <div class="y-xsyaddrico"><i class="icon iconfont c-red">&#xe650;</i></div>

                <div class="f12 y-xsyaddrtext"  onclick="$.href('{{ u('Index/addressmap')}}')" >
                    @if($orderData['address'])
                        <span>{{$orderData['address']}}</span>
                    @else
                        <span id="locationName">定位中请稍候</span>
                    @endif
                    <i class="icon iconfont ml5 f14" >&#xe601;</i>
                </div>
            </div>

            <div id="indexNavSwiper" class="swiper-container y-swiper" data-space-between='0'  style="background:#fff;">
                <div class="swiper-wrapper">
                    @for($i = 0; $i < (ceil(count($menu) / 8)); $i++)
                        <div class="swiper-slide">
                            <ul class="y-nav clearfix">
                                @foreach(array_slice($menu,($i * 8),8) as  $v)
                                    <?php
                                    if (!preg_match("/^(http|https):/", $v['url'])){
                                        $v['url'] = 'https://'.$v['url'];
                                    }
                                    ?>
                                    <li><a href="{{ $v['url'] }}" class="db" external><img src="{{ $v['menuIcon'] }}"><p class="f13">{{ $v['name'] }}</p></a></li>
                                @endforeach
                            </ul>
                        </div>
                    @endfor
                </div>
                <div class="swiper-pagination swiper-pagination-nav_index"></div>
            </div>
            <!-- 优惠券 start -->
            @if($module)
                <ul class="discount">
                    @foreach($module as $k => $v)
						<li style="display: flex;display:-webkit-flex;justify-content: space-between;align-items: center;" class="flex justify-content align-item" data-type="{{ $v['type'] }}" data-url="@if(!strstr($v['url'],'http://') || !strstr($v['url'],'https://')) {{ 'https://'.$v['url'] }} @else {!! $v['url'] !!} @endif ">
                            <a href="{{ $v['url'] }}"><img src="{{ $v['image'] }}"></a>
						</li>
                    @endforeach
                </ul>
			@endif
			<!-- 品牌广告位 start -->
                @if($brandAdv)
                    <div class="brandAdv" style="height:50px;line-height:50px;text-align:center;background:#fff;margin-bottom:2px;">
						<p><i style="color:#ccc;">——</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#168ad3;font-weight:bold;font-size:.9rem;">品牌直达</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i style="color:#ccc;">——</i></p>
					</div>
                    <div id="indexBrandSwiper" class="swiper-container y-swiper" data-space-between='0'  style="background:#fff;">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" style="background:#fff;">
                                <ul class="clearfix" style="background:#eee;display: -webkit-box;display: -moz-box;display: -moz-flex;display: -ms-flexbox;">
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[0]['url'] }}"  external><img src="{{ $brandAdv[0]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[1]['url'] }}"  external><img src="{{ $brandAdv[1]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;"><a href="{{ $brandAdv[2]['url'] }}"  external><img src="{{ $brandAdv[2]['img'] }}" style="width: 100%"></a></li>
                                    
                                </ul>
								<ul class="clearfix" style="padding-top:2px;background:#eee;display: -webkit-box;display: -moz-box;display: -moz-flex;display: -ms-flexbox;">
									<li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[3]['url'] }}"  external><img src="{{ $brandAdv[3]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[4]['url'] }}"  external><img src="{{ $brandAdv[4]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;"><a href="{{ $brandAdv[5]['url'] }}"  external><img src="{{ $brandAdv[5]['img'] }}" style="width: 100%"></a></li>
								</ul>
                            </div>
                            <div class="swiper-slide" style="background:#fff;">
                                <ul class="clearfix" style="background:#eee;display: -webkit-box;display: -moz-box;display: -moz-flex;display: -ms-flexbox;">
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[6]['url'] }}"  external><img src="{{ $brandAdv[6]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[7]['url'] }}"  external><img src="{{ $brandAdv[7]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;"><a href="{{ $brandAdv[8]['url'] }}"  external><img src="{{ $brandAdv[8]['img'] }}" style="width: 100%"></a></li>
                                </ul>
								<ul class="clearfix" style="padding-top:2px;background:#eee;display: -webkit-box;display: -moz-box;display: -moz-flex;display: -ms-flexbox;">
									<li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[9]['url'] }}"  external><img src="{{ $brandAdv[9]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;margin-right:2px;"><a href="{{ $brandAdv[10]['url'] }}"  external><img src="{{ $brandAdv[10]['img'] }}" style="width: 100%"></a></li>
                                    <li style="width: 33.3%;padding: 5px 10px;background:#fff;"><a href="{{ $brandAdv[11]['url'] }}"  external><img src="{{ $brandAdv[11]['img'] }}" style="width: 100%"></a></li>
								</ul>
                            </div>
                        </div>
                        <div class="swiper-pagination swiper-pagination-nav_brand"></div>
                    </div>
                    @endif
					<!-- 品牌广告位 end -->
                    @if(count($data['notice']) > 0)
						<div class="brandAdv" style="height:50px;line-height:50px;text-align:center;background:#fff;margin:.3rem 0 .1rem 0;">
							<p><i style="color:#ccc;">——</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#ff0d00;font-weight:bold;font-size:.9rem;">新品上市</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i style="color:#ccc;">——</i></p>
						</div>
						<div id="indexGoodsAdvSwiper" style="padding:0.5rem 0;background:#fff;overflow:hidden;">
							<div class="swiper-wrapper">
								@foreach($data['notice'] as $k=>$value)
								<div class="swiper-slide" style="margin-left:10px;">
									<a href="{{$value['url']}}" class="br pageloading"><img src="{{ $value['icon'] }}"></a>
								</div>
								@endforeach
								<div class="swiper-slide" style="margin-left:10px;"></div>
							</div>
							<div class="swiper-pagination swiper-pagination-nav_brand"></div>
						</div>
                    @endif
                    <!-- 优惠券 end -->
                    @if($adv)
                        @foreach($adv as $k => $v)
                            <div style="background: #fff;">
                                <div class="ad">
                                    <a href=" {{ $v['url1'] }}" external><dd><img src="{{ $v['image1'] }}" style="width:100%;"></dd></a>
                                </div>
                                <div style="display: -webkit-box;display: -moz-box;display: -webkit-flex;display: -moz-flex;display: -ms-flexbox;display: flex;width: 100%;">
                                    <dl style="width: 33%;border-right:1px solid #f3f3f3;padding:0 .5rem .5rem .5rem;">
                                        <a href=" {{ $v['url2'] }}" external>
											<p style="margin-bottom:-25px;">
												<img src="{{ $v['image2'] }}" style="width:100%;border:1px solid #ccc">
												@if($v['sign2'])<span style="position:relative;bottom:28px;border:2px solid #da647c;background:#fff;color:#da647c;font-size:.5rem;padding:2px 2px 0;">{!! $v['sign2'] !!}</span>@endif
											</p>
											<dt style="height:2rem;overflow:hidden;">@if($v['mark2'])<span style="border:1px solid #ccc;border-radius:5px;font-size:.4rem;padding:0.1rem;">{!! $v['mark2'] !!}</span>@endif <strong style="font-size:.6rem;">{{ $v['title2'] }}</strong></dt>
											<dt>{!!  $v['instruction2'] !!}</dt>
											<dt>{!!  $v['remarks2'] !!}</dt>
                                        </a>
                                    </dl>
                                    <dl style="width: 33%;border-right:1px solid #f3f3f3;padding:0 .5rem .5rem .5rem;">
                                        <a href=" {{ $v['url3'] }}" external>
											<p style="margin-bottom:-25px;">
												<img src="{{ $v['image3'] }}" style="width:100%;border:1px solid #ccc">
												@if($v['sign3'])<span style="position:relative;bottom:28px;border:2px solid #da647c;background:#fff;color:#da647c;font-size:.5rem;padding:2px 2px 0;">{!! $v['sign3'] !!}</span>@endif
											</p>
											<dt style="height:2rem;overflow:hidden;">@if($v['mark3'])<span style="border:1px solid #ccc;border-radius:5px;font-size:.4rem;padding:0.1rem;">{!! $v['mark3'] !!}</span>@endif <strong style="font-size:.6rem;">{{ $v['title3'] }}</strong></dt>
											<dt>{!!  $v['instruction3'] !!}</dt>
											<dt>{!!  $v['remarks3'] !!}</dt>
                                        </a>
                                    </dl>
                                    <dl style="width: 33%;padding:0 .5rem .5rem .5rem;">
                                        <a href=" {{ $v['url4'] }}" external>
											<p style="margin-bottom:-25px;">
												<img src="{{ $v['image4'] }}" style="width:100%;border:1px solid #ccc">
												@if($v['sign4'])<span style="position:relative;bottom:28px;border:2px solid #da647c;background:#fff;color:#da647c;font-size:.5rem;padding:2px 2px 0;">{!! $v['sign4'] !!}</span>@endif
											</p>
											<dt style="height:2rem;overflow:hidden;">@if($v['mark4'])<span style="border:1px solid #ccc;border-radius:5px;font-size:.4rem;padding:0.1rem;">{!! $v['mark4'] !!}</span>@endif <strong style="font-size:.6rem;">{{ $v['title4'] }}</strong></dt>
											<dt>{!!  $v['instruction4'] !!}</dt>
											<dt>{!!  $v['remarks4'] !!}</dt>
                                        </a>
                                    </dl>
                                </div>
                            </div>
                        @endforeach
                    @endif
                        @if($type == 1)
                                <!-- 附近推荐商户 -->
                        <div class="content-block-title f14 c-red"><i class="icon iconfont mr5">&#xe652;</i>好货推荐</div>
                        <ul id="wdddmain" class="row no-gutter y-recommend">
                            @if(!empty($orderData))
                                @include('wap.community.index.lists_item2')
                            @endif
                        </ul>
                        @else
                                <!-- 附近推荐商户 -->
                        <div class="content-block-title f14 c-gray"><i class="icon iconfont mr5">&#xe632;</i>附近推荐商户</div>
                        <div class="list-block media-list y-sylist">
                            <ul id="wdddmain">
                                @if(!empty($orderData))
                                    @include('wap.community.index.lists_item')
                                @endif
                            </ul>
                        </div>
                    @endif



                    <div class="pa w100 tc allEnd none">
                        <p class="f12 c-gray mt5 mb5">没有更多了</p>
                    </div>

                    <!-- 加载提示符 -->
                    <div class="infinite-scroll-preloader none">
                        <div class="preloader"></div>
                    </div>
                    <!-- 回到顶部 -->
                    <a href="javascript:$('.content').scrollTop(0)" class="y-backtop"></a>
        </div>
        @include('wap.community._layouts.js_share')
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
            $("#indexNavSwiper").swiper({"pagination":".swiper-pagination-nav_index"});
            $("#indexBrandSwiper").swiper({"pagination":".swiper-pagination-adv_brand", "autoplay":2500});
            $("#indexGoodsAdvSwiper").swiper({"pagination":".swiper-pagination-goods_adv", "slidesPerView": 2.8, "freeMode": true });
            //回到顶部
            // $(".content").scroll(function(){
                // var windowheight =  $(window).height();
                // var topheight = $(".content").scrollTop();
                // if (topheight > windowheight*2) {
                    // $(".y-backtop").removeClass("none");
                // }else{
                    // $(".y-backtop").addClass("none");
                // }
            // })

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
    </script>
@stop