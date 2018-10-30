@extends('admin._layouts.base')
@section('css')

@stop
@section('right_content')
	@yizan_begin
	<yz:form id="yz_form" action="edit">
		<yz:fitem name="image"   label="活动秒杀banner" type="image" ></yz:fitem>
		<yz:fitem name="seckill_produce" label="活动介绍">
			<yz:editor name="seckill_produce" value="{{$data['seckill_produce']}}" ></yz:editor>
		</yz:fitem>
		</yz:form>
	@yizan_end
@stop

@section('js')
	<script>
		$("#share_start_time").val("{{ $share_start_time }}");
		$("#share_end_time").val("{{ $share_end_time }}")
	</script>
@stop
