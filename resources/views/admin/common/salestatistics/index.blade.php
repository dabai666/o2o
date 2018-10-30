@extends('admin._layouts.base')
@section('css')
<style type="text/css">
	#checkListTable{table-layout:fixed;}
	.hoverred{color: #000}
	.hoverred:hover{color: red}
</style>
@stop
<?php
 $result = [
 	['id'=>'','name'=>'全部'],
 	['id'=>'good','name'=>'好评'],
 	['id'=>'neutral','name'=>'中评'],
 	['id'=>'bad','name'=>'差评'],
 ];
  $replyStatus = [
 	['id'=>'0','name'=>'全部'],
 	['id'=>'1','name'=>'未回复'],
 	['id'=>'2','name'=>'已回复'],
 ];
 ?>
@section('right_content')
	@yizan_begin
		<yz:list>
			<!--<search>
				<row>
					<item name="beginTime" label="开始时间" type="date"></item>
					<item name="endTime" label="结束时间" type="date"></item>
					<btn type="search"></btn>
					@if($error == 1)
						<span class="ts">*查询失败[error]：{{$data['msg']}}</span>
					@endif
				</row>-->
			</search>
			<!--<btns>
				<linkbtn label="删除" type="destroy"></linkbtn>
			</btns>-->

			<table checkbox="1">
				<columns>
					<column code="id" label="分类编号"></column>
					<column code="sellerName" label="商户名称"></column>
					<column code="name" label="分类名称"></column>
					<column code="totalNum" label="销售总数"></column>
					<!--<actions width="200">
						<actions>
							<action label="查看详情" css="blu">
								<attrs>
									<url>{{ u('OrderRate/detail', ['orderId'=>$list_item['order']['id']]) }}</url>
								</attrs>
							</action>
							<action label="订单" style="color:#000" target="_new" css="ml10">
								<attrs>
									<url>{{ u('Order/detail',['id'=> $list_item['orderId']]) }}</url>
								</attrs>
							</action>
							<action type="destroy" css="red ml10"></action>
						</actions>
					</actions>-->
				</columns>
			</table>

		</yz:list>
	@yizan_end
@stop

@section('js')
<script type="text/tpl" id="replyTpl">
<textarea id="replyContent" style="width:400px;height:100px;border:1px #ccc solid"></textarea>
</script>
<script type="text/javascript">
	//function reply(url) {
		//window.location.href = url;
		// $.ShowConfirm($("#replyTpl").html(), function(){
		// 	var content = $("#replyContent").val();
		// 	if(content.length > 0) {
		// 		$.post("{{ u('OrderRate/rateReply') }}",{"id":id,"content":content},function(res){
		// 			if(res.status==true){
		// 				window.location.reload();
		// 			}else{
		// 				$.ShowAlert(res.msg);
		// 			}
		// 		},'json')
		// 	}else{
		// 		$.ShowAlert("请填写回复内容");
		// 	}
		// },null,'评价回复');
	//}
</script>
@stop
