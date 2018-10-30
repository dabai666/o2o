@extends('wap.community._layouts.base')
@section('show_top')
<header class="bar bar-nav">
	<a class="button button-link button-nav pull-left" href="{{ u('UserCenter/index') }}">
		<span class="font icon iconfont">&#xe600;</span>
	</a>
	<h1 class="fontsize title f16">佣金明细</h1>
</header>
@stop

@section('css')
<style type="text/css">
	.font{
 		color: #e77817;
 	}
 	.fontsize{
 		color: #e77817;
 	}
 	.top{
 		background: white;
 		width: 19rem;
 		height: 4.5rem;
 		float: left;
 	}
 	.towtop{
 		background: white;
 		width: 19rem;
 		height: 4.5rem;
 		float: left;
 		margin-top: 0.4rem;
 	}
 	.imges{
 		width: 5rem;
 		height: 1rem;
 		margin-left: 1rem;
 		margin-top: 0.5rem;
 	}
 	.Middle{
 		width: 14.5rem;
 		height: 2.5rem;
 		border-bottom: 0.1rem solid #999999;
 		margin-left: 4rem;
 		margin-top: -1rem;
 		line-height: 1.2rem;
 	}
 	.Middle p{
 		color: #999999;
 	}
 	.RMB{
 		width: 4rem;
 		height: 2rem;
 		margin-left: 10.3rem;
 		margin-top: -1.7rem;
 	}
 	.RMB span{
 		letter-spacing: 0.2rem;
 		font-weight: bold;
 		font-size: 1rem;
 		color: #e77817;
 	}
 	.time{
 		margin-left: 13.3rem;
 		margin-top: 0.2rem;
 	}
 	.time p{
 		color: #999999;
 	}
</style>
@stop

@section('content')
<div class="content">
	<div class="top">
		<div class="imges">
			<img src="/images/JB.png"/>
		</div>
		
		<div class="Middle">
			<b>张三获得收单返佣</b>
			<p>店铺名XXXXXXXX</p>
			<div class="RMB">
				<span>+2RMB</span>
			</div>
		</div>
		<div class="time">
			<p>2017-6-30&nbsp;15:34</p>
		</div>
	</div>
	<div class="towtop">
		<div class="imges">
			<img src="/images/JB.png"/>
		</div>
		
		<div class="Middle">
			<b>张三获得收单返佣</b>
			<p>店铺名XXXXXXXX</p>
			<div class="RMB">
				<span>+2RMB</span>
			</div>
		</div>
		<div class="time">
			<p>2017-6-30&nbsp;15:34</p>
		</div>
	</div>
</div>
@stop

@section($js)

@stop