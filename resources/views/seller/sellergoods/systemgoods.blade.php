@extends('seller._layouts.base')
@section('css')
<style type="text/css">
	.m-tab table tbody td{padding: 5px 0px;}
    .g-fwgl{margin-bottom: 10px}
    #searchresult{border: 1px solid #ccc;border-top: none;position: absolute;background: #fff;width: 131px;z-index:98;}
    #searchresult li{cursor:pointer; padding: 0 6px;}
    #searchresult li:hover{background: #ccc; color: #fff;}
</style>
@stop

@section('content')
	<div>
		<div class="m-zjgltbg">					
			<div class="p10">
				<!-- 商品管理 -->
				<div class="g-fwgl">
					<p class="f-bhtt f14 clearfix">
                        <span class="ml15 fl">通用商品库</span>
					</p>
				</div>
				<div class="m-tab m-smfw-ser">
					@yizan_begin
	                    <yz:list>
	                    	<search url="{{$searchUrl}}">
                                <row>
                                    <btn type="click" css="btn-green one_channel_show" click="" label="选择导入"></btn>
                                </row>
								<row>
									<item name="name" label="商品名称"></item>
                                    <div class="searchbrand" style="display: inline-block;">
                                        <div class="fl"><span style="line-height: 30px;">搜索品牌：</span></div>
                                        <div class="fl" style="margin-right: 13px;">
                                            <input name="searchtext" type="text" class="u-ipttext" id="searchtext" value="{{ Input::get('searchtext') }}" autocomplete="off"/>
                                            <ul class="none" id="searchresult"></ul>
                                        </div>
                                    </div>
                                    <input name="brand" id="brand" class="u-ipttext" value="{{ Input::get('brand') }}" type="hidden" />
                                </row>
                                <row>
                                    <label>分类选择：</label>
                                    <yz:select name="systemTag" options="$systemTag" textfield="name" valuefield="id" selected="$systemTagId"></yz:select>
                                    @if($args['systemTagListPid'] > 0)
                                        <yz:select name="systemTagListPid" options="$systemTagListPid" textfield="name" valuefield="id" selected="$args['systemTagListPid']" ></yz:select>
                                        <yz:select name="systemTagListId" options="$systemTagListId" textfield="name" valuefield="id" selected="$args['systemTagListId']" ></yz:select>
                                    @else
                                        <yz:select name="systemTagListPid" options="$systemTagListPid" textfield="name" valuefield="id" selected="$args['systemTagListPid']" css="none"></yz:select>
                                        <yz:select name="systemTagListId" options="$systemTagListId" textfield="name" valuefield="id" selected="$args['systemTagListId']" css="none"></yz:select>
                                    @endif
                                </row>
                                <row>
                                    <btn type="search" css="btn-gray"></btn>
                                </row>
							</search>
	                        <table css="goodstable" relmodule="" checkbox="1">
	                            <columns>
                                    <column label="商品名称" align="left" width="200">
	                                	<a href="{{ $list_item['image'] }}" target="_blank" class="goodstable_img fl">
	                                		<img src="{{ $list_item['image'] }}" alt="" width="70">
	                                	</a>
	                                	<div class="goods_name">{{ $list_item['name'] }}</div>
	                                </column>
	                                <column label="商品标签" align="left" width="120">
										<p class="pl5">{{$list_item['systemTagListPid']['name'] or '无'}}|{{$list_item['systemTagListId']['name'] or '无'}}</p>  
									</column>
                                    <column label="价格" width="50">
	                                	￥{{ $list_item['price'] }}
	                                </column> 
	                                <column code="status" label="状态" type="status" width="50">
                                            @if($list_item['status']  == 1)
                                                可选
                                            @else
                                                不可选
                                            @endif
                                    </column>
	                                <actions width="100">
                                        @if($list_item['status']  == 1)
                                            <action css="blu" url="goodsedit?id={{$list_item['id']}}" label="选择商品"></action>
                                        @else
                                            不可选
                                        @endif
									</actions>
	                            </columns>
	                        </table>
	                    </yz:list>
	                @yizan_end
				</div>
			</div>
		</div>
    </div>
    <div>
        <input type="hidden" name="systemTagListPid" value="{{$args['systemTagListPid']}}">
        <input type="hidden" name="systemTagListId" value="{{$args['systemTagListId']}}">
    </div>
@stop

@section('js')
    <script type="text/tpl" id="oneChannel">
        <div id="-form-item" class="u-fitem " style="padding:10px;">
            <div class="f-boxr show_item_cate">
                商品分类： <select name="cateId" class="sle" id="cateId" style="width:180px">
                    <option value="-1">请选择</option>
                    @foreach($cate as $val)
                        <option value="{{ $val['id'] }}">{{ $val['name'] }}</option>
                    @endforeach
                </select>
            </div>
			<div class="f-boxr show_item_cate_msg none">
			
            </div>			
        </div>
    </script>
    <script type="text/javascript">

        $(".goodstable thead td input[type=checkbox]").click(function(){
                if($(this).attr('checked') === "checked"){
                    $(".one_channel_show").attr('onclick',"$.plChannel()");
                    $(".one_channel_show").text('批量导入');
                }else{
                    if($(".goodstable thead td span").hasClass('checked')){
                        //$(".one_channel_show").attr('onclick',"$.oneChannel()");
                        $(".one_channel_show").attr('onclick',"");
                        $(".one_channel_show").text('选择导入');
                    }else{
                        $(".one_channel_show").attr('onclick',"$.plChannel()");
                        $(".one_channel_show").text('批量导入');
                    }
                }
            }
        );
        $(document).on('click', '.goodstable tbody td input[type=checkbox]', function(){
            if($(this).attr('checked') === "checked"){
                $(".one_channel_show").attr('onclick',"$.plChannel()");
                $(".one_channel_show").text('批量导入');
            }
            else{
                var bln = 0;
                var b = document.getElementsByName("key");
                for(var i=0;i<b.length;i++)
                {
                    if(b[i].checked==true){
                        bln += 1;
                    }
                }
                if(bln > 0){
                    $(".one_channel_show").attr('onclick',"$.plChannel()");
                    $(".one_channel_show").text('批量导入');
                }else{
                    $(".one_channel_show").attr('onclick',"");
                    $(".one_channel_show").text('选择导入');
                }
            }
        });

        $.plChannel = function(){
            var dialog = $.zydialogs.open($("#oneChannel").html(), {
                boxid:'SET_GROUP_WEEBOX',
                width:300,
                title:'请选择商品分类',
                showClose:true,
                showButton:true,
                showOk:true,
                showCancel:true,
                okBtnName: '确定批量导入',
                cancelBtnName: '取消',
                contentType:'content',
                onOk: function(){
                    var obj = {}
                    obj.systemTagListPid = $("input[name=systemTagListPid]").val();
                    obj.systemTagListId = $("input[name=systemTagListId]").val();
                    obj.cateId = $("select[name=cateId] option:selected").val();
                    obj.ids = [];
                    var b = document.getElementsByName("key");
                    for(var i=0;i<b.length;i++)
                    {
                        if(b[i].checked==true){
                            obj.ids.push(b[i].value);
                        }
                    }
                    dialog.setLoading();
                    $.post('{{u("SellerGoods/oneChannelCk")}}',obj,function(res){
                        if(res.code == 0){
                            var msg = "共“"+res.data.count+"”条数据,正在执行请稍候...";
                            if(res.data.count >= 100){
                                var msg = "当前数据量较大,请耐心等待,请勿刷新页面...!";
                            }
                            $(".zydialog_title").html("请稍候...");
                            $(".show_item_cate_msg").html(msg).removeClass("none");
                            $(".show_item_cate").addClass("none");
                            $.post('{{u("SellerGoods/oneChannel")}}',obj,function(res){
                                if(res.code == 0){
                                    $.ShowAlert("导入成功");
                                    $.zydialogs.close("SET_GROUP_WEEBOX");
                                    window.location.href = "{{u('SellerGoods/index')}}";

                                }else{
                                    $(".zydialog_title").html("请选择商品分类");
                                    $(".show_item_cate_msg").html("").addClass("none");
                                    $(".show_item_cate").removeClass("none");
                                    $.ShowAlert(res.msg);
                                    dialog.setLoading(false);
                                }
                            },'json');
                        }else{
                            $.ShowAlert(res.msg);
                            dialog.setLoading(false);
                        }
                    },'json');
                },
                onCancel:function(){
                    $.zydialogs.close("SET_GROUP_WEEBOX");
                }
            });
        }
        $.oneChannel = function(){
            var dialog = $.zydialogs.open($("#oneChannel").html(), {
                boxid:'SET_GROUP_WEEBOX',
                width:300,
                title:'请选择商品分类',
                showClose:true,
                showButton:true,
                showOk:true,
                showCancel:true,
                okBtnName: '确定一键导入',
                cancelBtnName: '取消',
                contentType:'content',
                onOk: function(){
					var obj = {}
					obj.systemTagListPid = $("input[name=systemTagListPid]").val();
					obj.systemTagListId = $("input[name=systemTagListId]").val();
					obj.cateId = $("select[name=cateId] option:selected").val();
					dialog.setLoading();                        
					$.post('{{u("SellerGoods/oneChannelCk")}}',obj,function(res){
						if(res.code == 0){
							var msg = "共“"+res.data.count+"”条数据,正在执行请稍候...";
							if(res.data.count >= 100){
								var msg = "当前数据量较大,请耐心等待,请勿刷新页面...!";
							}
							$(".zydialog_title").html("请稍候...");
							$(".show_item_cate_msg").html(msg).removeClass("none");
							$(".show_item_cate").addClass("none");
							$.post('{{u("SellerGoods/oneChannel")}}',obj,function(res){
								if(res.code == 0){
									$.ShowAlert("导入成功");
                                    $.zydialogs.close("SET_GROUP_WEEBOX");
                                    window.location.href = "{{u('SellerGoods/index')}}";

								}else{
									$(".zydialog_title").html("请选择商品分类");
									$(".show_item_cate_msg").html("").addClass("none");
									$(".show_item_cate").removeClass("none");
									$.ShowAlert(res.msg);
									dialog.setLoading(false); 
								}
							},'json');
						}else{
							$.ShowAlert(res.msg);
							dialog.setLoading(false); 
						}
					},'json');
                },
                onCancel:function(){
                    $.zydialogs.close("SET_GROUP_WEEBOX");
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(function(){
            //标签
            $("#systemTag").change(function(){
                var tagId = $(this).val();
                if(tagId == 0){
                    $("#systemTagListId").html('<option value=0>请选择</option>').addClass('none');
                    $("#systemTagListPid").html('<option value=0>请选择</option>').addClass('none');
                } else {
                    console.log(123);
                    $.post("{{ u('SystemTagList/firstLevel') }}", {'id': tagId}, function(res){
                        console.log(res);
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
                    $("#systemTagListId").html('<option value=0>请选择</option>').addClass('none');
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

            $('#searchtext').bind('keyup',function(){
                var content = $(this).val();
                if(content == '' || content === null){
                    $('#searchresult').empty().addClass('none');
                    $("#brand").val("");
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
                                $("#brand").val(brandid);
                            });
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });

        });
    </script>

@stop
