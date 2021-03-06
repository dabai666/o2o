@extends('wap.community._layouts.base')
@section('show_top')
    <header class="bar bar-nav" style="background: rgb(253,44,73);">
        <a class="button button-link button-nav pull-left back" href="@if(!empty($nav_back_url)) {{ $nav_back_url }} @else javascript:$.back(); @endif" data-transition='slide-out' style="color: #ffffff;">
            <span class="icon iconfont">&#xe600;</span>
        </a>
        <h1 class="title f16" style="color: #ffffff;">限时秒杀</h1>
		<a id="open_explain" class="button button-link button-nav pull-right" style="color: #ffffff;">说明</a>
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
        .btngre{
            padding:5px 8px;
            background-color:rgb(193,206,213);
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
    </style>
    @stop
    @section('content')
    @include('wap.community._layouts.bottom')
            <!--秒杀页 start-->
    <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:block;">
        <!--banner start-->
        @if($data)
            <div><img src="{{ $banner['val'] }}" style="width:100%;vertical-align:bottom;height:150px;"/></div>
            <div class="flex align-item" style="width:100%;background-color:#fff;">
                <!--时间活动  start-->
                <div class="time flex justify-content" id="Countime">
                    @foreach($data as $k => $v)
                        @if($k <= 3)
                        <div class="width box @if($v['flage']) timestart @endif kill_nav" time='{{ $v['startTime'] }}' maxtime="{{ $v['maxTime'] }} " kill-id="{{ $k }}" id="kill_id_{{ $k }}">
                        </div>
                        @endif
                    @endforeach
                </div>
                <!--时间活动 end-->
            </div>
            @endif
                    <!--banner end-->
            <!--食品列表 start-->
            @if($data)
                <div class="food">
                    @foreach($data as $k => $v)
                        @if($k <= 3)
                            @if($v['goodsList'])
                                <div class="flex justify-content flex-wrap pd border-bottom @if(!$v['flage']) none @endif" id="tab_{{ $k }}">
                                    @foreach($v['goodsList'] as $kk => $vv)
                                        <div class="flex justify-content border-bottom" style="width:95%;padding-bottom:5px;" onclick="window.location.href='{{u('activity/seckill_detail',array('activityId'=>$v['id'],'goodsId'=>$vv['id'])) }}'">
                                            <div class="flex justify-content">
                                                <p class="img"><img src="{{ $vv['image'] }}"/></p>
                                                <div>
                                                    <p class="font12" style="width:150px;white-space: nowrap;text-overflow:ellipsis; overflow:hidden;">{{ $vv['seller']['name'] }}</p>
                                                    <h4 style="white-space: nowrap;text-overflow:ellipsis; overflow:hidden;">{{ $vv['name'] }}</h4>
                                                    <p class="font12" style="margin-top: 5px;">
                                                        <b class="borderred">已抢{{ $vv['useStock'] }}份</b>
                                                        <span>剩{{ ($vv['stock']) }}份</span>
                                                    </p>
                                                    <p style="margin-top: 5px;">
                                                        <b class="colorred">¥<span class="font14"> @if($vv['salePrice'] > 0) {{ $vv['salePrice'] }} @else {{ $vv['price'] }} @endif</span></b>
                                                        <del>¥{{ $vv['price'] }}</del>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="flex align-item" style="justify-content: flex-end;">@if($v['timeStatus'] == 1) <a  class="btnred">立即抢购</a> @elseif($v['timeStatus'] == -1) <span class="btngre">已结束</span> @else <span class="btngre">即将开始</span>@endif</div>
                                        </div>
                                    @endforeach
                                </div>
                            @else
                                <div class="flex justify-content flex-wrap pd border-bottom @if(!$v['flage']) none @endif" id="tab_{{ $k }}">
                                    附近商家未参与活动
                                </div>
                            @endif
                        @endif
                    @endforeach
                </div>
            @else
                暂时没有活动
            @endif
    </div>
    <!--秒杀页 end-->
	<!-- 秒杀说明 -->
	<div id="explain" style="width:100%;height:100%;display:none;">
		<div style="width:100%;height:100%;z-index:98;position:absolute;background:#000;filter:alpha(opacity=50);-moz-opacity:0.5;opacity: 0.5;"></div>
		<div style="width:80%;height:60%;z-index:99;position:absolute;top:20%;left:10%;background:#fa5f5f;border-radius:10px;padding:15px;overflow-y:auto;">
			<div style="text-align:center;"><img src="/images/seckillexplain.png" /></div>
			<div style="color:#fff;">{!! $seckill_explain !!}</div>
		</div>
	</div>
    <script type="text/javascript">
        $(function() {
            $(".y-gywm").css("min-height",$(window).height()-45);
			$("#open_explain").click(function(){
				$("#explain").css("display","block");
			});
			$("#explain").click(function(){
				$("#explain").css("display","none");
			});
        })
    </script>
@section($js)
    <script type="text/javascript">
        //可写js
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
                    var maxTime=boxes[i].getAttribute('maxtime');
                    var leaveTime=parseInt(startTime)+parseInt(maxTime)-parseInt(nowTime);
                    if(startTime-nowTime<=0&&startTime+maxTime-nowTime>=0){
                        var d=parseInt(leaveTime/(24*60*60));
                        var h=parseInt(leaveTime/1000/(60*60));
                        var m=parseInt(leaveTime/1000%3600/60);
                        var s=parseInt(leaveTime/1000%3600%60);
                        m=cleartime(m);
                        h=cleartime(h);
                        s=cleartime(s);
//                        boxes[i].className="width box timestart kill_nav";
                        boxes[i].innerHTML="<p>距离结束</p>"+"<p>"+h+":"+m+":"+s+"</p>";
                        maxTime-=1000;
                    }
//                    alert(maxTime);
                    if (startTime+maxTime-nowTime<=0) {    //判断倒计时是否结束
                        sh=cleartime(sh);
                        sm=cleartime(sm);
//                        boxes[i].className="width box kill_nav";
                        boxes[i].innerHTML="<p>"+sh+":"+sm+"</p>"+"<p>已结束</p>";
                    }

                    if(startTime - nowTime > 0){
                        boxes[i].innerHTML="<p>"+sh+":"+sm+"0</p>"+"<p>即将开始</p>";
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
        $(function() {
            $('.kill_nav').bind('click',function(){
                var id = $(this).attr('kill-id');
                $("#tab_0").addClass('none');
                $("#tab_1").addClass('none');
                $("#tab_2").addClass('none');
                $("#tab_3").addClass('none');
                $("#tab_"+id).removeClass('none');
                $(".kill_nav").removeClass('timestart');
                $("#kill_id_"+id).addClass('timestart');
            });
        });
    </script>
    <script type="text/javascript">
        Zepto(function($){
            $("img.lazyload").lazyload({
                placeholder:"{{asset('wap/community/newclient/images/loading.gif')}}"
            });
            var data = new Object;
            $.post("{{ u('Activity/killnav') }}", data, function(result){
                result  = $.trim(result);
                alert(result);
                $('#Countime').html(result);
            });
        });
    </script>
@stop
@stop