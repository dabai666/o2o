@extends('wap.community._layouts.base')
@section('css')
    <style>
        .swiper-container-horizontal > .swiper-pagination{bottom: 15px;}
        .flex{
            display:flex;
        }
        .justify-content{
            justify-content: space-between;
        }
    </style>
@stop
@section('show_top')
    <header class="bar bar-nav" style="background: rgb(253,44,73);">
        <a class="button button-link button-nav pull-left back" href="javascript:$.href('{{ u('Index/index') }}');" data-transition='slide-out' style="color: #ffffff;">
            <span class="icon iconfont">&#xe600;</span>
        </a>
        <h1 class="title f16" style="color: #ffffff;">品牌详情</h1>
    </header>
@stop
@section('content')
    <script type="text/javascript">
        //BACK_URL = "{!! u('Goods/index',['id'=>$seller['id'],'type'=>1]) !!}";
        //BACK_URL = "{{ u('Index/index') }}";
    </script>
            <!--商品详情页 start-->
    @include('wap.community._layouts.bottom')
    <div class="content" class="swiper-container my-swiper" data-space-between='0'>
        <div class="flex justify-content" style="background: #fff;">
            <div style="width: 20%;">
                <img style="width: 100%;margin: 10px 10px;" src="{{ $brand['img'] }}">
            </div>
            <div style="width: 80%;margin: 10px 10px;">
                <div style="margin-left: 20px;margin: 20px 20px;color: rgb(72,72,72);"><strong style="font-size: 15px;">{{ $brand['name'] }}</strong></div>
            </div>
        </div>
        <div><hr style="border: 0.01rem solid rgb(239,239,224);"></div>
        <div style="background: #fff;" class="clearfix">
            <div style="margin-top: -10px;">&nbsp;</div>
            <div style="margin-left: 10px;color: rgb(186,186,186);font-size: 15px;">
                公司介绍
            </div>
            <div style="margin: 15px 20px;color: #333333;font-family: '微软雅黑';">
                {!! $brand['introduce'] or '该公司暂无公司介绍' !!}
            </div>
        </div>
        <div style="background: rgb(239,239,224);">&nbsp;</div>
        <div  class="clearfix" style="background: #fff;height: 40px;margin-top: -8px;">
            <div style="margin-top: 10px;">
                <span style="margin-top:20px;margin-bottom:20px;margin-left:10px;color: rgb(186,186,186);font-size: 15px;">企业网址</span>
                <span style="margin: 20px 20px;">{{ $brand['url'] or '该公司暂无企业网址'}}</span>
            </div>
        </div>
        <div style="background: rgb(239,239,224);">&nbsp;</div>
        <div  class="clearfix" style="background: #fff;height: 40px;margin-top: -8px;">
            <div style="margin-top: 10px;">
                <span style="margin-top:20px;margin-bottom: 20px;margin-left: 10px;color: rgb(186,186,186);font-size: 15px;">出售中的商品</span>
            </div>
        </div>
        @if($goods)
        <div id="indexGoodsSwiper" class="swiper-container y-swiper" data-space-between='0'  style="background:#fff;">
            <div class="swiper-wrapper">
                @for($i = 0; $i < (ceil(count($goods) / 3)); $i++)
                    <div class="swiper-slide">
                        <ul class="clearfix" style="display: flex;">
                            @foreach(array_slice($goods,($i * 3),3) as  $k => $v)
                            <li style="width: 33.333%;@if(in_array($k,[1,3,5,7,9])) margin-top:10px;margin-bottom:10px; @else margin:10px 10px; @endif"><a href="{{ u('Goods/detail',['goodsId'=>$v['id'],'type'=>$v['type'],'from'=>'brand','brandId'=>$args['brandId']]) }}"  external><img src="{{ $v['image'] }}" style="width: 100%"></a><p style="text-align: center;margin-top: 7px; ">{{$v['name']}}</p></li>
                            @endforeach
                        </ul>
                    </div>
                @endfor
            </div>
            <div class="swiper-pagination swiper-pagination-nav"></div>
        </div>
        @else
            <div id="indexGoodsSwiper" class="swiper-container y-swiper" data-space-between='0'  style="background:#fff;">
                <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <div>该公司暂无出售的商品</div>
                        </div>
                </div>
                <div class="swiper-pagination swiper-pagination-nav"></div>
            </div>
        @endif
        <div style="background: rgb(239,239,224);">&nbsp;</div>
        <div  class="clearfix" style="background: #fff;height: 40px;margin-top: -8px;">
            <div style="margin-top: 10px;color: rgb(186,186,186);">
                <span style="margin-top:20px;margin-bottom: 20px;margin-left: 10px;font-size: 15px;">证书展示</span>
            </div>
        </div>
        <div>
            @foreach($brand['honorImg'] as $value)
                <img src="{{$value}}" style="width: 100%;">
            @endforeach
        </div>
    </div>

            <!--商品详情页 end-->
@stop
@section($js)
    <script type="text/javascript">
        //精确定位
        $(function(){
            $("#indexGoodsSwiper").swiper({"pagination":".swiper-pagination-adv", "autoplay":2500});
        });
    </script>
@stop