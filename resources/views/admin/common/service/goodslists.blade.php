@extends('admin._layouts.base')
@section('css')
@stop
@section('right_content')
	@yizan_begin
		<yz:list>
			@yizan_yield("search")
			<search> 
				<row>
					<input type="hidden" name="sellerId" value="{{$args['sellerId']}}" />
					<item name="name" label="商品名称"></item>
					<item label="分类">
						<select name="cateId" class="sle">
	                        <option value="0">请选择</option>
	                        @foreach($cate as $cate)
	                            <option value="{{ $cate['id'] }}"  @if((int)Input::get('cateId') == $cate['id']) selected @endif>{{ $cate['name'] }}</option>
	                        @endforeach
	                    </select>
					</item> 
					<btn type="search"></btn>
				</row>
			</search>
			@yizan_stop
			@yizan_yield("btn")
			<btns>
				<linkbtn label="添加商品" css="btn-green">
                    <attrs>
                        <url>{{ u('service/createGoods', ['sellerId'=>$args['sellerId']]) }}</url>
                    </attrs>
   	            </linkbtn>
                <linkbtn label="选择通用商品库" css="btn-gray" click="$.show_tag()"></linkbtn>
                <linkbtn label="删除" type="destroy" click="btnDestroy()"></linkbtn>
			</btns>
			@yizan_stop
			<table relmodule="SystemGoods" checkbox="1">
				<columns>
                    <column code="id" label="编号" width="40">
                        <p>{{ $list_item['id'] }}</p>
                    </column>
					<column code="seller" label="所属商家" >
						<p>{{ $list_item['seller']['name'] }}</p>
					</column>
					<!-- <column code="image" label="图片" type="image" width="60" iscut="1"></column> -->
					<column label="商品标签" align="left">
						<p>{{$list_item['systemTagListPid']['name'] or '无'}}|{{$list_item['systemTagListId']['name'] or '无'}}</p>  
					</column>
					<column code="name" label="商品信息" align="left">
						<p>{{ $list_item['name'] }}</p> 
					</column>
					<column code="cate" label="分类">
						{{ $list_item['cate']['name']}}
					</column>
					<column code="price" label="商品原价" align="left" width="100">
						<p>￥{{ $list_item['originalPrice'] }}</p>
					</column>
                    <!--<column code="price" label="促销价格" align="left" width="100">
                        <p>￥{{ $list_item['salePrice'] }}</p>
                    </column>-->
                    <column code="price" label="商品重量(kg)" align="left" width="100">
                        <p>{{ $list_item['weight'] }}</p>
                    </column>
					<column code="status" type="status" label="状态" width="40"></column>
                    <input type="hidden" id="autoType_{{ $list_item['id'] }}" attr-auto_type="{{ $list_item['autoType'] }}">
					<actions width="60">
                        @if($list_item['autoType'] == 1)
                            <span style="color: grey;">促销商品不可操作</span>
                            @elseif($list_item['autoType'] == 2)
                            <span style="color: grey;">秒杀商品不可操作</span>
                            @else
						<action css="blu" label="编辑">
							<attrs>
								<url>{{ u('Service/goodsEdit',['id'=>$list_item['id'], 'sellerId'=>$list_item['sellerId']]) }}</url>
							</attrs>
						</action>
						<!-- <action type="edit" css="blu"></action> -->
						<action type="destroy" css="red">
							<attrs>
								<url>{{ u('Service/goodsDestroy',['id'=>$list_item['id'], 'sellerId'=>$list_item['sellerId'], 'type'=>$list_item['type']]) }}</url>
							</attrs>
						</action>
                            @endif
					</actions>
				</columns>
			</table>
		</yz:list>
	@yizan_end
@stop


@section('js')
    <script type="text/tpl" id="SellerGoodsTag">
        <div id="-form-item" class="u-fitem " style="padding:10px;">
            <div class="f-boxr">
                一级分类： <select name="systemTagListPid" class="sle" id="systemTagListPid" style="width:180px">
                    @foreach($systemTagListPid as $val)
                        <option value="{{ $val['id'] }}">{{ $val['name'] }}</option>
                    @endforeach
        </select>
        <br>
        二级分类： <select name="systemTagListId" class="sle" id="systemTagListId"  style="width:180px">
                <option value="0">请选择</option>
        </select>
</div>
</div>
</script>
    <script type="text/javascript">
        $.show_tag = function(){
            var dialog = $.zydialogs.open($("#SellerGoodsTag").html(), {
                boxid:'SET_GROUP_WEEBOX',
                width:300,
                title:'请选择分类',
                showClose:true,
                showButton:true,
                showOk:true,
                showCancel:true,
                okBtnName: '进入商品库',
                cancelBtnName: '取消',
                contentType:'content',
                onOk: function(){
                    var  systemTagListPid = $("select[name=systemTagListPid]  option:selected").val();
                    var  systemTagListId = $("select[name=systemTagListId]  option:selected").val();
                    if(systemTagListPid <= 0){
                        $.ShowAlert("请选择一级分类");
                        return false;
                    }
                    if(systemTagListId <= 0){
                        $.ShowAlert("请选择二级分类");
                        return false;
                    }
                    if(systemTagListPid > 0&& systemTagListId > 0){
                        var  url = "{{u('Service/systemGoods')}}?systemTagListPid="+systemTagListPid+"&systemTagListId="+systemTagListId+"&sellerId={{$args['sellerId']}}";
                        window.location.href = url;
                    }
                },
                onCancel:function(){
                    $.zydialogs.close("SET_GROUP_WEEBOX");
                }
            });
            //标签
            $("#systemTagListPid").change(function(){
                var tagId = $(this).val();
                if(tagId == 0)
                {
                    var html = '<option value=0>请选择</option>';
                    $("#systemTagListId").html(html);
                }
                else
                {
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
                            var html = '<option value=0>请选择</option>';
                            $("#systemTagListId").html(html);
                        }

                    });
                }
            });
        }

        function btnDestroy() {
            var id = new Array();
            var sellerId = "{{ $list[0]['sellerId'] ?  $list[0]['sellerId'] : 0}}";
            var flage = 0;
            $("div.checker span.checked").each(function(k, v){
                id[k] = $(this).find("input[name='key']").val();
                var auto_type = parseInt($("#autoType_"+id[k]).attr("attr-auto_type"));
                if(auto_type == parseInt(1)){
                    flage = 1;
                }
                if(auto_type == parseInt(2)){
                    flage = 2;
                }
            });
            if(parseInt(flage) == 1){
                $.ShowAlert('促销商品不能删除');
                return false;
            }
            if(parseInt(flage) == 2){
                $.ShowAlert('秒杀商品不能删除');
                return false;
            }
            if(id.length < 1)
            {
                $.ShowAlert('请选择要删除的项');
                return false;
            }
            $.ShowConfirm('确认删除吗？', function(){
                $.post("{{ u('Service/goodsDestroy') }}", {'id':id, 'sellerId':sellerId, 'type':1}, function(res){
                    if(res.status)
                    {
                        window.location.reload();
                    }
                });
            });        
        }
    </script>
@stop