@extends('wap.community._layouts.base')

@section('show_top')
    <header class="bar bar-nav">
		<a class="button button-link button-nav pull-left pageloading"  onclick="javascript:history.back();" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <!-- <h1 class="title f16">{{$seller_data['name']}}</h1> -->
        <h1 class="title f16">资质证书</h1>
    </header>
@stop

@section('content')
    <div class="content">
        <img class="mb10" src="{{ $authenticate['businessLicenceImg'] }}" width="100%" />
        <img src="{{ $authenticate['hygieneImg'] }}" width="100%" />
    </div>
@stop

@section($js)

@stop

