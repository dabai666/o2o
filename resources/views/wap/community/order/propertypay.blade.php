@extends('wap.community._layouts.base')

@section('show_top')
<header class="bar bar-nav">
    <a class="button button-link button-nav pull-left" href="javascript:cancell_back();" data-transition='slide-out'>
        <span class="icon iconfont">&#xe600;</span>返回
    </a>
    <h1 class="title f16">收银台</h1>

</header>
@stop

@section('content')
    <!-- new -->
    <div class="content" id=''>
        <div class="list-block y-syt">
            <ul>
                <li class="item-content">
                    <div class="item-inner">
                        <div class="item-title c-gray">合计</div>
                        <div class="item-after c-red">￥{{ number_format($data['payFee'], 2) }}</div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="content-block-title f14 c-gray"><i class="icon iconfont mr10">&#xe638;</i>支付方式</div>
        <ul class="y-paylst">
            @if($payments)
                @if($balance >= $data['payFee']) 
                <?php
                    $default_payment = 'balancePay';
                ?>
                <li class="@if($balance >= $data['payFee']) on @endif" data-code="balancePay">
                    <img src="{{ asset('wap/community/newclient/images/ico/zf5.png') }}" />
                    <div class="y-payf"><p>余额<span>{{ number_format($balance,2) }}</span>元</p></div>
                    <i class="icon iconfont">&#xe612;</i>
                </li> 
                @endif
                @foreach($payments as $key => $pay)
                <?php
                if (empty($default_payment) && $data['user']['balance'] < $data['payFee']){
                    $default_payment = $pay['code'];
                }
                ?>
                <li class="@if($pay['code'] == $default_payment) on @endif" data-code="{{ $pay['code'] }}">
                    <?php
                    switch ($pay['code']) {
                        case 'alipay':
                        case 'alipayWap':
                            $icon = asset('wap/community/client/images/ico/zf3.png');
                            break;
                        case 'weixin':
                        case 'weixinJs':
                            $icon = asset('wap/community/client/images/ico/zf2.png');
                            break;
                        case 'unionpay':
                        case 'unionapp':
                            $icon = asset('wap/images/ico/yl.png');
                            break;
                    }
                    ?>
                    <img src="{{ $icon }}" />
                    <div class="y-payf">{{ $pay['name'] }}</div>
                    <i class="icon iconfont">&#xe612;</i>
                </li>
                @endforeach
            @endif
        </ul>
        <p class="y-bgnone"><a href="#" class="y-paybtn f16 x-paybtn">确认支付</a></p>
    </div>
@stop

@section($js)
    <script type="text/tpl" id="pay-password">
        <div class="y-payinput">
                    <input type="passWord" maxlength="1"  name="paypwd">
                    <input type="passWord" maxlength="1"  name="paypwd">
                    <input type="passWord" maxlength="1" name="paypwd">
                    <input type="passWord" maxlength="1"  name="paypwd">
                    <input type="passWord" maxlength="1"  name="paypwd">
                    <input type="passWord" maxlength="1"  name="paypwd">
                </div>
                <div class="tr y-wjmm"><a href="{{ u('UserCenter/repaypwd', ['pay' => 1, 'orderId' => $data['id']]) }}" class="c-red f12">忘记密码?</a></div>
    </script>
<script type="text/javascript">
    var payment = "{{ $default_payment }}"; 
    var ids = "{{$args['ids']}}";
    var key = "";
    $(document).on("touchend",".y-paylst li",function(){
        $(".y-paylst li").removeClass("on");
        $(this).addClass("on");
        payment = $(this).data("code"); 
    }); 

    $(document).on("touchend", ".x-paybtn", function (){ 
        if(payment == 'balancePay'){
            var isPayPwd = "{{ $isPayPwd }}";
            if (isPayPwd == 1){
                $.showPayPwdModal();
            }else{
                $.toast("请先设置支付密码");
                $.router.load("{!! u('UserCenter/paypwd', ['pay' => 1, 'orderId' => $data['id']]) !!}", true);
            }
        }else{
            btnOK_onclick();
        }
    })

    $(document).on("keyup","input[name=paypwd]", function (e) {
        if(e.keyCode == 8){
            $("input[name=paypwd]").val("");
            $("input[name=paypwd]").eq(0).focus();
        }else{
            var index = $(this).index();
            if($(this).val() != ""){
                $("input[name=paypwd]").eq(parseInt(index)+1).focus();
            }
            if(index == 5){
                var pwd = "";
                $("input[name=paypwd]").each(function(){
                    pwd += $(this).val();
                })
                $(".modal").removeClass("modal-in").addClass("modal-out").remove();
                $(".modal-overlay").remove();
                $.showPreloader('确认支付中...');
                $.post("{{ u('UserCenter/checkpaypwd') }}", {password : pwd}, function(res){
                    if(res.status){
                        key = res.data;
                        btnOK_onclick();
                    }else{
                        $.hidePreloader();
                        $.toast(res.msg);
                    }
                },"json");
            }
        }

    })


    $(document).on("touchend", ".close-modal", function(){
        $(".modal").removeClass("modal-in").addClass("modal-out").remove();
        $(".modal-overlay").remove();
    })

    $.showPayPwdModal = function(){
        $.modal({
            title:  '<div class="y-paytop"><i class="icon iconfont c-gray fl close-modal">&#xe604;</i><p class="c-black f18 tc">输入支付密码</p></div>',
            text: $("#pay-password").html()
        })
    }

    // 支付
    function btnOK_onclick()
    {
        try
        {
            var url = "{{u('Order/createPropertyPay')}}?payment=" + payment + "&propertyFeeId="+ids+"&key="+key;
            // alert(url);return;
            if (window.App && payment != "balancePay" && typeof(payment) != "undefined")
            {   
                $.showIndicator();          
                var result = $.ajax({ url: url, async: false, dataType: "text"});
                $.toast('loading...',5000);
                window.App.pay_sdk(result.responseText);
                $.hideIndicator();
            } else { 
                window.location.href = url; 
            }
        }
        catch (ex)
        {
        }
    }
    // 回调函数
    function PayComplete(result)
    {
        if(result == "Success")
        {
            $.router.load("{{ u('Property/index') }}", true);
        }
    }
    function cancell_back(){
        $.confirm('确认取消支付吗？', '取消支付', function () {
            $.back();
        });
    }
</script>
@stop
