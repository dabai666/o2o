@extends('admin._layouts.base')

@section('right_content')
	@yizan_begin
	<yz:list>
		<btns>
			<linkbtn type="add" url="create"></linkbtn>
			<linkbtn label="删除" type="destroy"></linkbtn>
		</btns>
		<table relmodule="Adv" checkbox="1">
			<columns>
				@yizan_yield('adv_wapmodule')
					<column code="name" label="名称"></column>
				    <column code="url" label="链接地址"></column>
					<column code="sort" width="50" label="排序"></column>
					<column code="status" width="50" label="状态"  type="status"></column>
					<column code="createTime" label="创建时间" type="time" width="200"></column>
				@yizan_stop
				<actions width="100">
					<action type="edit" css="blu"></action>
					<action type="destroy" css="red"></action>
				</actions>
			</columns>
		</table>
	</yz:list>
	@yizan_end
@stop