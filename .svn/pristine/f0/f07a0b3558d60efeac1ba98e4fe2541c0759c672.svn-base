@extends('admin._layouts.base')
@section('css')
	<style type="text/css">
	</style>
@stop
@section('right_content')
	@yizan_begin
	<yz:list>
		<!--<search>
				<row>
					<item name="districtName" label="小区名称"></item>
					<yz:fitem name="provinceId" label="所在地区">
						<yz:region name="provinceId" pval="$search_args['provinceId']" cval="$search_args['cityId']" new="1" aval="$search_args['areaId']" showtip="1"></yz:region>
					</yz:fitem>
					<btn type="search"></btn>
				</row>
			</search>-->
		<btns>
			<linkbtn label="添加物流公司" url="{{ u('LogisticsCompany/create') }}"></linkbtn>
			<linkbtn label="删除" type="destroy"></linkbtn>
			<span style="color:#828282;">(物流公司未占用时才能进行删除)</span>
		</btns>
		<table checkbox="1">
			<columns>
				<column code="id" label="编号"></column>
				<column code="name" label="公司名称" align="left" style="font-weight:bold" css="name"></column>
				<column code="aging" label="时效" align="left" style="font-weight:bold" css="name"></column>
				<column code="contacts" label="联系人" align="left" style="font-weight:bold" css="name"></column>
				<column code="tel" label="联系电话" align="left" style="font-weight:bold" css="name"></column>
				<column code="qq" label="QQ" align="left" style="font-weight:bold" css="name"></column>
				<actions>
					<action type="edit" css="blu"></action>
					<!-- @if( $list_item['isDel'] == 0 ) -->
					<action type="destroy" css="red"></action>
					<!-- @else -->
					<span css="gray" style="color:#ccc">删除</span>
					<script type="text/javascript">
						$(".tr-"+{{$list_item['id']}}+" input[name='key']").prop('disabled','disabled');
					</script>
					<!-- @endif -->
				</actions>
			</columns>

		</table>
	</yz:list>
	@yizan_end
@stop

@section('js')
	<script type="text/javascript">
		$(function(){
			$('#cate_id').prepend("<option value='0' selected>全部分类</option>");
		});
	</script>
@stop
