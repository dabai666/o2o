@extends('admin._layouts.base')
@section('css')
<style type="text/css">
	.ts1{color: #ccc;margin-left: 5px;}
</style>
@stop
@section('right_content')
	@yizan_begin
		<yz:form id="yz_form" action="save">
			<yz:fitem name="name" label="品牌名称" attr="maxlength='20'"></yz:fitem>
	        <div class="notTopTag @if($data['pid'] == 0) none @endif">
				<yz:fitem name="img" label="标签图标" type="image" append="1">
					<div><small class='cred pl10 gray'>建议尺寸：512px*512px，支持JPG/PNG格式</small></div>
				</yz:fitem>
			</div>
			<yz:fitem name="introduce" label="品牌说明">
				<yz:Editor name="introduce" value="{{ $data['introduce'] }}"></yz:Editor>
			</yz:fitem>
			<yz:fitem name="url" label="企业网址" attr="maxlength='200'"></yz:fitem>
			<yz:fitem label="证书图片">
				<yz:imageList name="images." images="$data['honorImg']" ></yz:imageList><!--required="false" tip = "推荐图片大小380*380px"-->
				<attrs>
					<btip><![CDATA[380*380]]></btip>
				</attrs>
			</yz:fitem>
			<yz:fitem label="状态">
				<yz:radio name="status" options="1,0" texts="开启,关闭" default="1" checked="$data['status']"></yz:radio>
			</yz:fitem>
		</yz:form>
	@yizan_end
@stop
@section('js')
<script type="text/javascript">
	$(function(){

		//显示隐藏标签分类和分类图标
		$.notTopTag = function(value)
		{
			if(value == 0)
			{
				//顶级分类
				$(".notTopTag").addClass("none");
			}
			else
			{
				$(".notTopTag").removeClass("none");
			}
		}

		//进入检测
		var tagpid = $("#pid").val();
		$.notTopTag(tagpid);

		//切换检测
		$("#pid").change(function(){
			$.notTopTag($(this).val());
		});


	});
	
</script>
@stop