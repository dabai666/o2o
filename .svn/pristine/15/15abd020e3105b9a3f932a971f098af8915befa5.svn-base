@extends('admin._layouts.base')
@section('css')
	<style type="text/css">
		.ts1{color: #ccc;margin-left: 5px;}
	</style>
@stop
@section('right_content')
	@yizan_begin
	<yz:form id="yz_form" action="save">
		<yz:fitem name="name" label="公司名称" attr="maxlength='20'"></yz:fitem>
		<div class="notTopTag">
			<yz:fitem name="logo" label="公司logo" type="image" append="1">
				<div><small class='cred pl10 gray'>建议尺寸：512px*512px，支持JPG/PNG格式</small></div>
			</yz:fitem>
		</div>
		<yz:fitem name="aging" label="时效" attr="maxlength='120'"></yz:fitem>
		<yz:fitem name="contacts" label="联系人" attr="maxlength='50'"></yz:fitem>
		<yz:fitem name="tel" label="联系电话" attr="maxlength='50'"></yz:fitem>
		<yz:fitem name="qq" label="联系qq" attr="maxlength='50'"></yz:fitem>
		<yz:fitem name="introduction" label="公司介绍">
			<yz:Editor name="introduction" value="{{ $data['introduction'] }}"></yz:Editor>
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