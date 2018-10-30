@extends('wap.community._layouts.base')
@section('css')
    <style>

    </style>
@stop
@section('show_top')
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left" href="{{ u('Index/index') }}" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <h1 class="title f16">选择分类</h1>
    </header>
    <!--<header class="bar bar-nav">
        <div class="searchbar x-tsearch y-search">
            <div class="search-input pr dib"  style="width: 100%">
                <input type="search" id='search' placeholder='搜索附近商品或门店' onclick="$.href('{{u('Seller/search')}}')" readonly/>
            </div>
             <a class="button button-fill button-primary c-bg">搜索</a>
        </div>
    </header>-->
@stop

@section('content')
    <?php
    $one = $two = true;
    ?>
    @include('wap.community._layouts.bottom')
    <div class="content tagpage " id=''>
        @if($cityIsService == 0)
                <!-- 未开通物业提示 -->
        <div class="x-null pa w100 tc">
            <img src="{{ asset('wap/community/newclient/images/nothing.png') }}" width="108">
            <p class="f12 c-gray mt10">附近没有发现其他门店，我们正在努力覆盖中</p>
            <a class="f14 c-white x-btn mt15" href="{{ u('Index/addressmap')}}">切换地址</a>
        </div>
        @else
            <div class="x-sjfltab x-goodstab clearfix" style="overflow:hidden;">
                <div class="buttons-tab fl pr">
                    @foreach($tagList as $key => $value)
                        @if($value['id'] > 0)
                            <a data-firstLevel="{{ $value['id'] }}" class="tab-link button firstLevel @if($key == 0) active @endif">{{$value['name']}}</a>
                            @if($value['systemTagList'])
                                <ul class="secondLevel @if($key != 0) none @endif" id="firstLevel_id_{{ $value['id'] }}">
                                    @foreach($value['systemTagList'] as $k => $v)
                                        <li class="tab-link button secondLevelOne" data-secondLevel="{{ $v['id'] }}" style="font-size: 11px;height: 35px;margin-top: -5px;">{{ $v['name'] }}</li>
                                    @endforeach
                                </ul>
                            @endif
                        @endif
                    @endforeach
                    <input type="hidden" id="firstLevelId" value="{{ $tagList[0]['id'] or -1}}">
                    <input type="hidden" id="secondLevelId" value="-1">
                </div>
                <div style="width:75%; heihgt: 40px; position: absolute; z-index:300;right:0;background-color:rgba(255,255,255,1)" >
                    <div style="background: rgb(224,223,221);width: 50%;text-align: center; float:left;" class="flage a" data-flage="1" id="navheight">
                                <span  style="font-size: 15px;">
                                    <div style="height: 10px;"></div>
                                    <input style="width: 100%;" type="radio" value="1" class="none" name="flage">
                                    商品品牌
                                </span>
                    </div>
                    <div style="background: rgb(243,239,238);width: 50%;text-align: center; float:left;" class="flage" data-flage="2" >
                                <span  style="font-size: 15px;">
                                    <div style="height: 10px;"></div>
                                    <input style="width: 100%;" type="radio" value="2" class="none"  name="flage">
                                    按名称筛选
                                </span>
                    </div>
                    <input  value="1" class="none" id="flage">
                    <div>
                        <div style="max-height: 150px; margin-top: 35px;">
                            <div class="div-ul-li" style="max-height:140px;overflow:auto;" id="brand">
                                <ul id="brandListIdArr">
                                    <!-- <li><input type="button" value="11" data-brand-id="10" class="button123 brand a1"></li>-->
                                    @if(isset($brandList) && $brandList)
                                        @foreach($brandList as $k => $v)
                                            <li style="width: 25%;text-align: center;float:left;list-style-type:none;display: inline;margin-top: 10px;"><input type="button" value="{{ $v['name'] }}" data-brand-id="{{ $v['id'] }}" class="button123 brand @if($k == 0) teshu @endif @if($k == 0) a1 @endif" style="@if($k == 0) color: red; @endif background: #f3efee;font-size: 14px;padding: 2px 8px;margin: 0;display: inline-block;line-height: 20px;transition: all 1s cubic-bezier(0.175, 0.885, 0.32, 1) 0s;"></li>
                                        @endforeach
                                    @endif
                                </ul>
                            </div>
                            <div class="div-ul-li none" style="max-height:140px;overflow:auto;" id="classify">
                                <ul id="classifyListIdArr">
                                    @if(isset($classifyList) && $classifyList)
                                        @foreach($classifyList as $k => $v)
                                            <li style="width: 25%;text-align: center;float:left;list-style-type:none;display: inline;margin-top: 10px;"><input type="button" value="{{ $v['name'] }}" data-classify-id="{{ $v['id'] }}" class="button123 classify" style="background: #f3efee;font-size: 14px;padding: 2px 8px;margin: 0;display: inline-block;line-height: 20px;transition: all 1s cubic-bezier(0.175, 0.885, 0.32, 1) 0s;"></li>
                                        @endforeach
                                    @endif
                                </ul>
                            </div>
                            <input id="brandId" type="hidden" value="-1">
                            <input id="classifyId" type="hidden" value="-1">
                        </div>
                        <!--<hr style="border:1px solid lightgrey;"/>
                        <div id="bb" style="display: flex;width: 100%;height: 40px;">
                            <div style="width: 49.3%;text-align: center;margin-top: 10px;color:#313233;" id="cancel">清&nbsp;空</div>
                            <div style="width: 0.4%;color:#e3e3e3;text-align: center;margin-top: 10px; "></div>
                            <div style="width: 49.3%;text-align: center;margin-top: 10px;color:#313233" id="confirm">确&nbsp;认</div>
                        </div>
                        <hr style="border:1px solid lightgrey;"/>-->
                    </div>
                </div>

                <div class="tabs c-bgfff fl y-tabs">
                    <div class="tab active">
                        <div id="screenheight" style="height:129px;"></div>
                        <div>
                            <div class="infinite-scroll infinite-scroll-bottom" data-ptr-distance="55" data-distance="50" id="">
                                <div class="pull-to-refresh-layer none">
                                    <div class="preloader"></div>
                                    <div class="pull-to-refresh-arrow"></div>
                                </div>
                                <div class="card-container" id="wdddmain">
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
        @endif
    </div>
@stop

@section($js)
    <script>
        $(function(){
            setHeight(true);//设置高度
            //头部导航
            $('.flage').bind('click',function(){
                //rgb(224,223,221)选中
                //rgb(243,239,238) 未选中
                $('.flage').css('background','');
//                $('.flage').removeClass('b');
//                $('.flage').addClass('b');
                $('.flage').css('background','rgb(243,239,238)');
//                $(this).removeClass('a');
//                $(this).removeClass('b');
                $(this).css('background','rgb(224,223,221)');
//                $(this).addClass('a');
                /* $('.flage').removeClass('a');
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
            //确定
            /*$("#confirm").bind('click',function(){
             $(this).siblings('#cancel').css('color','#313233');
             $(this).css('color','#f00');
             var data = new Object;
             data.page = 1;
             var flage = parseInt($("#flage").val());
             var firstLevelId = $("#firstLevelId").val();
             var secondLevelId = $("#secondLevelId").val();
             data.firstLevelId = firstLevelId;
             data.secondLevelId = secondLevelId;
             if(flage == 1){
             var brandIdArr=new Array();
             var i = 0;
             $("#brandListIdArr li").each(function(){
             if($(this).find('input').hasClass('a1')){
             brandIdArr[i] = $(this).find('input').attr('data-brand-id');
             i++;
             }
             });
             data.brandId = brandIdArr;
             }else{
             var classifyId = $("#classifyId").val();
             data.classifyId = classifyId;
             }
             //                return false;
             getList(data,false);
             });*/
            function confirm(){
//                $(this).siblings('#cancel').css('color','#313233');
//                $(this).css('color','#f00');
                var data = new Object;
                data.page = 1;
                var flage = parseInt($("#flage").val());
                var firstLevelId = $("#firstLevelId").val();
                var secondLevelId = $("#secondLevelId").val();
                data.firstLevelId = firstLevelId;
                data.secondLevelId = secondLevelId;
                if(flage == 1){
                    var brandIdArr=new Array();
                    var i = 0;
                    $("#brandListIdArr li").each(function(){
                        if($(this).find('input').hasClass('a1')){
                            brandIdArr[i] = $(this).find('input').attr('data-brand-id');
                            i++;
                        }
                    });
                    data.brandId = brandIdArr;
                }else{
                    var classifyId = $("#classifyId").val();
                    data.classifyId = classifyId;
                }
//                return false;
                getList(data,false);
            }
            function getList(data,flage){
                if(flage){
                    getBrand(data);
                    getClassify(data);
                }else{
                    $.post("{{ u('Tag/getList') }}", data, function(result){
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
            }
            function setHeight(flage){
                var height1;
                if(flage){
                    //+ parseInt(10)
                    height1 = parseInt($("#brand").height()) + parseInt($("#navheight").height());
                }else{
                    height1 = parseInt($("#classify").height()) + parseInt($("#navheight").height());
                }
                $('#screenheight').css('height',height1);
                /*var height = parseInt($(".bar-nav").height());
                 height += parseInt($(".bar-tab").height());
                 $(".x-goodstab .tab").css("margin-top",parseInt(height1) + 8);
                 $(".x-goodstab .tab").css("height",parseInt($(window).height())-height-height1);
                 $(".x-goodstab .buttons-tab").css({"height":parseInt($(window).height())-height,"overflow": "scroll"});*/
            }
            function getBrand(data){
                $.post("{{ u('Tag/getBrand') }}", data, function(result){
                    result  = $.trim(result);
                    $('#brand').html(result);
                    $.post("{{ u('Tag/getList') }}", data, function(result){
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
                });
            }
            function getClassify(data){
//                var data = new Object;
                $.post("{{ u('Tag/getClassify') }}", data, function(result){
                    result  = $.trim(result);
                    $('#classify').html(result);
                });
            }
            function start(){
                var data = new Object;
                data.page = 1;
                var flage = parseInt($("#flage").val());
                var firstLevelId = $("#firstLevelId").val();
                var secondLevelId = $("#secondLevelId").val();
                data.firstLevelId = firstLevelId;
                data.secondLevelId = secondLevelId;
                $("#flage").val(1);
                getList(data,true);
            }
            //取消
            /*$("#cancel").bind('click',function(){
             $(this).siblings('#confirm').css('color','#313233');
             $(this).css('color','#f00');
             start();
             });*/
            //左导航
            $(".firstLevel").bind('click',function(){
                $('.firstLevel').removeClass('active');
                $(this).addClass('active');
                $(".secondLevel").addClass('none').find('li').removeClass('active');
                var firstLevelId = $(this).attr('data-firstLevel');
                $("#firstLevel_id_"+firstLevelId).removeClass('none');
                $("#firstLevelId").val(firstLevelId);
                $("#secondLevelId").val('-1');
                start();
            });
            $(".secondLevelOne").bind('click',function(){
                $('.secondLevelOne').removeClass('active');
                $(this).addClass('active');
                var secondLevelId = $(this).attr('data-secondLevel');
                $("#secondLevelId").val(secondLevelId);
                start();
            });
            //分类
            $("#classify").on("click","input", function() {
                $('.classify').removeClass('a1');
                $(this).addClass('a1');
                $('.classify').css('color','');
                $(this).css('color','red');

                var classifyId = $(this).attr('data-classify-id');
                $('#classifyId').val(classifyId);
                confirm();
            });
            $("#brand").on("click","input", function() {
                var id = parseInt($(this).attr('data-brand-id'));
                if(id > 0){
                    $(".teshu").removeClass('a1');
                    $(".teshu").css('color','');
                }else{
                    $(".brand").removeClass('a1');
                    $(".brand").css('color','');
                }
                if($(this).hasClass("a1")){
                    $(this).removeClass('a1');
                    $(this).css('color','');
                }else{
                    $(this).addClass('a1');
                    $(this).css('color','red');
                }
                confirm();
            });
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
                if(flage == 1){
                    var brandIdArr=new Array();
                    var i = 0;
                    $("#brandListIdArr li").each(function(){
                        if($(this).find('input').hasClass('a1')){
                            brandIdArr[i] = $(this).find('input').attr('data-brand-id');
                            i++;
                        }
                    });
                    data.brandId = brandIdArr;
                }else{
                    var classifyId = $("#classifyId").val();
                    data.classifyId = classifyId;
                }
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
            /*$(document).off('refresh', '.pull-to-refresh-content');
             $(document).on('refresh', '.pull-to-refresh-content',function(e) {
             // 如果正在加载，则退出
             if (groupLoading) {
             return false;
             }
             $(".pull-to-refresh-layer").removeClass('none');
             groupLoading = true;
             var data = new Object;
             data.page = 1;
             var flage = $("#flage").val();
             var firstLevelId = $("#firstLevelId").val();
             var secondLevelId = $("#secondLevelId").val();
             data.firstLevelId = firstLevelId;
             data.secondLevelId = secondLevelId;
             if(flage == 1){
             var brandIdArr=new Array();
             var i = 0;
             $("#brandListIdArr li").each(function(){
             if($(this).find('input').hasClass('a1')){
             brandIdArr[i] = $(this).find('input').attr('data-brand-id');
             i++;
             }
             });
             data.brandId = brandIdArr;
             }else{
             var classifyId = $("#classifyId").val();
             data.classifyId = classifyId;
             }
             $.post("{{ u('Tag/getList') }}", data, function(result){
             if(flage == 2){
             setHeight(false);
             }else{
             setHeight(true);
             }
             groupLoading = false;
             result  = $.trim(result);
             if (result != "") {
             groupPageIndex = 2;
             }
             $('#wdddmain').html(result);
             $(".pull-to-refresh-layer").addClass('none');
             $.pullToRefreshDone('.pull-to-refresh-content');
             });
             });*/
//            start();
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