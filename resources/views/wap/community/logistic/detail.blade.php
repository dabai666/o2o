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
    </style>
@stop
@section('show_top')
    <header class="bar bar-nav" style="background: rgb(253,44,73);">
        <a class="button button-link button-nav pull-left back1" href="javascript:void(0);" data-transition='slide-out' style="color: #ffffff;">
            <span class="icon iconfont">&#xe600;</span>
        </a>
        <h1 class="title f16" style="color: #ffffff;">物流/仓储</h1>
    </header>
@stop
@section('content')
    <script type="text/javascript">
        BACK_URL = "{!! u('Goods/index',['id'=>$seller['id'],'type'=>1]) !!}";
        //BACK_URL = "{!! Request::server('HTTP_REFERER') !!}";
    </script>
    @include('wap.community._layouts.bottom')
            <!--物流详情页 start-->
    <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:block;">
       @foreach($data as $k => $v)
        <div class="bgff pd" style="background-color:#fff;padding:10px;">
            <img src="{{ $v['logo'] }}" style="width:60px;height:60px;border-radius:5px;vertical-align:middle;margin-right:10px;"/>
            <span class="font14">{{ $v['name'] }}</span>
        </div>
        <div class="bgff" style="margin-top:10px;background-color:#fff;">
            <div class="flex pd border-bottom" style="flex-wrap: wrap;padding:10px;border-bottom: 1px solid #f3f3f3;">
                <p style="width:25%;color:#999;">时效:</p>
                <p>{{ $v['aging'] }}</p>
            </div>
            <div class="flex pd border-bottom" style="flex-wrap: wrap;padding:10px;border-bottom: 1px solid #f3f3f3;">
                <p style="width:25%;color:#999;">联系人:</p>
                <p>{{ $v['contacts'] }}</p>
            </div>
            <div class="flex justify-content pd border-bottom" style="flex-wrap: wrap;justify-content: space-between;padding:10px;border-bottom: 1px solid #f3f3f3;">
                <p style="width:25%;color:#999;">联系电话:</p>
                <p class="width50" style="width:50%;"> {{ $v['tel'] }} </p>
                <p style="width:25%;">
                    <a href="tel:{{ $v['tel'] }}"><span class="btnred" style=" padding:5px 8px;background-color:#F82243;color:#fff;border-radius:3px;">一键拨打</span></a>
                </p>
            </div>
            <div class="flex pd border-bottom" style="flex-wrap: wrap;padding:10px;border-bottom: 1px solid #f3f3f3;">
                <p style="width:25%;color:#999;">联系QQ:</p>
                <p>{{ $v['qq'] }}</p>
            </div>
            <div class="flex flex-wrap pd border-bottom" style="flex-wrap: wrap;padding:10px;border-bottom: 1px solid #f3f3f3;display:block;">
                <p style="width:100%; color:#999;">公司介绍:</p>
                <p style="text-align:justify;padding:10px;line-height:25px;">
                    {!! $v['introduction'] !!}
                </p>
            </div>
        </div>
           @endforeach
    </div>
    <!--物流详情页 end-->
@stop

@section($js)
    <script type="text/javascript">
        $(document).on("click",".back1",function(){
            window.location.href = "{!! Request::server('HTTP_REFERER') !!}";
            /*$.router.load(@if(!empty($nav_back_url)) {{$nav_back_url}} @else {!! Request::server('HTTP_REFERER') !!} @endif,true);*/
        })
    </script>
@stop