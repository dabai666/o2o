@extends('wap.community._layouts.base')
@section('show_top')
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="@if($args['index_flage']) u('Index/index') @else # @endif" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <h1 class="title f16">{{$data['title']}}</h1>
    </header>
@stop
@section('content')
    @include('wap.community._layouts.bottom')
    <div class="content c-bgfff" id=''>
        <div class="y-about f14">
            <p>{!! $data['content'] !!}</p>
        </div>
    </div>
	@if ($data['id'] == 10)
	<style>
	.y-about{padding:0.5rem 0;}
	.y-about p{text-indent:0;}
	.y-about p img{width:100%;height:100%;}
	</style>
	<a href="tel:13106169999" >
		<img src="/wap/community/newclient/images/phone.png" style="width:60px;height:60px;position:absolute;bottom:70px;right:4%;"/>
	</a>
	@endif
	<script type="text/javascript">
		$(function() {
			$(".y-gywm").css("min-height",$(window).height()-45);
		})
	</script>
@stop