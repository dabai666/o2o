@extends('wap.community._layouts.base')

@section('show_top')
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left isExternal" href="{{u('UserCenter/index')}}" data-transition='slide-out'>
            <span class="icon iconfont">&#xe600;</span>返回
        </a>
        <h1 class="title f16">我的收藏</h1>
		<a class="pull-right" href="{{ u('GoodsCart/index') }}"><span class="icon iconfont">&#xe673;</span></a>
    </header>
@stop

@section('content')
    <div class="content infinite-scroll infinite-scroll-bottom pull-to-refresh-content" data-ptr-distance="55" data-distance="50" id=''>
        <div class="pull-to-refresh-layer">
            <div class="preloader"></div>
            <div class="pull-to-refresh-arrow"></div>
        </div>

        <div class="y-scbtn">
            <div class="buttons-row">
                <a href="{{ u('UserCenter/collect',['type'=>1])}}" class="button y-sc1 @if($args['type'] == 1) on @endif">商品</a>
                <a href="{{ u('UserCenter/collect',['type'=>2])}}" class="button y-sc2 @if($args['type'] == 2) on @endif">店铺</a>
            </div>
        </div>
        @if(!empty($list))
            <div class="list-block media-list y-sylist">
                <ul id="list">
                    @include('wap.community.usercenter.collect_item')
                </ul>
            </div>
        @else
            <div class="x-null pa w100 tc">
                <i class="icon iconfont">&#xe645;</i>
                <p class="f12 c-gray mt10">很抱歉，你还没有收藏！</p>
            </div>
        @endif
        <!-- 加载完毕提示 -->
        <div class="pa w100 tc allEnd none">
            <p class="f12 c-gray mt5 mb5">数据加载完毕</p>
        </div>
        <!-- 加载提示符 -->
        <div class="infinite-scroll-preloader none">
            <div class="preloader"></div>
        </div>
    </div>
	<style>
	#explain{width:100%;height:100%;}
	.ebj{width:100%;height:100%;z-index:98;position:absolute;background:#000;filter:alpha(opacity=40);-moz-opacity:0.4;opacity: 0.4;}
	.econt{width:80%;z-index:99;position:absolute;top:25%;left:10%;background:#fff;border-radius:10px;padding:15px;overflow-y:auto;}
	.econt-title{border-bottom:solid #ccc 1px;padding-bottom:.5rem;}
	.econt-choose{border-bottom:solid #ccc 1px;padding:1rem 0;}
	.econt-num{padding-top:.5rem;}
	.choose_s{border-radius:.15rem;color:#313233;padding:.2rem .5rem;;display:inline-block;border:1px solid #ccc;margin-right:.5rem;}
	.choose_e{background:#ff2d4b;color:#fff;border:1px solid #ff2d4b;}
	</style>
	<div id="explain" class="none">
		<div class="ebj"></div>
		<div class="econt">
			<div class="econt-title">
				<p>商品名称<i class="icon iconfont c-gray fr" id="close">&#xe604;</i></p>
			</div>
			<div class="econt-choose">
				<div class="econt-norms none">
					<p style="padding-bottom:.5rem;">选择规格</p>
					<div class="norms"></div>
				</div>
				<div class="econt-process none">
					<p style="padding:.5rem 0;">加工方式</p>
					<div class="process"></div>
				</div>
			</div>
			<div class="econt-num">
				<span style="color:red;">￥</span>
				<span class="price" style="color:red;">0</span>
				<span class="icon iconfont c-red add fr" style="font-size:1.1rem;">&#xe61e;</span>
				<span class="number fr none" style="width:1.3rem;text-align:center;">0</span>
				<span class="icon iconfont c-red subtract fr none" style="font-size:1.1rem;">&#xe621;</span>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$('.subtractx').on("touchend",function(){
				var goodsid = $(this).attr('data-id');
				var goodsinfo = $('.goodsprice' + goodsid)
				var sellerid = goodsinfo.attr('data-sellerid');
				var type = goodsinfo.attr('data-type');
				var num = parseInt($('.numberx').text());
				num--;
				if(num < 1){
					adds('.subtractx','none');
					adds('.numberx','none');
				}
				texts('.numberx',num);
				changeNum(sellerid,type,goodsid,num,0);
				return false;
			});
			$('.addx').on("touchend",function(){
				var goodsid = $(this).attr('data-id');
				var goodsinfo = $('.goodsprice' + goodsid)
				var sellerid = goodsinfo.attr('data-sellerid');
				var type = goodsinfo.attr('data-type');
				var num = parseInt($('.numberx').text());
				if(num < 1){
					removes('.subtractx','none');
					removes('.numberx','none');
				}
				num++;
				texts('.numberx',num);
				changeNum(sellerid,type,goodsid,num,0);
				return false;
			});
			$(".choose-norms").on("touchend",function(){
				var goodsid = $(this).attr('data-ids');
				var sellerid = $(this).attr('data-sellerid');
				var type = $(this).attr('data-type');
				if(goodsid > 0){
					$.post("{{u('UserCenter/getNorms')}}", { goodsid:goodsid }, function(res) {
						if(res.code == 0){
							if(res.data.norms.length > 0){
								var mr = 0;
								var html = '';
								$.each(res.data.norms,function(x,y){
									if(mr == 0){
										html += '<span class="choose_s choose_e" data-price="'+ y.price +'" data-id="'+ y.id +'">'+ y.name +'</span>';
										$('#explain .price').html(y.price);
										mr++;
									}else{
										html += '<span class="choose_s" data-price="'+ y.price +'" data-id="'+ y.id +'">'+ y.name +'</span>';
									}
								});
								texts('#explain .norms',html);
								removes('#explain','none');
								removes('#explain .econt-norms','none');
							}
							if(res.data.goodsProcessingCharges.length > 0){
								var text = '';
								$.each(res.data.goodsProcessingCharges,function(x,y){
									text += '<span class="choose_s" data-price="'+ y.price +'" data-id="'+ y.id +'">'+ y.name +'</span>';
								});
								texts('#explain .process',text);
								removes('#explain','none');
								removes('#explain .econt-process','none');
							}
						}
						$('#close').click(function(){
							adds('#explain','none');
						});
						$('#explain .norms span').click(function(){
							removes('#explain .norms span','choose_e');
							removes('#explain .process span','choose_e');
							adds($(this),'choose_e');
							var price = singlePrice();
							texts('#explain .price',price);
							texts('.number',0);
							numberHide(0);
							getNum(sellerid,goodsid);
						});
						$('#explain .process span').click(function(){
							removes('#explain .process span','choose_e');
							adds($(this),'choose_e');
							var price = singlePrice();
							texts('#explain .price',price);
							texts('.number',0);
							numberHide(0);
							getNum(sellerid,goodsid);
						});
						$('#explain .subtract').click(function(){
							var num = parseInt($('.number').text());
							num--;
							if(num < 1){
								numberHide(0);
							}else{
								totalPrice(num);
							}
							texts('.number',num);
							changeNum(sellerid,type,goodsid,num,1);
						});
						$('#explain .add').click(function(){
							var num = parseInt($('.number').text());
							if(num < 1){
								numberHide(1);
							}
							num++;
							texts('.number',num);
							totalPrice(num);
							changeNum(sellerid,type,goodsid,num,1);
						});
					});
				}
				return false;
			});
		});
		function removes(tag,attr){
			$(tag).removeClass(attr);
		}
		function adds(tag,attr){
			$(tag).addClass(attr);
		}
		function texts(tag,text){
			$(tag).html(text);
		}
		function singlePrice(){
			var price = 0;
			$('#explain .choose_e').each(function(){
				price += parseFloat($(this).attr('data-price'));
			});
			return price;
		}
		function totalPrice(num){
			var price = singlePrice();
			var total = price * num;
			$('#explain .price').html(total);
		}
		function numberHide(type){
			if(type == 0 || !type){
				$('#explain .subtract').addClass('none');
				$('.number').addClass('none');
			}else{
				$('#explain .subtract').removeClass('none');
				$('.number').removeClass('none');
			}
		}
		function changeNum(sellerid,type,goodsid,num,way){
			if(way > 0){
				var normsid = $('#explain .norms .choose_e').attr('data-id');
				var processid = $('#explain .process .choose_e').attr('data-id');
			}
			$.post("{{u('Goods/saveCartTwo')}}", { sellerId: sellerid,type: type,goodsId: goodsid, normsId: normsid, processId: processid, num: num, serviceTime: 0 }, function(res){
				if(res.code != 0){
					alert(res.msg);
					if(way > 0){
						texts('.number',num - 1);
					}else{
						texts('.numberx',num - 1);
					}
				}
			});
		}
		function getNum(sellerid,goodsid){
			var normsid = $('#explain .norms .choose_e').attr('data-id');
			var processid = $('#explain .process .choose_e').attr('data-id');
			$.post("{{u('Goods/getVal')}}", { sellerId: sellerid,goodsId: goodsid, normsId: normsid, processId: processid}, function(res) {
				if(res.code == 0){
					if(res.data > 0){
						$('.number').html(res.data);
						numberHide(1);
					}
				}
			});
		}
	</script>
@stop

@section($js)
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=2N2BZ-KKZA4-ZG4UB-XAOJU-HX2ZE-HYB4O&libraries=geometry"></script>

<script type="text/javascript">
 var clientLatLng = null;

    $(function() {
        $(document).on("touchend",".todetail",function(){
            var id = $(this).data('id');
            var type = "{{$args['type']}}";
            var isurl = typeof($(this).parent().parent().data('isurl')) == 'undefined' ? $(this).parent().parent().parent().data('isurl') : $(this).parent().parent().data('isurl');
            if (type == 2) {
                if (isurl > 0) {
                   $.router.load("{!! u('Seller/detail')!!}?id=" + id, true);
                };
            } else {
                $.router.load("{!! u('Goods/detail')!!}?goodsId=" + id, true);
            }
        })

        $(".y-wdscr").on("touchend",function(){
            $(this).parent().parent().parent().unbind('click');
            var id = $(this).data("id");
            var obj = $(this).parents("li");
            var type = $(this).data('type');

            $.confirm('确认取消收藏？', '操作提示', function () {
                 $.post("{{u('UserCenter/delcollect')}}",{'id':id, 'type':type},function(res){
                     $(".x-sctk .tips").text(res.msg);
                     if (res.code == 0) {
                        obj.remove();
                     }
                     if(document.getElementById("list").getElementsByTagName("li").length == 0){
                        html = '<div class="x-null pa w100 tc"><i class="icon iconfont">&#xe645;</i><p class="f12 c-gray mt10">很抱歉，你还没有收藏！</p></div>';
                        $("div.y-sylist").after(html).remove();
                     }
                 },"json");
                 $(".x-sctk").fadeIn();
                 setTimeout(function(){
                     $(".x-sctk").fadeOut();
                 },1500);
            });
            return false;
        });

         $.computeDistanceBegin = function() {
                if (clientLatLng == null) {
                    $.getClientLatLng();
                    return;
                }

                $(".compute-distance").each(function(){
                    var mapPoint = new qq.maps.LatLng($(this).attr('data-map-point-x'), $(this).attr('data-map-point-y')); 
                    $.computeDistanceBetween(this, mapPoint);
                    $(this).removeClass('compute-distance');
                })
            }

            $.getClientLatLng = function() {
                citylocation = new qq.maps.CityService({
                    complete : function(result){
                        clientLatLng = result.detail.latLng;
                        $.computeDistanceBegin();
                    }
                });
                citylocation.searchLocalCity();
            }

            $.computeDistanceBetween = function(obj, mapPoint) {
                var distance = qq.maps.geometry.spherical.computeDistanceBetween(clientLatLng, mapPoint);
                if (distance < 1000) {
                    $(obj).html(Math.round(distance) + 'M');
                } else {
                    $(obj).html(Math.round(distance / 1000) + 'Km');
                }
            }

            $.SwiperInit = function(box, item, url) {
                $(box).infinitescroll({
                    itemSelector    : item,
                    debug           : false,
                    dataType        : 'html', 
                    nextUrl         : url
                }, function(data) {
                    $.computeDistanceBegin();
                });
            }
            $.computeDistanceBegin();


            // 加载开始
            // 上拉加载
            var groupLoading = false;
            var groupPageIndex = 2;
            $(document).off('infinite', '.infinite-scroll-bottom');
            $(document).on('infinite', '.infinite-scroll-bottom', function() {
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
                data.type = "{{$args['type']}}";

                $.post("{{ u('UserCenter/collectList') }}", data, function(result){
                    groupLoading = false;
                    $('.infinite-scroll-preloader').addClass('none');
                    result  = $.trim(result);
                    if (result != '') {
                        groupPageIndex++;
                        $('#list').append(result);
                        $.refreshScroller();
                    }else{
                        $(".allEnd").removeClass('none');
                    }
                });
            });

            // 下拉刷新
            $(document).off('refresh', '.pull-to-refresh-content');
            $(document).on('refresh', '.pull-to-refresh-content',function(e) {
                // 如果正在加载，则退出
                if (groupLoading) {
                    return false;
                }
                groupLoading = true;
                var data = new Object;
                data.page = 1;
                data.type = "{{$args['type']}}";

                $.post("{{ u('UserCenter/collectList') }}", data, function(result){
                    groupLoading = false;
                    result  = $.trim(result);
                    if (result != "") {
                        groupPageIndex = 2;
                    }
                    $('#list').html(result);
                    $.pullToRefreshDone('.pull-to-refresh-content');
                });
            });
            // 加载结束
            
            //部分IOS返回刷新
            if($.device['os'] == 'ios')
            {
                $(".isExternal").addClass('external');
            }
     })

</script>
@stop
