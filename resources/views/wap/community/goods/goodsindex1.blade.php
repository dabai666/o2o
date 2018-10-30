@extends('wap.community._layouts.base')

@section($css)
    <style type="text/css">
        /*.tabs .tab{display: block;}*/
        .y-scr{width: 25%;overflow: hidden;}
        .y-scroll{margin-right: -10px;}
        .y-scr p{line-height: 40px;display: block;text-align: center;border-bottom: 1px solid #ccc;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
        .y-scr p.active{color: #ff2d4b;background: #fff;}
        .tabs{overflow-y: scroll;overflow-x: hidden;}
        .x-goodstab .x-sortlst.list-block{overflow: hidden;}
    </style>
    <style>
        .div-ul-li ul li{
            /*以上三行实现自适应start*/
            width: 25%;/*设置宽度*/
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
        $cartgoods[$good["goodsId"]][$good["normsId"]]  = ["num"=>$good["num"], "price"=>$good["price"]];
        //$cartgoods[$good["goodsId"]][$good["normsId"]] = $good["num"];
    }
    ?>
    <div class="content" id=''>
        <!-- 菜单列表 -->
        <div class="x-sjfltab x-goodstab clearfix">
            <div class="y-scr fl pr" id="scroll_menu">
                <div class="y-scroll">
                    @foreach($cate as $ckey => $item)
                        <p data-firstLevel="{{ $item['id'] }}" class="herfid{{$ckey}} firstLevel @if($ckey == 0) active @endif ">{{$item['name']}}</p>
                    @endforeach
                </div>
                <input type="hidden" id="firstLevelId" value="{{ $cate[0]['id'] or -1}}">
            </div>
            <div class="tabs c-bgfff fl y-tabs">
                <div class="tab active">
                    <div style="display: flex;width: 100%;height: 40px;" >
                        <div style="width: 50%;text-align: center;" class="flage a" data-flage="1">
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
                                    按名称筛选
                                </span>
                        </div>
                        <input  value="1" class="none" id="flage">
                    </div>

                    <div style="max-height: 150px;margin-bottom: 10px;">
                        <div class="div-ul-li" style="max-height:140px;overflow:auto;" id="brand">
                            <ul>
                                @if($brandList)
                                    @foreach($brandList as $k => $v)
                                        <li><input type="button" value="{{ $v['name'] }}" data-brand-id="{{ $v['id'] }}" class="button123 brand @if($k == 0) a1 @endif"></li>
                                    @endforeach
                                @endif
                            </ul>
                        </div>
                        <div class="div-ul-li none" style="max-height:140px;overflow:auto;" id="classify">
                            <ul>
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
                    <hr style="border:1px solid lightgrey;"/>
                    <div id="bb" style="display: flex;width: 100%;height: 40px;">
                        <div style="width: 49.3%;text-align: center;margin-top: 10px;color: #bababa;" id="cancel">清&nbsp;空</div>
                        <div style="width: 0.4%;color:#e3e3e3;text-align: center;margin-top: 10px; "></div>
                        <div style="width: 49.3%;text-align: center;margin-top: 10px;color: #fe415b" id="confirm">确&nbsp;定</div>
                    </div>
                    <hr style="border:1px solid lightgrey;"/>
                    <div>
                        <div class="infinite-scroll infinite-scroll-bottom pull-to-refresh-content" data-ptr-distance="55" data-distance="50" id="">
                            <div class="pull-to-refresh-layer none">
                                <div class="preloader"></div>
                                <div class="pull-to-refresh-arrow"></div>
                            </div>
                            <div class="card-container" id="wdddmain">

                            </div>
                            <!-- 加载提示符 -->
                            <div class="infinite-scroll-preloader none">
                                <div class="preloader"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @include('wap.community.goods.share')
@stop
@section($js)
    <script>
        var type = " {{ $option['type'] }}";
        var id = " {{ $option['id'] }}";
        var firstInto = true;
        var userId = "{{ $userId }}";
        var dispatching = parseFloat("{{ $seller['serviceFee'] }}") - parseFloat("{{ $cart['totalPrice'] }}");
        $(function(){
            $(document).on("click",".add1",function(){
                var id = $(this).attr('data-id');
                var val = $("#normsval_"+id).val();
                var price =  $(this).attr('data-price');

                var data = new Object;
                data.goodsId = id;
                data.num = parseInt(val) + parseInt(1);
                $.post("{{u('Goods/saveCartOne')}}", data, function(res){
                    if (res.code < 0) {
                        $.alert("请登录");
                        setTimeout(function () { window.location.href = "{{u('User/login')}}"; }, 2000);
                        return false;
                    } else if (res.code > 0) {
                        $.alert(res.msg);
                        return false;
                    }
                    var num = parseInt(val) + parseInt(1);
                    var cartTotalPrice = parseFloat(price) * parseFloat(num);
                    var cartTotalAmount = parseInt($("#cartTotalAmount").html().replace(/(^\s+)|(\s+$)/g,"")) + parseInt(1);
                    $("#cartTotalAmount").html(cartTotalAmount);
                    $("#cartTotalPrice").val(cartTotalPrice);
                    if(cartTotalPrice > dispatching){
                        $("#cartShow1").hide();
                        $("#cartShow2").show();
                    }else{
                        $("#cartShow1").show();
                        $("#cartShow2").hide();
                    }
                    $("#cartTotalPrice_DsyNum_"+id).val(num);
                    if((val  == "") || (val == 0)){
                        val = 0;
                        $(".subtract1").removeClass("none");
                    }
                    $("#normsval_"+id).val(num);
                    $("#normsval_span_"+id).html(num);
                    $("#normsval_span_"+id).removeClass('none');
                });

            });
            $(document).on("click",".subtract1",function(){
                var id = $(this).attr('data-id');
                var val = $("#normsval_"+id).val();
                var price = $(this).attr('data-price');

                var data = new Object;
                data.goodsId = id;
                data.num = parseInt(val) - parseInt(1);
                $.post("{{u('Goods/saveCartOne')}}", data, function(res){
                    if (res.code < 0) {
                        $.alert("请登录");
                        setTimeout(function () { window.location.href = "{{u('User/login')}}"; }, 2000);
                        return false;
                    } else if (res.code > 0) {
                        $.alert(res.msg);
                        return false;
                    }
                    var num = parseInt(val) - parseInt(1);
                    var cartTotalPrice = parseFloat(price) * parseFloat(num);
                    var cartTotalAmount = parseInt($("#cartTotalAmount").html().replace(/(^\s+)|(\s+$)/g,"")) - parseInt(1);
                    $("#cartTotalAmount").html(cartTotalAmount);
                    $("#cartTotalPrice").val(cartTotalPrice);
                    if(cartTotalPrice > dispatching){
                        $("#cartShow1").hide();
                        $("#cartShow2").show();
                    }else{
                        $("#cartShow1").show();
                        $("#cartShow2").hide();
                    }
                    $("#cartTotalPrice_DsyNum_"+id).val(num);
                    if(num <= 0){
                        $(".subtract1").addClass("none");
//                        $(this).addClass('none');
                        $("#normsval_"+id).val(num);
                        $("#normsval_span_"+id).addClass('none');
                        return false;
                    }
                    $("#normsval_"+id).val(num);
                    $("#normsval_span_"+id).html(num);
                    $("#normsval_span_"+id).removeClass('none');
                });
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
                    /* $(this).addClass('b');
                     $("#classify").addClass('a');*/
                }else{
                    $("#classify").addClass('none');
                    $("#brand").removeClass('none');
                    /* $("#brand").addClass('a');
                     $("#classify").addClass('b');*/
                }
                $("#flage").val(flage);
            });
            //确定
            $("#confirm").bind('click',function(){
                var data = new Object;
                data.page = 1;
                data.type = type;
                data.id = id;
                data.userId = userId;
                var flage = $("#flage").val();
                var firstLevelId = $("#firstLevelId").val();
                data.firstLevelId = firstLevelId;
                if(flage == 1){
                    var brandId = $("#brandId").val();
                    data.brandId = brandId;
                }else{
                    var classifyId = $("#classifyId").val();
                    data.classifyId = classifyId;
                }
                getList(data,false);
            });

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
                });
            }
            function getBrand(data){
                $.post("{{ u('Goods/getBrand') }}", data, function(result){
                    result  = $.trim(result);
                    $('#brand').html(result);
                });
            }
            function getClassify(data){
                $.post("{{ u('Goods/getClassify') }}", data, function(result){
                    result  = $.trim(result);
                    $('#classify').html(result);
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
                var firstLevelId = $("#firstLevelId").val();
//                var secondLevelId = $("#secondLevelId").val();
                data.firstLevelId = firstLevelId;
//                data.secondLevelId = secondLevelId;
                getList(data,true);
            }
            //取消
            $("#cancel").bind('click',function(){
                start();
            });
            //左导航
            $(".firstLevel").bind('click',function(){
                $('.firstLevel').removeClass('active');
                $(this).addClass('active');
//                $(".secondLevel").addClass('none');
                var firstLevelId = $(this).attr('data-firstLevel');
//                $("#firstLevel_id_"+firstLevelId).removeClass('none');
                $("#firstLevelId").val(firstLevelId);
//                $("#secondLevelId").val('-1');
                start();
            });
            //分类
            $("#classify").on("click","input", function() {
                $('.classify').removeClass('a1');
                $(this).addClass('a1');
                var classifyId = $(this).attr('data-classify-id');
                $('#classifyId').val(classifyId);
            });
            $("#brand").on("click","input", function() {
                if($(this).hasClass("a1")){
                    $(this).removeClass('a1');
                }else{
                    $(this).addClass('a1');
                }
            });
            /*$("#brand").on("click","input", function() {
                $('.brand').removeClass('a1');
                $(this).addClass('a1');
                var brandId = $(this).attr('data-brand-id');
                $('#brandId').val(brandId);
            });*/
            // 加载开始
            // 上拉加载
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
                var flage = $("#flage").val();
                var firstLevelId = $("#firstLevelId").val();
                var secondLevelId = $("#secondLevelId").val();
                data.firstLevelId = firstLevelId;
                data.secondLevelId = secondLevelId;

                $.post("{{ u('Tag/getList') }}", data, function(result){
                    groupLoading = false;
                    $('.infinite-scroll-preloader').addClass('none');
                    result  = $.trim(result);
                    if (result != '') {
                        groupPageIndex++;
                        $('#wdddmain').append(result);
                        $.refreshScroller();
                    }else{
                        $(".allEnd").removeClass('none');
                        nopost = 1;
                    }
                });
            });
            //下拉刷新
            $(document).off('refresh', '.pull-to-refresh-content');
            $(document).on('refresh', '.pull-to-refresh-content',function(e) {
                // 如果正在加载，则退出
                if (groupLoading) {
                    return false;
                }
                $(".pull-to-refresh-layer").removeClass('none');
                groupLoading = true;
                var data = new Object;
                data.page = groupPageIndex;
                var flage = $("#flage").val();
                var firstLevelId = $("#firstLevelId").val();
                var secondLevelId = $("#secondLevelId").val();
                data.firstLevelId = firstLevelId;
                data.secondLevelId = secondLevelId;

                $.post("{{ u('Tag/getList') }}", data, function(result){
                    groupLoading = false;
                    result  = $.trim(result);
                    if (result != "") {
                        groupPageIndex = 2;
                    }
                    $('#wdddmain').html(result);
                    $(".pull-to-refresh-layer").addClass('none');
                    $.pullToRefreshDone('.pull-to-refresh-content');
                });
            });
            start();
        })
    </script>
    <script>
        $(function(){
            var height = $(".bar-nav").height();
            height += $(".bar-tab").height();
            $(".x-goodstab .tab").css("height",$(window).height()-height);
            // $(".x-goodstab .buttons-tab").css("height",$(window).height()-height);
            $(".x-goodstab .buttons-tab").css({"height":$(window).height()-height,"overflow": "scroll"});
        })
        $(".tagpage").css({"bottom":0,"overflow": "hidden"});
    </script>
    @stop
@section("ajax")
    <script src="{{ asset('wap/community/client/js/cel.js') }}"></script>
    <script src="{{ asset('wap/community/newclient/js/jquery.lazyload.js') }}"></script>
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

            //菜单点击
            var is_do = 0;
            $(document).on('click','.y-scroll p', function(){
                var id = $(this).attr("href");
                var topheight = $(id).offset().top+$('.tabs').scrollTop()-$(".y-sjlistnav").height()-$(".bar-header-secondary").height();
                //alert($(id).offset().top+"/"+$('.tabs').scrollTop()+"/"+$(this).attr("href"))
                is_do = 1;
                if(id == "#tab1_1"){
                    $('.tabs').scrollTop(0);
                    // $('.tabs').animate({scrollTop:0}, 600);
                }else{
                    $('.tabs').scrollTop(topheight);
                    // $('.tabs').animate({scrollTop:topheight}, 600);
                }
                $('.y-scroll p').removeClass("active");
                $(this).addClass("active");
            });

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
            $(document).off('touchmove',".tabs");
            $(document).on('touchmove',".tabs", function (e) {
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
            });
            $.showTop = function(){
                var top = $(".tabs .active").offset().top+$('.tabs').scrollTop()-$(".y-sjlistnav").height()-$(".bar-header-secondary").height();
                $('.tabs').scrollTop(top);
            }
            $.showTop();
            // 弹窗
            $(document).on('click','.y-xgg', function () {
                var id = $(this).data('ids');
                var name = $(this).data('name');
                var html = $(".show_item_norms_" + id).html();
                $.modal({
                    extraClass:"modal_show_item_norms_"+id,
                    title:  '<div class="y-paytop"><i class="icon iconfont c-gray fr">&#xe604;</i><p class="c-black f18 tl">'+name+'</p></div>',
                    text:html

                });
                $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).addClass('active');
                var val  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('ns');
                var prs  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('prs');
                var salePrice  = $(".modal_show_item_norms_"+id+" .y-ggpsize li").eq(0).data('saleprice');
                if(salePrice <= 0){
                    prs = prs;
                }else{
                    prs = salePrice;
                }
                if(val > 0){
                    $(".modal_show_item_norms_"+id+" .subtract ").removeClass('none');
                    $(".modal_show_item_norms_"+id+" .show_item_id_mnum ").removeClass('none');
                    $(".modal_show_item_norms_"+id+" .show_item_id_mnum ").text(val);
                    var m = val * prs;
                    $(".modal_show_item_norms_"+id+" .money_toal").html(prs);

                }
                $(".modal_show_item_norms_"+id+" .msg_show").addClass("none");
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
            $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-normsid',id);
            $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-price',price);
            $(".modal_show_item_norms_"+pid +" .show_item_id_mnum").attr('data-salePrice',salePrice);
            var m = val * price;
            if(salePrice > 0)
            {
                //特价商品
                $(".modal_show_item_norms_"+pid+" .money_toal").html(salePrice);
                $(".modal_show_item_norms_"+pid+" .delPrice").html(price);
            }
            else
            {
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
                if(salePrice > 0)
                {
                    //特价商品
                    $(".modal_show_item_norms_"+pid+" .money_toal").html(salePrice);
                    $(".modal_show_item_norms_"+pid+" .delPrice").html(price);
                }
                else
                {
                    //正常商品
                    $(".modal_show_item_norms_"+pid+" .money_toal").html(price);
                }
            }

        }

        <?php
        echo "var cartgoods = ";
        echo json_encode((array)$cartgoods);
        echo ";"
        ?>

        // 处理返回值
        function HandleResult(res)
        {
            if (res.code < 0)
            {
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
        $(document).on("touchend", ".subtract", function ()
        {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) - 1;
            $(".msg_show"+sender.data("goodsid")).addClass('none');

            if (value <= 0)
            {
                value = 0;

                $(this).siblings(".add").siblings().addClass("none");
            }
            $.post("{{u('Goods/saveCart')}}", { sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}",goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
                    var pr = 0;
                    sender.html(value);
                    if(sender.data("saleprice") <= 0){
                        pr = sender.data("price");
                    }else{
                        pr = sender.data("saleprice");
                    }
                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr),res,sender.data("newold"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    if(value == 0){
                        $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(0);
                        $(".show_item_norms_"+sender.data("goodsid") +" .subtract").addClass("none");
                        $(".show_item_id_"+sender.data("normsid")).attr("data-ns",0);
                    }
                }
                HandleResult(res);
            } );


        });
        // 添加数量
        $(document).on("touchend", ".add", function ()
        {
            var thisVal = $(this);

            var sender = thisVal.siblings(".val");

            var value = parseInt(sender.html()) + 1;

            $.post("{{u('Goods/saveCart')}}", {sellerId:"{{Input::get('id')}}",type:"{{Input::get('type')}}", goodsId: sender.data("goodsid"), normsId: sender.data("normsid"), num: value, serviceTime: 0 }, function(res){
                if(res.code == 0){
                    var pr = 0;
                    sender.html(value);
                    if(sender.data("saleprice") <= 0){
                        pr = sender.data("price");
                    }else{
                        pr = sender.data("saleprice");
                    }
                    CalculationTotal(sender.data("goodsid"), sender.data("normsid"), value, parseFloat(pr),res,sender.data("newold"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-normsid',sender.data("normsid"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").attr('data-price',sender.data("price"));
                    $(".show_item_norms_"+sender.data("goodsid") +" .show_item_id_mnum").text(value);
                    var m = value * sender.data("price");
                    thisVal.siblings().removeClass("none");
                    $(".show_item_id_"+sender.data("normsid")).attr("data-ns",value);

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