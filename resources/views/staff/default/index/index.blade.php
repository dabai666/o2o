@extends('staff.default._layouts.base')
@section('title'){{$title}}@stop
@section('show_top')
    <header class="bar bar-nav">
        <h1 class="title tl pl10">{{$title}}</h1>
    </header>
@stop
@section('contentcss')admin-order-bmanage infinite-scroll infinite-scroll-bottom pull-to-refresh-content @stop
@section('distance')data-ptr-distance="20" @stop
@section('content')
    @include('staff.default._layouts.refresh')
    <!-- 下面是正文 -->
    <div class="list-block media-list y-ordergllist">
        {{--<div class="ordertitle">--}}
            {{--共计<em class="focus-color-f">{{$list['count'] or 0}}</em>单，金额￥<em class="focus-color-f">{{$list['amount'] or 0}}</em>元--}}
        {{--</div>--}}
        @if($list['orders'])
            <ul  class="lists_item_ajax">
                @include("staff.default.index.item")
                <li></li>
            </ul>
            @else
            <div class="x-null tc">
                <i class="icon iconfont">&#xe60c;</i>
                <p>很抱歉，暂无最新订单</p>
            </div>
        @endif
    </div>
@stop