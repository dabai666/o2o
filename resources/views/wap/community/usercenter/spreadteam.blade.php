@extends('wap.community._layouts.base')
@section('show_top')
<header class="bar bar-nav">
	<a class="button button-link button-nav pull-left" href="{{ u('UserCenter/index') }}">
		<span class="font icon iconfont">&#xe600;</span>
	</a>
	<h1 class="fontsize title f16">推广团队</h1>
</header>
@stop

@section('css')
 <style type="text/css">
 	.content{
 		background: white;
 	}
 	.font{
 		color: #e77817;
 	}
 	.fontsize{
 		color: #e77817;
 	}
 	.top{
 		width: 18rem;
 		height: 4rem;
 		border-bottom: 0.1rem solid #999999;
 		margin-left: 0.5rem;
 		float: left;
 	}
 	.left{
 		width: 3rem;
 		height: 3rem;
 		margin-top:0.5rem;
 		background:  #e77817;
 		border-radius: 0.3rem;
 	}
 	.left img{
 		margin-left: 0.3rem;
 	}
 	.Middle{
 		width: 7rem;
 		margin-top: -3.6rem;
 		margin-left: 3.5rem;
 	}
 	.Middle p{
 		line-height: 2rem;
 		font-weight: bold;
 	}
  	.right{
  		margin-left: 12.5rem;
  		margin-top: -2.6rem;
  		font-size: 0.9rem;
  		color:#e77817;
  	}
 	
 </style>
@stop

@section('content')
<div class="content">
	<div class="top">
		<div class="left">
			<img src="/images/toux.png" />
		</div>
		<div class="Middle">
		<p>会员名：张三</p>
		<p>手机号：123456789</p>
		</div>
		<div class="right">
			<b>菜味来推广</b>
		</div>
	</div>
	<div class="top">
		<div class="left">
			<img src="/images/toux.png" />
		</div>
		<div class="Middle">
		<p>会员名：张三</p>
		<p>手机号：123456789</p>
		</div>
		<div class="right">
			<b>菜味来推广</b>
		</div>
	</div>
</div>
@stop

@section($js)

@stop