@extends('admin._layouts.base')
@section('css')
<style type="text/css">
</style>
@stop
@section('right_content')
	@yizan_begin
		<yz:list>
		<btns>
			<linkbtn label="添加品牌" url="{{ u('ShopBrand/create') }}"></linkbtn>
			<linkbtn label="删除" type="destroy"></linkbtn>
			<span style="color:#828282;">(品牌未占用时才能进行删除)</span>
		</btns>
		<table pager="no" checkbox="1">
			<columns>
				<column code="id" label="编号"></column>
				<!-- @if($list_item['pid']==0) -->
				<column code="name" label="品牌名称" align="left" style="font-weight:bold" css="name"></column>
				<!-- @else -->
				<column code="levelname" label="品牌名称" align="left" css="name">
					{!! $list_item['levelname'] !!}
				</column>
				<!-- @endif -->
				<!-- <column code="levelrel" label="层级视图" css="sort" align="left"></column> -->
				{{--<column code="tag.name" label="标签分类"></column>--}}
				{{--<column code="sort" label="排序" css="sort"></column>--}}
				<column code="status" label="状态" type="status"></column>
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