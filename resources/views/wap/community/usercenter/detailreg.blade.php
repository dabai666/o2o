@extends('wap.community._layouts.base')
@section('show_top')
<header class="bar bar-nav">
	<a class="button button-link button-nav pull-left" href="{{ u('UserCenter/index') }}">
		<span class="icon iconfont">&#xe600;</span>返回
	</a>
	<h1 class="title f16">完善信息</h1>
	<a class="button button-link button-nav pull-right" href="tel:4008057588"><img src="../images/callreg.png" style="width:50%;vertical-align:middle;" /></a>
</header>
@stop

@section('css')
<style type="text/css">
.detail-title{color:#6c6c6c;background:#f5f5f5;text-align:center;font-size:.6rem;font-weight:bold;padding:.2rem 0;}
.detail{padding:0 1rem;}
.info li{border-bottom:1px solid #f4f4f4;padding:.6rem 0;font-size:.7rem;font-weight:bold;}
.info li span{color:#5a5b5c;display:inline-block;width:26%;font-family: "Microsoft YaHei" !important;}
.info li input{font-size:.65rem!important;width:70%;}
.info-address li{border:none;padding:1rem 0 0 0;}
.info-address input{border-bottom:1px solid #f4f4f4;padding-bottom:.5rem; }
.info-address select{border:none;border-bottom:1px solid #f4f4f4;padding-bottom:.5rem;width:70%;}
.prompt{position:absolute;right:8%;font-weight:normal;width:15% !important;}
.submit{font-size:.6rem;margin-top:1rem;}
.submit p{text-align:center;}
.submit input{width:100%;background:#ccc;color:#fff;font-size:.8rem!important;border-radius:.25rem;padding:.4rem 0;margin-top:1rem;}
#nowaddress{background:red;padding:1%;width:auto !important;color:#fff;}
.pos{margin-top:-2.5rem;}
.showtag p{display:inline-block;width: 70%;}
.showtag .tag{background: #4c9fed;color: #fff;width: auto; padding: 0 .2rem;margin:0 2px;font-size: .6rem;}
.shoptag{display: none;max-height:4.5rem;overflow: auto;}
.shoptag li{display:inline-block;padding:.2rem;font-weight:normal;font-size:.6rem;border:none;background:#ccc;color:#fff;margin-top:.2rem;}
.choose{background: red;}
</style>
@stop

@section('content')
<div class="content" style="background:#fff;">
	<div class="detail-title">门店信息</div>
	<div class="detail">
		<div class="info">
			@if(!$detailInfo['address'] || $detailInfo['address'] === null)
			<div class="info-address">
				<ul>
					<li class="@if(!Input::get('city') && !Input::get('cityId')) none @endif">
						<span>定位城市：</span>
						<input class="cityurl" id="city" type="text" placeholder="@if($data['city']['name']){{ $data['city']['name'] }} @else 点击选择城市 @endif" value="{{Input::get('city')}}" />
						<span class="prompt">更改城市</span>
					</li>
					<li class="provinces @if(!$data['detailAddress']) none @endif">
						<span>定位省市：</span>
						<select name="area" id="area" style="padding-right:3.5rem;">
						@foreach($city as $key)
							<option value="{{ $key['id'] }}">{{ $key['name'] }}</option>
						@endforeach
						</select>
					</li>
					<li>
						<span>地址：</span>
						<input id="address" type="text" placeholder="点击选择地址" value="@if($data['detailAddress']){{ $data['detailAddress'] }} @endif" />
						@if($data['detailAddress'])
						<span class="prompt pos" id="nowaddress">重新定位</span>
						@else
						<span class="prompt" id="nowaddress">立即定位</span>
						@endif
						
					</li>
					<li>
						<span></span>
						<input id="doorplate" type="text" placeholder="输入楼号门牌号等详细信息" />
					</li>
				</ul>
				@if($data['id'] > 0)
                    <!-- 编辑 -->
                    @if(!empty($data['mapPoint']) && !is_array($data['mapPoint']))
                        <input type="hidden" id="map_point" value="{{$data['mapPoint']}}"/>
                    @else
                        <input type="hidden" id="map_point" value="{{$data['mapPointStr']}}"/>
                    @endif
                @else
                    <!-- 新增 -->
                    <input type="hidden" id="map_point" value="{{$data['mapPoint']}}"/>
                @endif
	                <input type="hidden" id="id" value="{{ $data['id'] }}" />
	                <input type="hidden" id="city_id" value="{{ $data['cityId'] }}" />
			</div>
			@endif
			<div class="info-common">
				<ul>
					<li>
						<span>门店名称</span>
						<input type="text" name="shopname" placeholder="请输入完整真实的门店名称" value="{{ $detailInfo['info']['shopname'] }}" />
					</li>
					<li>
						<span>负责人</span>
						<input type="text" name="personcharge" placeholder="店长姓名（请输入真实姓名）" value="{{ $detailInfo['info']['personcharge'] }}" />
					</li>
					<li>
						<span>手机号码</span>
						<input type="text" name="phone" placeholder="手机号码（请输入真实手机）" value="{{ $detailInfo['info']['phone'] }}" />
					</li>
					@if($detailInfo['info'] && $detailInfo['info'] !== null)
					<li class="showtag">
						<span>门店类型</span>
						<p>
							@foreach($shoptypeOwn as $key)
								@foreach($shoptype as $k)
									@if($k['id'] == $key)
									<span class="tag" >{{ $k['name'] }}</span>
									@endif
								@endforeach
							@endforeach
						</p>
					</li>
					@else
					<li class="showtag">
						<span>门店类型</span>
						<p></p>
						<span class="prompt shopprompt" style="width:auto !important;">展开</span>
					</li>
					<div class="shoptag">
						<ul>
							@foreach($shoptype as $k)
							<li data-id="{{ $k['id'] }}" style="">{{ $k['name'] }}</li>
							@endforeach
						</ul>
					</div>
					@endif
				</ul>
			</div>
		</div>
		@if(!$detailInfo['info'] || $detailInfo['info'] === null)
		<div class="submit">
			<p>如果有任何疑问，可直接拨打客服热线<a href="tel:4008057588" style="color:#4790df;">4008-057-588</a>咨询。</p>
			<input class="check" type="submit" value="提交" />
		</div>
		@endif
	</div>
</div>
@stop

@section($js)
@include('wap.community._layouts.gps')
<script type="text/javascript">
	var cityurl  = "{!! urldecode(u('Index/cityservice',['type'=>4])) !!}";
	$(function($){	
		$(document).on("touchend",".cityurl",function(){
			$.router.load(cityurl, true);
		});
		
		$("#nowaddress").click(function(){
            $.showPreloader('定位中请稍候...');
            $.gpsPosition(function(gpsLatLng, city, address, mapPointStr, area){
                $.hidePreloader();
                var data = {
                    "address":address,
                    "mapPointStr":mapPointStr,
                    "city":city,
                    "area":area
                };
                $.post("{{ u('UserCenter/saveMap') }}",data,function(res){
                    if(res.code == 1){
                        $.toast("抱歉，当前城市未开通服务，请选择其他城市吧");
                    }else{
                        $("#address").val(address);
                        $("#city").val(city);
                        $("#city").parent().removeClass('none');
                        $("#map_point").val(mapPointStr);
                        $("#city_id").val(res.data.id);
                        areaSelect = "";
                        areas = res.data.areas;
                        if(areas.length > 0){
                            for(i = 0; i < areas.length; i++){
                                if(res.data.area.id == areas[i].id){
                                    areaSelect += "<option selected value='"  + areas[i].id + "'>" + areas[i].name + "</option>";
                                } else {
                                    areaSelect += "<option value='"  + areas[i].id + "'>" + areas[i].name + "</option>";
                                }

                            }
                            $("#area").append(areaSelect);
                            $(".provinces").removeClass("none");
                            $("#nowaddress").addClass("pos").html("重新定位");
                            checkstatus();
                        }
                    }
                },"json");
            })
        });
		
        $(document).on("touchend","#address",function(){
        	@if(Input::get('cityId'))
        	var mapurl = "{!! urldecode(u('UserCenter/addressmap',['type'=>1,'address'=>Input::get('city'),'mapPointStr'=>Input::get('mapPointStr'),'cityId'=>Input::get('cityId')])) !!}";
			@else
			var mapurl = "{!! urldecode(u('UserCenter/addressmap',['type'=>1,'address'=>$defaultAddress['address'],'mapPointStr'=>$defaultAddress['mapPointStr'],'cityId'=>$defaultAddress['cityId']])) !!}";
			@endif
            var data = getData();
            $.post("{{ u('UserCenter/saveAddrData',['SetNoCity'=>Input::get('SetNoCity')]) }}",data,function(res){
                $.href(mapurl);
            },"json");
            
        });

		$(document).on("touchend",".check",function(){
			@if($detailInfo['address'] || $detailInfo['address'] !== null)
			checksubmit(false);
			@else
			checksubmit(true);
			@endif
		});

		function checksubmit(status){
			if(checkstatus() !== true){
				return;
			}
			if(status === true){
				$.showPreloader('正在添加常用地址');
				var data = getData();
				$.post("{{ u('UserCenter/saveaddress') }}",data,function(res){
					$.hidePreloader();
					if(res.code == 0){
						$.showPreloader('正在保存个人信息');
						var checkData = getcheckData();
						checkData.addressid = res.data.id;
						$.post("{{ u('UserCenter/saveDetailreg') }}",checkData,function(res){
							$.hidePreloader();
							console.log(res);
			                if(res.code == 0){
			                	alert('保存成功');
			                	window.location.href = "{{ u('index/index') }}";
			                }else{
			                	alert('保存失败！请重新填写');
			                	window.location.href = "{{ u('UserCenter/detailreg') }}";
			                }
			            },"json");
					}else{
						alert(res.msg);
					}
	            },"json");
			}else{
				$.showPreloader('正在保存个人信息');
				var checkData = getcheckData();
				$.post("{{ u('UserCenter/saveDetailreg') }}",checkData,function(res){
					$.hidePreloader();
					console.log(res);
	                if(res.code == 0){
	                	alert('保存成功');
	                	window.location.href = "{{ u('index/index') }}";
	                }else{
	                	alert('保存失败！请重新填写');
	                	window.location.href = "{{ u('UserCenter/detailreg') }}";
	                }
	            },"json");
			}
		}
		
		
		function getData(){
			var obj = new Object();
			obj.id = $.trim($("#id").val());
			obj.name = $.trim($("input[name=personcharge]").val())
			obj.mobile = $.trim($("input[name=phone]").val());
			obj.detailAddress = $.trim($("#address").val());
			obj.mapPoint = $.trim($("#map_point").val());
			obj.doorplate = $.trim($("#doorplate").val());
			obj.cityId = $.trim($("#city_id").val());
			obj.areaId = $.trim($("#area").val());
			obj.SetNoCity = "{{ Input::get('SetNoCity') }}";
			obj.isreg = 1;
			return obj;
		}
		function getcheckData(){
			var obj = new Object();
			obj.shopname = $.trim($('input[name=shopname]').val());
			obj.personcharge = $.trim($('input[name=personcharge]').val());
			obj.shoptype = $.trim(getShopTag());
			obj.phone = $.trim($('input[name=phone]').val());
			return obj;
		}

		function checkstatus(){
			var shopname = $('input[name=shopname]').val();
			var personcharge = $('input[name=personcharge]').val();
			var shoptype = getShopTag();
			var phone = $('input[name=phone]').val();
			var city = $('#city').val();
			var address = $('#address').val();
			if(shopname == "" || shopname === null || !shopname){
				$('.check').css('background','#ccc');
				return;
			}
			if(personcharge == "" || personcharge === null || !personcharge){
				$('.check').css('background','#ccc');
				return;
			}
			if(shoptype == "" || shoptype === null || !shoptype){
				$('.check').css('background','#ccc');
				return;
			}
			if(phone == "" || phone === null || !phone){
				$('.check').css('background','#ccc');
				return;
			}
			if(city == "" || city === null || !city){
				$('.check').css('background','#ccc');
				return;
			}
			if(address == "" || address === null || !address){
				$('.check').css('background','#ccc');
				return;
			}
			$('.check').css('background','red');
			return true;
		}

		function getShopTag(){
			//获取店铺类型
			var shoptag = "";
			$.each($('.showtag .tag'),function(){
				shoptag += $(this).data('id') + ',';				
			});
			shoptag = shoptag.substr(0,shoptag.length - 1);//删除结尾的逗号
			return shoptag;
		}

		$('input').bind("keyup",function(){
			checkstatus();
		});

		$('.showtag').bind('click',function(){
			$('.shoptag').toggle();
			var shoptext = $('.shopprompt').html();
			if(shoptext == '展开'){
				$('.shopprompt').html('收起');
			}else{
				$('.shopprompt').html('展开');
			}
		});
		$('.shoptag li').bind('touchend',function(){
			var dataid = $(this).attr('data-id');
			var tagnum = $('.showtag .tag').length;
			var choose = $(this);
			if(tagnum == 0){
				choose.css('background','#4c9fed');
				$('.showtag p').append("<span class='tag' data-id='" + $(this).attr('data-id') + "'>" + $(this).html() + "</span>");
			}else if(tagnum == 1){
				if($('.showtag .tag').data('id') == dataid){
					$('.showtag .tag').remove();
					choose.css('background','#ccc');
				}else{
					choose.css('background','#4c9fed');
					$('.showtag p').append("<span class='tag' data-id='" + $(this).attr('data-id') + "'>" + $(this).html() + "</span>");
				}
			}else if(tagnum == 2){
				$.each($('.showtag .tag'),function(){
					if($(this).data('id') == dataid){
						$(this).remove();
						choose.css('background','#ccc');
					}
				});
			}else{
				return;
			}
			checkstatus();
		});
			
	});
</script>
@stop