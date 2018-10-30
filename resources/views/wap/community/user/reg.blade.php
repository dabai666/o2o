@extends('wap.community._layouts.base')
@section('show_top')
<img src="/images/APP.png" />
    <header class="bar bar-nav">
        @if($args['id'] > 0)
            <!-- 邀请注册不显示返回按钮 -->
        @else
            <a class="button button-link button-nav pull-left back isExternal" href="@if(!empty($nav_back_url)) {{ $nav_back_url }} @else javascript:$.back(); @endif" data-transition='slide-out'>
                <span style="color: green;" class="icon iconfont">&#xe600;</span>
                <span style="color: green;">返回</span>
            </a>
        @endif
    <!--<h1 class="title f16">注册账号</h1>-->
    </header>
@stop

@section('css')
    <style type="text/css">
        input#vcode_input{height: 40px;width: 100px;border: 1px solid #ced6dc;}
        .x-tkfont{padding: 2em 10px;font-size: .875em;color: #999;max-height: 260px;overflow: auto;}
        .content input{
        	border-radius: 2.2rem;
        	width: 15rem;
        	height: 2.3rem;
        	margin-left: 1.6rem;
        	box-shadow: 0.1rem 0.1rem 0.1rem ;
        }
        .content i{
        	margin-left: 1.7rem;
        	color: green;
        }
        .content b{
        	margin-right: 1.5rem;
        }
        .yzmbutton{
        	color: white;
        	border: 0.1rem solid #30b15e;
        	background: #30b15e;
        	position: absolute;
        	margin-left: -5rem;
        	margin-top: 0.5rem;
        	width: 4rem;
        	text-align: center;
        	border-radius: 0.1rem;
        }
        .mt15 p {
        	margin-left: 2rem;
        }
        .Determine{
        	background:#30b15e;
        	color: white;
        	border: solid #30b15e;
        	width: 15rem;
        	border-radius: 1rem;
        	margin-left: 1.6rem;
        }
        .Jump{
        	padding-left: 6.5rem;
        	color:#30b15e;
        }
        input.inptet::-webkit-input-placeholder {/*Chrome/Safari*/
    color:#deacac;
    }
    input.inptet: :-moz-placeholder {/*Firefox*/
    color:#deacac;
    }
    　input.inptet: :-ms-input-placeholder {/*IE*/
       color:#deacac;
    } 
    </style>
@stop

@section('content')
    <div class="content" id="page-reg">
    	<div style="z-index: 1;" class="logo">
    		<img style="margin-left:5em;" src="/images/APPlogo.png" />
    	
        <div style="margin-top: -4.5rem;" class="y-box">
            <div class="y-input y-account">
                <i style="margin-top: -0.5rem;" class="icon iconfont">&#xe65d;</i>
                <input   type="number" name="cellphone" id="cellphone" class="input tel f12" value="" placeholder="手机号码" maxlength="11">
                <b style="color:#d0d0d0; font-size: 0.9rem; margin-top: 0.8rem;margin-left: -2em; position: absolute;" class="icon iconfont eye" id="adc">&#xe605;</b>
            </div>           
            <div class="y-input y-password y-pswd">
                <i class="icon iconfont">&#xe63b;</i>
                <input type="password" name="password" id="password" class="inptet password f12" value="" placeholder="请输入6-20位密码">
                <b style="color:#d0d0d0;" class="icon iconfont eye">&#xe657;</b>
            </div>
            <div class="y-input y-password y-pswd">
                <i class="icon iconfont">&#xe63b;</i>
                <input type="password" name="password_new" id="password_new" class="inptet f12" value="" placeholder="再次确认密码">
                <b style="color:#d0d0d0;" class="icon iconfont eye">&#xe657;</b>
            </div>
            
            <div class="y-input y-yzm">
            	<i style="margin-top: -0.6rem;" class="icon iconfont">&#xe661;</i>
                <input style="border-radius: 2.2rem;width: 15rem;padding-left: 2rem;" type="text" name="identify" id="identify" class="inptet f12" value="" placeholder="请输入验证码">
                @if($vcodeType == 1)
                    <a href="#" class="button button-big button-fill button-danger" id="getmask" data-backfunction="$.checkverify()">获取验证码</a>
                @else
                 
                 <!--  <a ref="javascript:getCode()" class="button  button-success button-danger" id="getCode">获取验证码</a>-->
                 <a href="javascript:getCode()" class="yzmbutton" id="getCode">获取验证码</a>
                @endif
            </div>
            <div class="mt15">
            	<p>注册视为同意<a href="{{ u('More/detail',['code'=>1]) }}" class="d-declare c-green f12">《用户注册协议》</a></p><br/>
                <a href="javascript:reg();" class="button button-big Determine"  id="reg" >注册</a><br/>
                <a class="Jump">已有账号？登陆</a>
            </div>
           
        </div>
    </div>
    </div>
    <!-- 互动验证码 -->
    @include('wap.community._layouts.slide_auth_code')
@stop

@section($js)
    <script type="text/javascript">
        var getcode_url = "{{ u('User/verify') }}";
        var path = "{!! u('User/imgverify')!!}?random=" + Math.random();

        //发送验证码
        function getCode() {
            if($("#getCode").attr("banned") == "false"){
                return false;
            }
			@if($vcodeType == 0)
				var modal = $.modal({
					title: '请输入图片验证码',
					text: '',
					afterText:  '<div class="yz_color_style verifynotice">'+
					'<div class="m-tkbg">'+
					'<div class="x-tkbg">'+
					'<div class="x-tkbgi">'+
					'<div class="m-tkny">'+
					'<div class="m-tkinfor">'+
					'<p class="x-tkfont m-tktextare x-imgverify" style="padding: 2em 10px;font-size: .875em;color: #999;max-height: 260px;overflow: auto;">'+
					'<input id="vcode_input" type="text" name="imgverify" class="fl" style="height: 40px;width: 100px;border: 1px solid #ced6dc;">'+
					'<img src="{{ u('User/imgverify')}}" class="fl ml10" id="imgverify">'+
					'<span id="changeimg" class="fl ml10 mt15" style="cursor:pointer;"> 换一张</span>'+
					'</p>'+
					'</div>'+
					'</div>'+
					'</div>'+
					'</div>'+
					'</div>'+
					'</div>',
					buttons: [
						{
							text: '返回'
						},
						{
							text: '确定',
							bold: true,
							onClick: function () {
								$.checkverify();
							}
						},
					]
				});
			@else
				$.checkverify();
			@endif
        }

        $(document).on("touchend","#changeimg",function(){
            $("input[name=imgverify]").empty();
			path = "{!! u('User/imgverify')!!}?random=" + Math.random();
            $("#imgverify").attr('src',path);
        });


        $(document).on("touchend",".canver",function(){
            // $('.verifynotice').addClass('none').hide();
			path = "{!! u('User/imgverify')!!}?random=" + Math.random();
            $("input[name=imgverify]").empty();
            $("#imgverify").attr('src',path);
        });

        //默认验证码发送
        $.checkverify = function(){
            var imgverify = $("input[name=imgverify]").val();
            mobile = $("#cellphone").val();
            if(mobile != ""){
                var reg = /^1[\d+]{10}$/;
                if(!reg.test(mobile)){
                    $.toast('请输入正确的手机号码');
                    return false;
                }
            }else{
                $.toast("手机号码不能为空");
                return false;
            }
            var data = {
                mobile:mobile,
                type:'reg_check',
                imgverify:imgverify
            };
            $.post(getcode_url,data,function(result){
                if(result.code == 0){
                    $.lastTime();
                    $("#imgverify").attr('src',path);
                    $("input[name=imgverify]").empty();
                    $.toast(result.msg);
                }else{
                    $("#imgverify").attr('src',path);
                    $.toast(result.msg);
                }

            },'json');
        }

        //倒计时
        var wait = 60;//获取验证码等待时间(秒)
        $.lastTime = function(){
            if (wait == 0) {
				$('#getmask').bind("click",function(){
					getYzm();
				});
				$("#getmask").attr("banned","true").css("background-color","rgb(82, 178, 246)").css("font-size","0.875em").removeClass("last-time");
                $("#getmask").html("重新发送");
                $("#getCode").attr("banned","true").css("background-color","rgb(82, 178, 246)").css("font-size","0.875em").removeClass("last-time");
                $("#getCode").html("重新发送");
                wait = 60;
            } else {
				$('#getmask').unbind("click");
				if($("#getmask").hasClass("last-time") == false){
                    $("#getmask").css("font-size","10px").css("background-color","gray");
                    $("#getmask").addClass("last-time")
                }
                $("#getmask").attr("banned","false");//倒计时过程中禁止点击按钮
                $('#getmask').html(wait + "s 后重新发送");//改变按钮中value的值
                if($("#getCode").hasClass("last-time") == false){
                    $("#getCode").css("font-size","10px").css("background-color","gray");
                    $("#getCode").addClass("last-time")
                }
                $("#getCode").attr("banned","false");//倒计时过程中禁止点击按钮
                $('#getCode').html(wait + "s 后重新发送");//改变按钮中value的值
                wait--;
                setTimeout(function() {
                    $.lastTime();//循环调用
                },1000)
            }
        }

        var noreg = 0;
        function reg() {
            var isGuide = "{{(int)$args['isGuide']}}";
            var mobile = $("#cellphone").val();
            var verify = $("#identify").val();
            var pwd = $("#password").val();
            var pwds = $("input[name=password_new]").val();
            var reg = /^1[3|4|5|7|8][0-9]\d{8}$/;
            if(!reg.test(mobile)){
                $.toast("请输入正确的手机号码");
                return false;
            }
            var data = {
                mobile:mobile,
                pwd:pwd,
                verifyCode:verify,
                pwds:pwds,
                isGuide:isGuide
            };

            @if($vcodeType == 1)
                
            @else
                if(data.verifyCode ==  ''){
                    $.toast("请输入验证码");
                    return false;
                }
            @endif

            if(data.pwd == '' || data.pwds == ''){
                $.toast("密码不能为空");
                return false;
            }
            if(data.pwd != data.pwds){
                $.toast("两次密码密码不一致");
                return false;
            }

            if({{$args['id'] or 0}} > 0){
                data.invitationType = "{{$args['type']}}";
                data.invitationId = "{{$args['id'] or 0}}";
            }

            noreg = 1;
            $.showPreloader("注册中...");
            $.post("{{ u('User/doreg') }}",data,function(res){
                $.hidePreloader();
                if(res.code == 0){
                    {{--window.location.href = "{{u('UserCenter/index')}}";--}}
                    $.regPushDevice(res.data.id,"{!! $return_url !!}");
                }else{
                    noreg = 0;
                    $.toast(res.msg);
                }
            },"json");
        }

        function js_apns(devive,token){
            var data = new Object();
            data.devive = devive;
            data.apns = token;
            data.id = FANWE.PUSH_REG_ID;

            $.post("{!! u('UserCenter/regpush') !!}", data, function(result){
                window.location.href = "{!! $return_url !!}";
            });
        }

        //部分IOS返回刷新
        if($.device['os'] == 'ios')
        {
            $(".isExternal").addClass('external');
        }
       
		$(function(){
			$("#adc").click(function(){
				$("#cellphone").val("");
			});
		});
    </script>
@stop