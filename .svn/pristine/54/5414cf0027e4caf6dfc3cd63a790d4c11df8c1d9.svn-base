@extends('wap.community._layouts.base')
@section('show_top')
    <header class="bar bar-nav y-zgsytop">
        <a class="button button-link button-nav pull-left ml5" id="saosao" onclick="$.sao()" @if($weixinliu == 1) style="display: block" @else style="display: none" @endif external>
            <i class="icon iconfont" style="margin-top: 10px;">&#xe67c;</i>
        </a>
        <div class="title tl c-white" onclick="$.href('{{ u('Seller/search')}}')">
            <i class="icon iconfont f13">&#xe65e;</i>
            <input type="text" placeholder="搜索商品、店铺">
            <div class="y-zgsearch"></div>
        </div>
        <a class="button button-link button-nav pull-right" external onclick="$.href('{{ u('Tag/index')}}')">
            <i class="icon iconfont">&#xe636;</i>
            <p class="f12">分类</p>
        </a>
        <!--<a class="button button-link button-nav pull-right mr5" external onclick="$.href('{{ u('UserCenter/systemmessage')}}')">
            <i class="icon iconfont">&#xe660;</i>
            @if(((int)$counts['systemCount'] > 0 || (int)$counts['newMsgCount']))
                <span class="y-redc" style="z-index: 999;border: 1px solid #fff;width: 0.5em;height: 0.5em"></span>
            @endif
        </a>-->
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
    	a:hover{
    		color:#fff;
    	}
    </style>
@stop

@section('content')

    @include('wap.community._layouts.bottom')
    
   	<!--秒杀页 start-->
    <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:none;">
		<!--banner start-->
		<div><img src="images/banner_02.png" style="width:100%;vertical-align:bottom;"/></div>
    	<div class="flex align-item" style="width:100%;background-color:#fff;">
    		<!--时间活动  start-->
    		<div class="time flex justify-content" id="Countime">
    			<div class="width box" time='2017/2/13,10:00:00'>
    				<p>10:00</p>
    				<p>即将开始</p>
    			</div>
    			<div class="width box" time='2017/2/13,14:00:00'>
    				<p>14:00</p>
    				<p>即将开始</p>
    			</div>
    			<div class="width box"  time='2017/2/13,16:00:00'>
    				<p>16:00</p>
    				<p>即将开始</p>
    			</div>
    			<div class="width box" time='2017/2/13,20:00:00'>
    				<p>20:00</p>
    				<p>即将开始</p>
    			</div>
    		</div>
    		<!--时间活动 end-->
    	</div>
    	<!--banner end-->
    	<!--食品列表 start-->
    	<div class="food">
    		<div class="flex justify-content pd border-bottom">
    			<div class="flex justify-content">
    				<p class="img"><img src=""/></p>
    				<div>
    					<span class="font12">咕叽咕叽</span>
    					<h4>小鸡炖蘑菇</h4>
    					<p class="font12">
    						<b class="borderred">已抢5份</b>
    						<span>剩15份</span>
    					</p>
    					<p>
    						<b class="colorred">¥<span class="font14">89</span></b>
    						<s class="font12">¥100</s>
    					</p>
    				</div>
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;"><a href="" class="btnred">立即抢购</a></div>
    		</div>
    		<div class="flex justify-content pd border-bottom">
    			<div class="flex justify-content">
    				<p class="img"><img src=""/></p>
    				<div>
    					<span class="font12">咕叽咕叽</span>
    					<h4>小鸡炖蘑菇</h4>
    					<p class="font12">
    						<b class="borderred">已抢5份</b>
    						<span>剩15份</span>
    					</p>
    					<p>
    						<b class="colorred">¥<span class="font14">89</span></b>
    						<s class="font12">¥100</s>
    					</p>
    				</div>
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;"><a href="" class="btnred">立即抢购</a></div>
    		</div>
    		<div class="flex justify-content pd border-bottom">
    			<div class="flex justify-content">
    				<p class="img"><img src=""/></p>
    				<div>
    					<span class="font12">咕叽咕叽</span>
    					<h4>小鸡炖蘑菇</h4>
    					<p class="font12">
    						<b class="borderred">已抢5份</b>
    						<span>剩15份</span>
    					</p>
    					<p>
    						<b class="colorred">¥<span class="font14">89</span></b>
    						<s class="font12">¥100</s>
    					</p>
    				</div>
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;"><a href="" class="btnred">立即抢购</a></div>
    		</div>
    		<div class="flex justify-content pd border-bottom">
    			<div class="flex justify-content">
    				<p class="img"><img src=""/></p>
    				<div>
    					<span class="font12">咕叽咕叽</span>
    					<h4>小鸡炖蘑菇</h4>
    					<p class="font12">
    						<b class="borderred">已抢5份</b>
    						<span>剩15份</span>
    					</p>
    					<p>
    						<b class="colorred">¥<span class="font14">89</span></b>
    						<s class="font12">¥100</s>
    					</p>
    				</div>
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;"><a href="" class="btnred">立即抢购</a></div>
    		</div>
    		<div class="flex justify-content pd border-bottom">
    			<div class="flex justify-content">
    				<p class="img"><img src=""/></p>
    				<div>
    					<span class="font12">咕叽咕叽</span>
    					<h4>小鸡炖蘑菇</h4>
    					<p class="font12">
    						<b class="borderred">已抢5份</b>
    						<span>剩15份</span>
    					</p>
    					<p>
    						<b class="colorred">¥<span class="font14">89</span></b>
    						<s class="font12">¥100</s>
    					</p>
    				</div>
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;"><a href="" class="btnred">立即抢购</a></div>
    		</div>
    	</div>
    </div>
	<!--秒杀页 end-->
	
    <!--商品详情页 start-->
    <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:none;">
		<!--banner start-->
		<div><img src="dd" style="width:100%;vertical-align:bottom;"/></div>
    	<div class="flex align-item" style="width:100%;background-color:#fff;">
    		<!--时间活动  start-->
    		<div class="time flex justify-content" id="Countime">
    			<div class="timestart" style="width:75%;text-align:left;padding-left:10px;color:#fff;">
    				<p style="color:transparent;">dd</p>
    				<p>
    					<b class="font14">¥<span style="font-size:2rem;font-weight:normal;">89</span></b>
    					<s class="font12">¥100</s>
    				</p>
    			</div>
    			<div class="width box" style="color:orange;" time="2017/2/13,15:00:00">
    				<p class="font12">距离结束还剩</p>
    				<p>00:41:12:2</p>
    			</div>
    		</div>
    		<!--时间活动 end-->
    	</div>
    	<!--banner end-->
    	<div>
    		<div class="flex justify-content pd" style="width:100%;background-color:#fff;">
    			<div>
    				<h4>小鸡炖蘑菇</h4>
    				<p class="font12">
    					<span>剩15份</span>
    					<b class="borderred">已售出1221份</b>
    				</p>					
    			</div>
    			<div class="flex align-item" style="justify-content: flex-end;">
    				<button class="calbtn">-</button><span class="calbtn">1</span><button class="calbtn">+</button>
    			</div>
    		</div>
    	</div>
    	
    	<div style="margin-top:5px;background-color:#fff;padding:10px;">
    		<span>咕叽咕叽</span>
    	</div>
    	
    	<!--商品详情标题 start-->
    	<div class="flex justify-content pd">
    		<p style="border-top:1px solid #ddd;width:40%;height:1px;margin-top:.5rem;"></p>
    		<p style="width:20%;text-align:center;">商品详情</p>
    		<p style="border-top:1px solid #ddd;width:40%;height:1px;margin-top:.5rem;"></p>
    	</div>
    	<!--商品详情描述 end-->
    	<div>
    		<div class="pd" style="width:100%;background-color:#fff;">
	    		<p>盖浪 韩版情侣沙滩裤男女速干大码宽松 海边芈月独家五分短裤，情侣必备，马尔代夫走起来</p>
    		</div>
    		<div><img src="df" style="width:100%;vertical-align:bottom;"/></div>
    	</div>
    </div>
	<!--商品详情页 end-->
	
	<!--促销商品页 start-->
	<div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:none;">
		<!--banner start-->
    	<div>
    		<img src="images/banner_02.png" style="width:100%;"/>
    	</div>
    	<!--banner end-->
    	<div class="flex justify-content flex-wrap" >
    		<!--一个div代表一个商品 start-->
    		<div class="width50 goodsdetail">
    			<dl style="background-color:#fff;margin-right:2px;">
    				<dd><img src="ee" style="width:100%;"/></dd>
    				<dt>五合昆域 库尔勒香梨 一级</dt>
    				<dt>
    					<b class="colorred">¥<span class="font14">269</span></b>
    					<s class="font12">¥100</s>
    				</dt>
    				<dt class="flex justify-content">
    					<p class="font12">18人付款</p>
    					<p class="font12">201人分享</p>
    				</dt>
    				<dt class="font12 orange">咕叽咕叽</dt>
    			</dl>
    		</div>
    		<!--一个div代表一个商品 end-->
    		<!--一个div代表一个商品 start-->
    		<div class="width50 goodsdetail">
    			<dl style="background-color:#fff;margin-left:2px;">
    				<dd><img src="ee" style="width:100%;"/></dd>
    				<dt>五合昆域 库尔勒香梨 一级</dt>
    				<dt>
    					<b class="colorred">¥<span class="font14">269</span></b>
    					<s class="font12">¥100</s>
    				</dt>
    				<dt class="flex justify-content">
    					<p class="font12">18人付款</p>
    					<p class="font12">201人分享</p>
    				</dt>
    				<dt class="font12 orange">咕叽咕叽</dt>
    			</dl>
    		</div>
    		<!--一个div代表一个商品 end-->
    		<!--一个div代表一个商品 start-->
    		<div class="width50 goodsdetail">
    			<dl style="background-color:#fff;margin-right:2px;">
    				<dd><img src="ee" style="width:100%;"/></dd>
    				<dt>五合昆域 库尔勒香梨 一级</dt>
    				<dt>
    					<b class="colorred">¥<span class="font14">269</span></b>
    					<s class="font12">¥100</s>
    				</dt>
    				<dt class="flex justify-content">
    					<p class="font12">18人付款</p>
    					<p class="font12">201人分享</p>
    				</dt>
    				<dt class="font12 orange">咕叽咕叽</dt>
    			</dl>
    		</div>
    		<!--一个div代表一个商品 end-->
    		<!--一个div代表一个商品 start-->
    		<div class="width50 goodsdetail">
    			<dl style="background-color:#fff;margin-left:2px;">
    				<dd><img src="ee" style="width:100%;"/></dd>
    				<dt>五合昆域 库尔勒香梨 一级</dt>
    				<dt>
    					<b class="colorred">¥<span class="font14">269</span></b>
    					<s class="font12">¥100</s>
    				</dt>
    				<dt class="flex justify-content">
    					<p class="font12">18人付款</p>
    					<p class="font12">201人分享</p>
    				</dt>
    				<dt class="font12 orange">咕叽咕叽</dt>
    			</dl>
    		</div>
    		<!--一个div代表一个商品 end-->
    	</div>
	</div>
    <!--促销商品页 end-->
    
	<!--物流仓库页面 start-->
	<div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:none;">
    	<section style="background-color:#fff;">
    		<div class="flex justify-content pd">
	    		<p class="width50 titleborder-left curbg">物流 服务</p>
	    		<p class="width50 titleborder-right">仓库服务</p>
	    	</div>
	    	<ul>
	    		<li class="flex justify-content pd">
	    			<div class="flex justify-content lh">
	    				<p class="img"><img src=""/></p>
	    				<div>
	    					<h3 style="font-weight:normal;">物流公司名称</h3>
	    					<p class="font12">时效：普通货运</p>
	    					<p class="font12">服务以及促销：</p>
	    				</div>
	    			</div>
	    			<div class="flex font12 lh" style="align-items: flex-start;">2017-01-12 12:17</div>
	    		</li>
	    		<li class="flex justify-content pd">
	    			<div class="flex justify-content lh">
	    				<p class="img"><img src=""/></p>
	    				<div>
	    					<h3 style="font-weight:normal;">物流公司名称</h3>
	    					<p class="font12">时效：普通货运</p>
	    					<p class="font12">服务以及促销：</p>
	    				</div>
	    			</div>
	    			<div class="flex font12 lh" style="align-items: flex-start;">2017-01-12 12:17</div>
	    		</li>
	    		<li class="flex justify-content pd">
	    			<div class="flex justify-content lh">
	    				<p class="img"><img src=""/></p>
	    				<div>
	    					<h3 style="font-weight:normal;">物流公司名称</h3>
	    					<p class="font12">时效：普通货运</p>
	    					<p class="font12">服务以及促销：</p>
	    				</div>
	    			</div>
	    			<div class="flex font12 lh" style="align-items: flex-start;">2017-01-12 12:17</div>
	    		</li>
	    	</ul>
    	</section>
	</div>
    <!--物流仓库页面 end-->
    
    <!--物流详情页 start-->
    <div class="content infinite-scroll infinite-scroll-bottom"  data-distance="50" id="" style="display:block;">
		<div class="bgff pd">
    		<img src="dd" style="width:60px;height:60px;border-radius:5px;vertical-align:middle;margin-right:10px;"/>
    		<span class="font14">豪享物流有限公司</span>
    	</div>
    	<div class="bgff" style="margin-top:10px;">
    		<div class="flex pd border-bottom">
    			<p style="width:25%;color:#999;">时效</p>
    			<p>普通货运</p>
    		</div>
    		<div class="flex pd border-bottom">
    			<p style="width:25%;color:#999;">联系人</p>
    			<p>王先生</p>
    		</div>
    		<div class="flex justify-content pd border-bottom">
    			<p style="width:25%;color:#999;">联系电话</p>
    			<p class="width50">031-66368798</p>
    			<p style="width:25%;">
    				<span class="btnred">一键拨打</span>
    			</p>
    		</div>
    		<div class="flex pd border-bottom">
    			<p style="width:25%;color:#999;">联系QQ</p>
    			<p>888888</p>
    		</div>
    		<div class="flex flex-wrap pd border-bottom">
    			<p style="width:100%; color:#999;">公司介绍</p>
    			<p style="text-align:justify;padding:10px;line-height:25px;">物流是指为了满足客户的需求，以最低的成本，通过运输保管、配送等方式，实现原材料、半成品、成品或相关信息进行由商品
    			的产地到商品的消费地的计划、实施和管理的全过程物流是一个控制原材料、制成品、产成品和信息的系统，从供应开始经各种中间
    			环节的转让及拥有而到达最终消费者手中的实物运动，以此实现组织的明确目标现代物流是经济全球化的产物，也是推动经济全球的重要
    			</p>
    		</div>
    	</div>
	</div>
    <!--物流详情页 end-->
    
        @include('wap.community._layouts.js_share')
  
@stop

@section($js)
    <script type="text/tpl" id="x-tkmodaltext-udb">
        <div class="x-tkmodaltext">
            <p class="f18 x-tktitle mb5">{{$content}}</p>
            <p class="f12 tc">可用于抵扣在线支付金额!</p>
        </div>
    </script>
    <script type="text/tpl" id="x-tkmodaltitle-udb">
        <img src="{{ asset('wap/community/newclient/images/couponspic.png') }}" class="x-yhqtktop"><i class="icon iconfont c-white x-over">&#xe604;</i>
    </script>

    @include('wap.community._layouts.gps')
    <script type="text/javascript" src="{{ asset('wap/community/newclient/js/jweixin-1.0.0.js') }}"></script>
    
    
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
				var maxTime=60*60*1000;
				var leaveTime=startTime+maxTime-nowTime;
				if(startTime-nowTime<=0&&startTime+maxTime-nowTime>=0){
					var d=parseInt(leaveTime/(24*60*60));
					var h=parseInt(leaveTime/1000/(60*60));
					var m=parseInt(leaveTime/1000%3600/60);
					var s=parseInt(leaveTime/1000%3600%60);
					m=cleartime(m);
					h=cleartime(h);
					s=cleartime(s);
					boxes[i].className="width box timestart";
					boxes[i].innerHTML="<p>距离结束</p>"+"<p>"+h+":"+m+":"+s+"</p>";
					maxTime-=1000;
				}
				
				if (startTime+maxTime-nowTime<=0) {    //判断倒计时是否结束
					sh=cleartime(sh);
					sm=cleartime(sm);
					boxes[i].className="width box";
					boxes[i].innerHTML="<p>"+sh+":"+sm+"</p>"+"<p>已结束</p>";
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
    </script>
    
    
    
    <script type="text/javascript">
        if("{{$content}}"){
            $.alert($("#x-tkmodaltext-udb").html(),$("#x-tkmodaltitle-udb").html(),function () {
                $.href("{{u("Coupon/index")}}");
            });
            $(".modal-button,.modal-button-bold").html("立即查看");
        }
        $(document).off('click','.x-over');
        $(document).on('click','.x-over', function () {
            $(".modal").removeClass("modal-in").addClass("modal-out").remove();
            $(".modal-overlay").removeClass("modal-overlay-visible");
        });
        var BACK_URL = "{{u('Index/index')}}";
        window.opendoorpage = true;//当前页可以开门

        //微信分享配置文件
        wx.config({
            debug: false, // 调试模式
            appId: "{{$weixin['appId']}}", // 公众号的唯一标识
            timestamp: "{{$weixin['timestamp']}}", // 生成签名的时间戳
            nonceStr: "{{$weixin['noncestr']}}", // 生成签名的随机串
            signature: "{{$weixin['signature']}}",// 签名
            jsApiList: ['checkJsApi','scanQRCode'] // 需要使用的JS接口列表
        });
        $.sao = function(){
            if(window.App){
                window.App.qr_code_scan();
            }else{
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            if(result.indexOf('http')!=-1){
                                $.href(result);
                            }else{
                                $.alert(result);
                            }
                        }
                    });
                })
            }
        }
        function js_qr_code_scan(val){
            if(val.indexOf('http')!=-1){
                App.open_type('{"url":"' + val + '", "open_url_type": "1"}');
            }else{
                $.alert(val);
            }
        }

        //精确定位
        $(function(){
            if(window.App){
                $("#saosao").css('display','block');
            }
            $("#indexAdvSwiper").swiper({"pagination":".swiper-pagination-adv", "autoplay":2500});
            $("#indexNavSwiper").swiper({"pagination":".swiper-pagination-nav"});

            //回到顶部
            $(".content").scroll(function(){
                var windowheight =  $(window).height();
                var topheight = $(".content").scrollTop();
                if (topheight > windowheight*2) {
                    $(".y-backtop").removeClass("none");
                }else{
                    $(".y-backtop").addClass("none");
                }
            })

            var qqcGeocoder = null;
            var clientLatLng = null;
            var now_mapPointStr = "{{$orderData['mapPointStr']}}";
            @if(!empty($orderData['mapPointStr']))
            @if($args['show_prog'] == 1)
                $.gpsPosition(function(gpsLatLng, city, address, mapPointStr){
                var ln = mapPointStr.split(",");
                var strln = ln[0].substring(0,5)+","+ln[1].substring(0,6);
                var ls = now_mapPointStr.split(",");
                var strls = ls[0].substring(0,5)+","+ls[1].substring(0,6);
                if(strln != strls){
                    $.toast('您的定位地址已经发生改变~');
                }
            })
                    @else
                      var clientLatLngs = "{{ $orderData['mapPointStr'] }}".split(',');
            clientLatLng = new qq.maps.LatLng(clientLatLngs[0], clientLatLngs[1]);
            @endif
        @else
            $.gpsPosition(function(gpsLatLng, city, address, mapPointStr){
                $.router.load("{{u('Index/index')}}?address="+address+"&mapPointStr="+mapPointStr+"&city="+city, true);
            })
            @endif

            $(document).on("touchend",".data-content ul li",function(){
                var id = parseInt($(this).data('id'));
                if (id > 0)
                {
                    $.router.load("{{u('Seller/detail')}}" + "?staffId=" + id, true);
                }
            });

            $.computeDistanceBegin = function ()
            {
                if (clientLatLng == null) {
                    return;
                }

                $(".compute-distance").each(function ()
                {
                    var mapPoint = new qq.maps.LatLng($(this).attr('data-map-point-x'), $(this).attr('data-map-point-y'));
                    $.computeDistanceBetween(this, mapPoint);
                    $(this).removeClass('compute-distance');
                })
            }

            $.computeDistanceBetween = function (obj, mapPoint)
            {
                var distance = qq.maps.geometry.spherical.computeDistanceBetween(clientLatLng, mapPoint);
                if (distance < 1000)
                {
                    $(obj).html(Math.round(distance) + 'M');
                } else
                {
                    $(obj).html(Math.round(distance / 1000 * 100) / 100 + 'Km');
                }
            }

            $.SwiperInit = function (box, item, url)
            {
                $(box).infinitescroll({
                    itemSelector: item,
                    debug: false,
                    dataType: 'html',
                    nextUrl: url
                }, function (data)
                {
                    $.computeDistanceBegin();
                });
            }

            // $.computeDistanceBegin();

            //重新定位
            $.relocation = function(){
                //异步Session清空
                $.post("{{ u('Index/relocation') }}",function(){
                    $.router.load("{{ u('Index/index') }}", true);
                })
            }


            //是否有展开箭头
            $.lieach = function(){
                $(".list-block ul li.each").each(function(){
                    var innerh = $(this).find(".y-mjyh li").length;
                    if (innerh >= 3) {
                        $(this).find(".y-mjyh .y-i1").removeClass("none");
                        $(this).find(".y-mjyh li").last().addClass("none");
                    }
                })
            }
            $.lieach();

            // 促销展开与收起
            $(document).off('click','.y-mjyh');
            $(document).on('click','.y-mjyh', function () {
                if($(this).find("li").length <= 2){
                    return false;
                }
                if($(this).hasClass("active")){
                    $(this).removeClass("active");
                    $(this).find(".y-unfold").addClass("none").siblings("i.y-i1").removeClass("none");
                    $(this).find("li").last().addClass("none");
                }else{
                    $(this).addClass("active");
                    // $(this).css("height",44);
                    $(this).find(".y-unfold").removeClass("none").siblings("i.y-i1").addClass("none");
                    $(this).find("li").last().removeClass("none");
                }
            });

            //上拉
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
                data.status = "{{ $args['status'] }}";

                $.post("{{ u('Index/indexList') }}", data, function(result){
                    groupLoading = false;
                    $('.infinite-scroll-preloader').addClass('none');
                    result  = $.trim(result);
                    if (result != '') {
                        groupPageIndex++;
                        $('#wdddmain').append(result);
                        $.computeDistanceBegin();
                        $.refreshScroller();
                    }else{
                        $(".allEnd").removeClass('none');
                        nopost = 1;
                    }
                });
            });


            //ajax加载商家或者商品列表
            var ajaxData = {page:1, status:"{{ $args['status'] }}"};
            var ajaxObj = $("#wdddmain");
            var ajaxUrl = "{{ u('Index/indexList') }}";
            $.ajaxListFun(ajaxObj, ajaxUrl, ajaxData, function(result){
                $.computeDistanceBegin();
            });

        });


        if(window.App && parseInt({{$loginUserId}})>0){
            var result = getDoorKeys();
            window.App.doorkeys(result.responseText);
        }

        //滑动时头部的显示
        $(".content").scroll(function(){
            var top=$(".content").scrollTop();
            var opacity=top/100;
            if (opacity>=0.7) {
                $(".y-toptransparent").css("background","rgba(255,45,75,.7)");
                $(".y-toptransparent .title").css("background","rgba(225,225,225,.8)");
            }else{
                $(".y-toptransparent").css("background","rgba(255,45,75,"+opacity+")");
                $(".y-toptransparent .title").css("background","rgba(225,225,225,0.6)");
            };
        });
    </script>
@stop