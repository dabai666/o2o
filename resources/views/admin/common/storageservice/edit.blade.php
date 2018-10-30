@extends('admin._layouts.base')
@section('css')
	<style type="text/css">
		.ts1{color: #ccc;margin-left: 5px;}
	</style>
@stop
@section('right_content')
	@yizan_begin
	<yz:form id="yz_form" action="save">
		<yz:fitem name="name" label="仓储公司" attr="maxlength='20'"></yz:fitem>
		<yz:fitem name="url" label="仓储公司外链" attr="maxlength='50'"></yz:fitem>
		<div class="notTopTag">
			<yz:fitem name="img" label="仓储公司图片" type="image" append="1">
				<div><span style="color: red;">建议尺寸：全屏广告图宽度440*100px</span></div>
			</yz:fitem>
		</div>
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