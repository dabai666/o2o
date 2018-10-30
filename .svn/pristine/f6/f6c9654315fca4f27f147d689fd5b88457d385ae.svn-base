@extends('admin._layouts.base')

<?php
$type = [
	['key'=>'1','name'=>'金融超市'],
	['key'=>'2','name'=>'物流公司'],
    ['key'=>'3','name'=>'秒杀活动'],
    ['key'=>'4','name'=>'优惠券'],
];
$data['type'] = isset($data['type']) ? $data['type'] : 1;

if ((int)$data['position']['id'] > 0) {
    $sellerCateStyle = $bsAdvPositionId == $data['position']['id'] ? '' : 'display:none';
} else {
    $sellerCateStyle = $bsAdvPositionId == $positions[0]['id'] ? '' : 'display:none';
}

?>

@section('right_content')
@yizan_begin
<yz:form id="yz_form" action="update">
	<yz:fitem name="name" label="名称"></yz:fitem>
    <yz:fitem name="produce" label="说明"></yz:fitem>
    @yizan_yield('adv_wapmodule')
    	<yz:fitem name="image" label="背景图片" type="image" tip="建议尺寸广告位图片100*100px"></yz:fitem>
        <yz:fitem name="type" label="链接类型">
    		<yz:select name="type" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type']"></yz:select>
    	</yz:fitem>
    @yizan_stop
    	<fitem type="script">
    	<script type="text/javascript">
    		jQuery(function($){
                $("select[name=positionId]").change(function() {
                    var bsAdvPositionId = "{{ $bsAdvPositionId }}";
                    var val = $(this).val();
                    if(val == bsAdvPositionId){
                        $("#sellerCateId-form-item").css("display", "block");
                    }else{
                        $("#sellerCateId-form-item").css("display", "none");
                    }
                })
                $("select[name=type]").change(function() {
                    $("input[name='arg']").val("");
                	var type = $("select[name='type'] option:selected").val(); 
                	if(type == 1){
                		$('#sellerCate-form-item').show();
                		$('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').hide();
                		$('#systemSellers-form-item').hide();
                        $('#article-form-item').hide();
                		$('#url-form-item').hide();
                	}else if(type == 7){
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').hide();
                        $('#systemSellers-form-item').hide();
                        $('#article-form-item').show();
                        $('#url-form-item').hide();
                    }else if(type == 3){
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').show();
                        $('#serviceGoods-form-item').hide();
                        $('#systemSellers-form-item').hide();
                        $('#article-form-item').hide();
                        $('#url-form-item').hide();
                        window.open("{!! u('Service/index') !!}");
    				}else if(type == 4){
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').hide();
                        $('#systemSellers-form-item').show();
                        $('#article-form-item').hide();
                        $('#url-form-item').hide();
                        window.open("{!! u('Service/index') !!}");
    				}else if(type == 5){
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').hide();
                        $('#systemSellers-form-item').hide();
                        $('#article-form-item').hide();
                        $('#url-form-item').show();
                    }else if(type == 6){
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').show();
                        $('#systemSellers-form-item').hide();
                        $('#article-form-item').hide();
                        $('#url-form-item').hide();
                        window.open("{!! u('Service/index') !!}");
                    }else {
                        $('#sellerCate-form-item').hide();
                        $('#sellerGoods-form-item').hide();
                        $('#serviceGoods-form-item').hide();
                        $('#systemSellers-form-item').hide();
                        $('#article-form-item').hide();
                        $('#url-form-item').hide();
    				}
                });
                $("select[name=type]").trigger('change');
                $("#sellerGoods option[value='-1']").attr("disabled","disabled");
    		});
    	</script>
    	</fitem>
        <yz:fitem name="arg" type="hidden" val="$data['arg']"></yz:fitem>
    	<script type="text/javascript">
    		jQuery(function($){
                $("input[name='arg']").val("{{$data['arg']}}");
                $("#url").val("{{$data['arg']}}");
                $("#sellerGoods").val("{{$data['arg']}}");
                $("#serviceGoods").val("{{$data['arg']}}");
                $("#systemSellers").val("{{$data['arg']}}");
                $("#article").val("{{$data['arg']}}");
            	$('#sellerCate').change(function() {
        			$("input[name='arg']").val($("select[name='sellerCate'] option:selected").val());
        		});
                $('#sellerGoods').blur(function() {
                    $("input[name='arg']").val($("input[name='sellerGoods']").val());
                });
                $('#serviceGoods').blur(function() {
                    $("input[name='arg']").val($("input[name='serviceGoods']").val());
                });
                $('#systemSellers').blur(function() {
                    $("input[name='arg']").val($("input[name='systemSellers']").val());
                });
                $('#article').change(function() { 
                    $("input[name='arg']").val($("select[name='article'] option:selected").val()); 
                });
        		$('#url').keyup(function() {
        			$("input[name='arg']").val($("input[name='url']").val());
        		});
        		var types = "{{$data['type']}}";
        		if(types == 1){
                    $('#sellerCate-form-item').show();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').hide();
                    $('#url-form-item').hide();
                }else if(types == 7){
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').show();
                    $('#url-form-item').hide();
                    window.open("{!! u('Service/index') !!}");
                }else if(types == 3){
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').show();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').hide();
                    $('#url-form-item').hide();
                    window.open("{!! u('Service/index') !!}");
    			}else if(types == 4){
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').show();
                    $('#article-form-item').hide();
                    $('#url-form-item').hide();
                    window.open("{!! u('Service/index') !!}");
    			}else if(types == 5){
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').hide();
                    $('#url-form-item').show();
    			}else if(types == 6){
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').show();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').hide();
                    $('#url-form-item').hide();
                    window.open("{!! u('Service/index') !!}");
                }else {
                    $('#sellerCate-form-item').hide();
                    $('#sellerGoods-form-item').hide();
                    $('#serviceGoods-form-item').hide();
                    $('#systemSellers-form-item').hide();
                    $('#article-form-item').hide();
                    $('#url-form-item').hide();
    			}
            });
    	</script>
	<yz:fitem name="sort" label="排序" val="100"></yz:fitem>
	<yz:fitem name="status" label="状态">
		<yz:radio name="status" options="0,1" texts="禁用,启用" checked="$data['status']"></yz:radio>
	</yz:fitem>
</yz:form>
@yizan_end
@stop
@section('js')
    <script type="text/javascript">
        $("#image-form-item .f-boxr span").css('color','red');
    </script>
@stop

