@extends('seller._layouts.base')
@section('css')
<link rel="stylesheet" type="text/css" href="{{ asset('css/jquery.tagsinput.css') }}">
<style type="text/css">
	#cateSave{display: none;}
	.page_2,.page_3{display: none;}
	.m-spboxlst li{margin-bottom: 0px;}
	#tags_goods-form-item .f-boxr {width:550px;} 
	#cateSave{display: none;}
	.page_2,.page_3{display: none;}
	.m-spboxlst li{margin-bottom: 0px;}
	#tags_goods-form-item .f-boxr {width:550px;}
	.f-boxr .btn{background: #efefef; border-color: #dfdfdf; width: 80px; color: #555;}
	.x-gebox{border: 1px solid #ddd; padding: 5px 20px;}
	.x-gebox .u-ipttext{width: 100px; margin-right: 10px;}
	.closege{width: 20px; height: 20px; background: url("{{ asset('wap/community/client/images/ico/close.png') }}"); background-size: 100% 100%; display: inline-block; cursor: pointer; vertical-align: middle; margin-top: -2px;}
	#searchresult{border: 1px solid #ccc;border-top: none;position: absolute;background: #fff;width: 232px;z-index:98;}
	#searchresult li{cursor:pointer;padding: 0 6px;}
	#searchresult li:hover{background: #ccc; color: #fff;}
</style> 
@stop 
@section('content')
	<div>
		<div class="m-zjgltbg">					
			<div class="p10">
				<!-- 添加商品 -->
				<div class="g-fwgl">
					<p class="f-bhtt f14 clearfix">
						<span class="ml15 fl">添加商品</span>
					</p>
				</div> 
				<div class="m-tab m-smfw-ser pt20">
					@yizan_begin
	                    <yz:form id="yz_form" action="{{$systemgoodssave ? $systemgoodssave : 'save'}}">
							<input name="listPage" type="hidden" value="{{ Input::get('listPage') }}" />
							<yz:fitem name="name" label="商品名称" required="true"></yz:fitem>
                            <yz:fitem name="goodsSn" label="商品编码">
                                @if(!$data)
                                    <INPUT class="u-ipttext" maxlength="16" size="16" name=goodsSn id="goodsSn" onKeyUp="value=value.replace(/[\W]/g,'')">
                                    <span>(请输入1-16位字母和数字组合的编码)</span>
                                @else
                                    @if($systemgoodssave)
                                        <INPUT class="u-ipttext" maxlength="16" size="16" name=goodsSn id="goodsSn" onKeyUp="value=value.replace(/[\W]/g,'')">
                                        <span>(请输入1-16位字母和数字组合的编码)</span>
                                    @else
                                        {{$data['goodsSn'] or "无"}}
                                    @endif
                                @endif
                            </yz:fitem>
							<yz:fitem label="商品分类">
								<yz:select name="cateId" options="$cate" textfield="name" valuefield="id" selected="$data['cate']['id']"></yz:select>
							</yz:fitem>
							@if($systemgoodssave != "")
								<yz:fitem label="商品标签">
									<yz:select disabled='disabled' name="systemTag" options="$systemTag" textfield="name" valuefield="id" selected="$systemTagId"></yz:select>
								    <yz:select disabled='disabled' name="systemTagListPid" options="$systemTagListPid" textfield="name" valuefield="id" selected="$data['systemTagListPid']"></yz:select>
                                    <yz:select disabled='disabled' name="systemTagListId" options="$systemTagListId" textfield="name" valuefield="id" selected="$data['systemTagListId']" css="@if(count($systemTagListId) == 1) none @endif"></yz:select>
                                    <input type="hidden"  name="systemTagListPid" value="{{$data['systemTagListPid']}}"/>
                                    <input type="hidden"  name="systemTagListId" value="{{$data['systemTagListId']}}"/>
								</yz:fitem>
								<yz:fitem label="商品品牌">
									<yz:select name="brandId" options="$brand" textfield="name" valuefield="id" selected="$data['brandid']"></yz:select>
									<div class="searchbrand fr">
										<div class="fl"><span>搜索品牌：</span></div>
										<div class="fl">
											<input type="text" class="u-ipttext" id="searchtext" autocomplete="off"/>
											<ul class="none" id="searchresult"></ul>
										</div>
									</div>
								</yz:fitem>
							@else
								<yz:fitem label="商品标签">
                                    <yz:select  name="systemTag" options="$systemTag" textfield="name" valuefield="id" selected="$systemTagId"></yz:select>
                                    @if($data['id'] < 1)
										<yz:select  name="systemTagListPid" options="$systemTagListPid" textfield="name" valuefield="id" selected="$data['systemTagListPid']" css="none"></yz:select>
                                    @else
										<yz:select  name="systemTagListPid" options="$systemTagListPid" textfield="name" valuefield="id" selected="$data['systemTagListPid']" css=""></yz:select>
									@endif
                                    <yz:select  name="systemTagListId" options="$systemTagListId" textfield="name" valuefield="id" selected="$data['systemTagListId']" css="@if(count($systemTagListId) == 1) none @endif"></yz:select>
								</yz:fitem>
								<yz:fitem label="商品品牌">
									<yz:select name="brandId" options="$brand" textfield="name" valuefield="id" selected="$data['brandId']"></yz:select>
									<div class="searchbrand fr">
										<div class="fl"><span>搜索品牌：</span></div>
										<div class="fl">
											<input type="text" class="u-ipttext" id="searchtext" autocomplete="off"/>
											<ul class="none" id="searchresult"></ul>
										</div>
									</div>
								</yz:fitem>
							@endif
							<yz:fitem name="price" label="商品原价"  required="true" ></yz:fitem>
							<!--<yz:fitem name="salePrice" label="促销价格" ></yz:fitem>-->
							<yz:fitem name="stock" label="商品库存" val="0"></yz:fitem>
							<yz:fitem name="weight" label="商品重量(公斤)" val="{{$data['weight']}}" ></yz:fitem>
							<yz:fitem name="model" label="型号" val="{{ $data['model'] }}" ></yz:fitem>
							<yz:fitem name="goodsUnit" label="单位" val="{{ $data['goodsUnit'] }}" ></yz:fitem>

							<div id="norms-form-item" class="u-fitem clearfix">
					            <span class="f-tt">
					                 规格型号:
					            </span>
								<div class="f-boxr">
									<button type="button" class="btn addge add_norms">添加规格</button>
								</div>
							</div>
							<div id="norms-form-item" class="u-fitem clearfix x-addge">
								<span class="f-tt">&nbsp;</span>
								<div class="f-boxr norms_panel">
									@foreach($data['norms'] as $item)
										<div class="x-gebox">
											<input type="hidden" name="_id[]" value="{{$item['id']}}" >
											型号：<input type="text" name="_name[]" value="{{$item['name']}}" class="u-ipttext" />
											原价：<input type="text" name="_price[]" value="{{$item['price'] or 0}}" class="u-ipttext" />
										<!--折扣价:<input type="text" name="_salePrice[]" class="u-ipttext" value="{{ $item['salePrice'] or 0}}"/>-->
											重量（公斤）:<input type="text" name="_weight[]" class="u-ipttext" value="{{ $item['weight'] or 0}}"/>
											库存：<input type="text" name="_stock[]" value="{{$item['stock']}}" class="u-ipttext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
											<i class="closege"></i>
										</div>
									@endforeach
								</div>
							</div>
							<div id="norms-form-item1" class="u-fitem clearfix">
					            <span class="f-tt">
					                 加工规格:
					            </span>
								<div class="f-boxr">
									<button type="button" class="btn addge add_norms1">添加规格</button>
								</div>
							</div>
							<div id="norms-form-item" class="u-fitem clearfix x-addge" style="margin-top: -20px;">
								<span class="f-tt">&nbsp;</span>
								<div class="f-boxr norms_panel1">
									@foreach($data['goodsProcessingCharges'] as $item)
										<div class="x-gebox">
											<input type="hidden" name="_id1[]" value="{{$item['id']}}" >
											加工形式：<input type="text" name="_name1[]" value="{{$item['name']}}" class="u-ipttext" />
											价格：<input type="text" name="_price1[]" value="{{$item['price']}}" class="u-ipttext" />元
											<i class="closege1"></i>
										</div>
									@endforeach
								</div>
							</div>
							<!--yz:fitem name="totalStock" attr="readonly" label="总库存" val="0"></yz:fitem-->
							<yz:fitem label="商品图片">
								<yz:imageList name="images." images="$data['images']" required="true"></yz:imageList>
								<div><small class='cred pl10 gray'>建议尺寸：750px*750px，支持JPG/PNG格式</small></div>
							</yz:fitem> 
							<yz:fitem name="buyLimit" label="每人限购"></yz:fitem>
                                <yz:fitem name="brief" label="商品描述"  required="true">
                                    <yz:Editor name="brief" value="{{ $data['brief'] }}" required="true"></yz:Editor>
                                </yz:fitem>

							</yz:fitem>    
							<yz:fitem label="商品状态"> 
								<php> $status = (int)$data['status'] </php>
								<yz:radio name="status" options="0,1" texts="下架,上架" checked="$status"></yz:radio>
							</yz:fitem>
							<yz:fitem name="sort" label="排序"></yz:fitem>
						</yz:form>
                    </div>
	                @yizan_end
				</div>
			</div>
		</div>
	</div>
@stop
@section('js')
@include('seller._layouts.alert')
<script src="{{ asset('js/jquery.tagsinput.min.js') }}"></script>  
<script type="text/tpl" id="normsrow"> 
	<div class="x-gebox" style="margin-top:3px;">
		型号：<input type="text" name="_name[]" class="u-ipttext" />
		原价：<input type="text" name="_price[]" class="u-ipttext" />
		<!--折扣价:<input type="text" name="_salePrice[]" class="u-ipttext" />-->
		重量（公斤）:<input type="text" name="_weight[]" class="u-ipttext" />  
		库存：<input type="text" name="_stock[]" class="u-ipttext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
		<i class="closege"></i>
    </div>
</script>
<script type="text/tpl" id="normsrow1">
	<div class="x-gebox" style="margin-top:3px;">
		加工形式：<input type="text" name="_name1[]" class="u-ipttext" />
		价格：<input type="text" name="_price1[]" class="u-ipttext" />元
		{{--库存：<input type="text" name="_stock[]" class="u-ipttext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />--}}
		<i class="closege"></i>
    </div>
</script>
<script type="text/javascript">
	$(".add_norms").click(function(){  
		$(".norms_panel").append($("#normsrow").html()); 
		if($(".x-gebox").length > 0){
			$(".norms_panel").parent().show();
		}
	});
	$(".add_norms1").click(function(){
		$(".norms_panel1").append($("#normsrow1").html());
		if($(".x-gebox").length > 0){
			$(".norms_panel1").parent().show();
		}
	});
	$(document).on('click','.closege',function(){ 
		$(this).parent().remove();
		if($(".x-gebox").length <= 0){
			$(".norms_panel").parent().hide();
		}
	});
	$(document).on('click','.closege1',function(){
		$(this).parent().remove();
		if($(".x-gebox").length <= 0){
			$(".norms_panel1").parent().hide();
		}
	});
	$(function(){
		$("input[name='stock']").attr("maxlength","11").attr("onkeyup", "this.value=this.value.replace(/\\D/g,'')").attr("onafterpaste", "this.value=this.value.replace(/\\D/g,'')");

		//标签
		$("#systemTag").change(function(){
			var tagId = $(this).val();
			if(tagId == 0){
				$("#systemTagListId").html('').addClass('none');
				$("#systemTagListPid").html('').addClass('none');
			} else {
				$.post("{{ u('SystemTagList/firstLevel') }}", {'id': tagId}, function(res){
					if(res!=''){
						var html = '<option value=0>请选择</option>';
						$.each(res, function(k,v){
							html += "<option value='"+v.id+"'>"+v.name+"</option>";
						});
						$("#systemTagListPid").html(html).removeClass('none');
						$("#systemTagListId").html('').addClass('none');
					}else{
						$("#systemTagListPid").html('').addClass('none');
						alert("当前分类暂无一级分类，请重新选择！");
					}
					
				});	
			}
		});
		$("#systemTagListPid").change(function(){
			var tagId = $(this).val();
			if(tagId == 0 || $('#systemTag').val() == 0)
			{
				$("#systemTagListId").html('').addClass('none');
			} else {
				$.post("{{ u('SystemTagList/secondLevel') }}", {'pid': tagId}, function(res){

					if(res!='')
					{
						var html = '<option value=0>请选择</option>';
						$.each(res, function(k,v){
							html += "<option value='"+v.id+"'>"+v.name+"</option>";
						});
						$("#systemTagListId").html(html).removeClass('none');
					}
					else
					{
						$("#systemTagListId").html('').addClass('none');
						alert("当前分类暂无二级分类，请重新选择！");
					}
					
				});	
			}
		});
	})
</script>
<script type="text/javascript">
	$(function(){
	    //品牌搜索
		$('#searchtext').bind('keyup',function(){
			var content = $(this).val();
			if(content == '' || content === null){
				$('#searchresult').empty().addClass('none');
				return false;
			}
			$.ajax({
				type: "POST",
				dataType: "json",
				url:  "{{u('Goods/search')}}",
				data: {content:content},
				success: function(data){
					if(data.code == 0){
						$('#searchresult').empty().removeClass('none');
						$.each(data.data, function(x, y){
							$("<li data-id='" + y.id + "'>" + y.name + "</li>").appendTo('#searchresult');
						});
						$('#searchresult li').bind('click',function(){
							var brandid = $(this).attr('data-id');
							$('#searchtext').val($(this).html());
							$('#searchresult').empty().removeClass('none');
							$("#brandId").find("option:selected").removeAttr('selected');
							$("#brandId").find("option[value='" + brandid + "']").attr("selected",true);
						});
					}else{
						alert(data.msg);
					}
				}
			});
		});

		//检测商品名重复
		$("#name").bind("keyup",function(){
		    var content = $(this).val();
		    if(content == "" || content === null || content == " "){
                $("#nameTest").remove();
				return false;
			}
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "{{ u('SellerGoods/goodsNameTest') }}",
				data: {name:content},
				success: function(res){
                    $("#nameTest").remove();
				    if(res.code == 0){
				        $("#name-form-item").append("<div id='nameTest' class='fl' style='margin-left:150px;'><ul style='position: absolute;max-height:200px;overflow: auto;'></ul></div>");
				        $.each(res.data,function(x,y){
				           $("#nameTest ul").append("<li style='float: left;margin-right: 10px;'>" + y.name + "</li>");
						});
				        if($("#name").val() == "" || $("#name").val() === null || $("#name").val() == " "){
                            $("#nameTest").remove();
                            return false;
						}
					}
				}
			});
		});
		
	});
</script>
@stop