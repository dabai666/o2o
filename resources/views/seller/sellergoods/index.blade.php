@extends('seller._layouts.base')
@section('css')
<style type="text/css">
	.m-tab table tbody td{padding: 5px 0px;}
</style>
@stop
@section('content')
	<div>
		<div class="m-zjgltbg">					
			<div class="p10">
				<!-- 商品管理 -->
				<div class="g-fwgl">
					<p class="f-bhtt f14 clearfix">
						<span class="ml15 fl">商品管理</span>
					</p>
				</div> 
				<div class="m-tab m-smfw-ser">
					@yizan_begin
	                    <yz:list>
	                    	<search> 
								<row>
									<item name="name" label="商品名称"></item>
									<item label="分类">
					                    <select name="cateId" class="sle">
					                        <option value="0">全部</option>
					                        @foreach($cate as $val)
					                            <option value="{{ $val['id'] }}"  @if($search_args['cateId'] == $val['id']) selected @endif>{{ $val['name'] }}</option>
					                        @endforeach
					                    </select>
					                </item>
									<btn type="search" css="btn-gray"></btn>
								</row>
							</search>
                            <btns>
                                <linkbtn label="添加商品" url="{{ u('SellerGoods/create') }}" css="btn-gray"></linkbtn>
                                {{--<linkbtn label="选择通用商品库" css="btn-gray" click="$.show_tag();"></linkbtn>--}}
                                <linkbtn label="进入通用商品库" css="btn-gray" click="window.location.href='{{ u('SellerGoods/systemGoods') }}'"></linkbtn>
                                <!-- <linkbtn label="导出到Excel" type="export" url="{{ u('Goods/export?'.$excel) }}" css="btn-gray"></linkbtn> -->
                                <linkbtn type="destroy" css="btn-gray" click="$.RemoveList1(this);"></linkbtn>
                            </btns>
                            <table css="goodstable" relmodule="" checkbox="1">
                                <columns>
                                    <column label="商品名称" align="left" width="200">
                                        <a href="{{ $list_item['image'] }}" target="_blank" class="goodstable_img fl">
                                            <img src="{{ $list_item['image'] }}" alt="" width="70">
                                        </a>
                                        <div class="goods_name">{{ $list_item['name'] }}</div>
                                        @if($list_item['autoType'] == 1) <div class="goods_name" style="margin-top: 5px;color: rgb(225,0,0);">(平台促销活动商品)</div> @elseif($list_item['autoType'] == 2) <div class="goods_name" style="margin-top: 5px;color: rgb(225,0,0);">(平台秒杀活动商品)</div> @endif
                                    </column>
                                    <column label="商品标签" align="left" width="120">
                                        <p class="pl5">{{$list_item['systemTagListPid']['name'] or '无'}}|{{$list_item['systemTagListId']['name'] or '无'}}</p>
                                    </column>
                                    <column label="商品分类" width="120">
                                        {{ $list_item['cate']['name'] }}
                                    </column>
                                    <column label="商品原价" width="50">
                                        ￥{{ $list_item['originalPrice'] or 0}}
                                    </column>
                                    <column label="促销价格" width="50">
                                        ￥{{ $list_item['salePrice'] or 0}}
                                    </column>
                                    <column label="商品重量(kg)" width="80">
                                        {{ $list_item['weight'] or 0}}
                                    </column>
                                    <input type="hidden" id="autoType_{{ $list_item['id'] }}" attr-auto_type="{{ $list_item['autoType'] }}">
                                    <column code="status" label="上/下架" type="status" width="50"></column>
                                    <actions width="100">
                                        @if($list_item['autoType'] == 1)
                                            <p style="color: rgb(225,0,0)">
                                                （平台促销活动商品，不可编辑）
                                            </p>
                                        @elseif($list_item['autoType'] == 2)
                                            <p style="color: rgb(225,0,0)">
                                                （平台秒杀活动商品，不可编辑）
                                            </p>
                                        @else
                                            <action type="edit" css="blu edits"></action>
                                            <action type="destroy" css="red" ></action>
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
@stop

@section('js')
    <script type="text/tpl" id="SellerGoodsTag">
        <div id="-form-item" class="u-fitem " style="padding:10px;">
            <div class="f-boxr">
                一级分类： <select name="systemTag" class="sle" id="systemTag" style="width:180px">
                        @foreach($systemTag as $v)
                            <option value="{{ $v['id'] }}">{{ $v['name'] }}</option>
                        @endforeach
                </select>
                <br>
                二级分类： <select name="systemTagListPid" class="sle" id="systemTagListPid" style="width:180px">
                        <option value="0">请选择</option>
                </select>
                <br>
                三级分类： <select name="systemTagListId" class="sle" id="systemTagListId"  style="width:180px">
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
                     var  systemTag = $("select[name=systemTag]  option:selected").val();
                     var  systemTagListPid = $("select[name=systemTagListPid]  option:selected").val();
                     var  systemTagListId = $("select[name=systemTagListId]  option:selected").val();
                     if(systemTag <= 0){
                         $.ShowAlert("请选择一级分类");
                         return false;
                     }
                     if(systemTagListPid <= 0){
                         $.ShowAlert("请选择二级分类");
                         return false;
                     }
                     if(systemTagListPid > 0){
                         var  url = "{{u('SellerGoods/systemGoods')}}?systemTagListPid="+systemTagListPid+"&systemTagListId="+systemTagListId;
                         window.location.href = url;
                     }
                 },
                 onCancel:function(){
                     $.zydialogs.close("SET_GROUP_WEEBOX");
                 }
             });
             //标签
             $("#systemTag").change(function(){
                 var tagId = $(this).val();
                 if(tagId == 0){
                     var html = '<option value=0>请选择</option>';
                     $("#systemTagListPid").html(html);
                     $("#systemTagListId").html(html);
                 } else {
                     $.post("{{ u('SystemTagList/firstLevel') }}", {'id': tagId}, function(res){
                         if(res!=''){
                             var html = '<option value=0>请选择</option>';
                             $.each(res, function(k,v){
                                 html += "<option value='"+v.id+"'>"+v.name+"</option>";
                             });
                             $("#systemTagListPid").html(html).removeClass('none');
                         }else{
                             var html = '<option value=0>请选择</option>';
                             $("#systemTagListPid").html(html);
                         }

                     });
                 }
             });
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
         $.RemoveList1 = function(obj,id,pk,controller,action){
             var ids =  new Array();
             var flage = 0;
             if(typeof id == "undefined" || id == ''){
                 id = 'checkListTable';
             }
             $("#" + id + " input:checked[name='key']").each(function(){
                 if(!$(this).hasClass('disabled')){
                     var auto_type = parseInt($("#autoType_"+this.value).attr("attr-auto_type"));
                     if(auto_type == parseInt(1)){
                         flage = 1;
                     }
                     if(auto_type == parseInt(2)){
                         flage = 2;
                     }
                     ids.push(this.value);
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
             ids = ids.join(',');
             if(ids == ''){
                 $.ShowAlert('请选择要删除的项');
                 return false;
             }
             $.ShowConfirm('你确定要删除吗？',function(){
                 var query = new Object();
                 query.id = ids;
                 if(typeof controller == "undefined" || controller == ''){
                     controller = CURR_CONTROLLER;
                 }
                 if(typeof action == "undefined" || action == ''){
                     action = 'destroy';
                 }
                 if(typeof pk != "undefined"){
                     query.pk = pk;
                 }
                 $.post(SITE_URL + '/' + controller + '/' + action, query, function(result){
                     if(result.status == 1){
                         location.reload(true);
                     }else{
                         $.ShowAlert(result.msg);
                     }
                 },'json');
             });
             return false;
         }

         //添加页码
        $(".edits").bind("click",function(){
            var editHref = $(this).attr('href');
            editPageHref = editHref + "&cateId=" + "{{ Input::get('cateId') ? Input::get('cateId') : 0 }}" + "&listPage=" + "{{ Input::get('page') ? Input::get('page') : 1 }}";
            $(this).attr('href',editPageHref);
        });

    </script>
@stop