@extends('admin._layouts.base')

<?php
$type = [
        ['key'=>'1','name'=>'商家分类'],
        ['key'=>'3','name'=>'普通商品'],
        ['key'=>'4','name'=>'商家'],
        ['key'=>'5','name'=>'自定义URL'],
        ['key'=>'6','name'=>'服务商品'],
        ['key'=>'7','name'=>'文章'],
        ['key'=>'8','name'=>'签到送积分'],
        ['key'=>'9','name'=>'积分商城'],
        ['key'=>'10','name'=>'自营商城'],
        ['key'=>'11','name'=>'物业管理'],
        ['key'=>'12','name'=>'生活缴费'],
        ['key'=>'13','name'=>'促销活动'],
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
        {{--<yz:fitem  pstyle="display:none;"  name="editflag">--}}
            {{--<input type="text" value="{{$data['id']}}" name="editflag" class="u-ipttext" />--}}
        {{--</yz:fitem>--}}


        <yz:fitem name="name" label="名称"></yz:fitem>
        @yizan_yield('adv_wapmodule')
        <yz:fitem name="positionId" label="广告位编号">
            <yz:select name="positionId" options="$positions" valuefield="id" textfield="name" selected="$data['position']['id']"></yz:select>
        </yz:fitem>
        <yz:fitem name="cityId" label="城市">
            <yz:select name="cityId" css="type" options="$citys" textfield="name" valuefield="id" selected="$data['cityId']"></yz:select>
        </yz:fitem>
        <yz:fitem name="flage" label="广告位样式">
            <yz:radio name="flage" options="0,1,2" texts="单个广告,1+3广告,4+4品牌轮播广告" checked="$data['flage']"></yz:radio>
        </yz:fitem>
        <div class="" id="flage1">
            <yz:fitem name="sellerCateId" label="商家分类" pstyle="{{ $sellerCateStyle }}">
                <select id="sellerCateId" name="sellerCateId" style="min-width:200px;width:auto" class="sle ">
                    @foreach($sellerCate as $item)
                        @if($item['childs'])
                            <optgroup label="{{$item['name']}}">
                                @foreach($item['childs'] as $child)
                                    <option value="{{$child['id']}}" @if($data['sellerCateId'] == $child['id'])selected="selected"@endif>{{$child['name']}}</option>
                                @endforeach
                            </optgroup>
                        @else
                            <option value="{{$item['id']}}" @if($data['sellerCateId'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                        @endif
                    @endforeach
                </select>
                <span class="ts ts1">商家列表页广告位专用</span>
            </yz:fitem>
            <yz:fitem name="bgColor" label="背景颜色">
                <yz:Color name="bgColor" val="{{$data['bgColor']}}"></yz:Color>
            </yz:fitem>
            <yz:fitem name="image" label="图片" type="image" tip="建议尺寸：全屏广告图宽度640px；半展广告图宽度320px；启动页广告图宽度750px，高度1334px。"></yz:fitem>
            <yz:fitem name="type" label="广告链接类型">
                <yz:select name="type" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type']"></yz:select>
            </yz:fitem>
            <yz:fitem pstyle="display:none;"  name="sellerCate" label="选择商家分类">
                <select id="sellerCate" name="sellerCate" style="min-width:200px;width:auto" class="sle ">
                    @foreach($sellerCate as $item)
                        <option value="{{$item['id']}}" @if($data['arg'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                        @if($item['childs'])
                            @foreach($item['childs'] as $child)
                                <option value="{{$child['id']}}" @if($data['arg'] == $child['id'])selected="selected"@endif style="margin-left: 10px;">----{{$child['name']}}</option>
                            @endforeach
                        @endif
                    @endforeach
                </select>
                <span class="ts ts1"></span>
            </yz:fitem>
            <yz:fitem pstyle="display:none;"  name="sellerGoods" label="商品编号参数">
                <input type="text" name="sellerGoods" id="sellerGoods" class="u-ipttext" value="">
                <span class="ts ts1">请到商家页面查看商品编号后填写</span>
            </yz:fitem>
            <yz:fitem  pstyle="display:none;" name="systemSellers" label="商家编号参数">
                <input type="text" name="systemSellers" id="systemSellers" class="u-ipttext" value="">
                <span class="ts ts1">请到商家页面查看商家编号后填写</span>
            </yz:fitem>
            <yz:fitem  pstyle="display:none;" name="activityId" label="活动编号参数">
                <input type="text" name="activityId" id="activityId" class="u-ipttext" value="">
                <span class="ts ts1">请到活动页面查看活动编号后填写</span>
            </yz:fitem>
            <yz:fitem pstyle="display:none;"  name="article" label="选择文章">
                <select id="article" name="article" style="min-width:200px;width:auto" class="sle ">
                    <option value="0" >请选择</option>
                    @foreach($article as $item)
                        <option value="{{$item['id']}}" @if($data['arg'] == $item['id'])selected="selected"@endif>{{$item['title']}}</option>
                    @endforeach
                </select>
                <span class="ts ts1"></span>
            </yz:fitem>
            <yz:fitem  pstyle="display:none;" name="url" label="输入路径"></yz:fitem>
        </div>
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

                    //广告位样式
                    $("input[name=flage]").change(function(){
                        var adtype=$("input[name=flage]:checked").val();
                        if(adtype==0){ //单个广告
                            $('#flage1').show();
                            $("#flage3").hide();
                            $('#flage2').hide();
                        }else if(adtype == 2){
                            $('#flage1').hide();
                            $("#flage3").show();
                            $('#flage2').hide();
                            $("#image1-form-item .f-boxr span").css('color','red');
                            $("#image2-form-item .f-boxr span").css('color','red');
                            $("#image3-form-item .f-boxr span").css('color','red');
                            $("#image4-form-item .f-boxr span").css('color','red');
                        }else{ //1+3个广告
                            $('#flage1').hide();
                            $("#flage3").hide();
                            $('#flage2').show();
                        }
                    })

                    if("{{$data['flage']}}"==0){
                        $('#flage1').show();
                        $('#flage2').hide();
                        $('#flage3').hide();
                    }else if("{{$data['flage']}}"==2){
                        $('#flage1').hide();
                        $('#flage2').hide();
                        $('#flage3').show();
                    }else{
                        $('#flage1').hide();
                        $('#flage2').show();
                        $('#flage3').hide();
                    }

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
                            $('#activityId-form-item').hide();
                        }else if(type == 7){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').hide();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').show();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').hide();
                        }else if(type == 3){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').show();
                            $('#serviceGoods-form-item').hide();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').hide();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').hide();
                            window.open("{!! u('Service/index') !!}");
                        }else if(type == 4){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').hide();
                            $('#systemSellers-form-item').show();
                            $('#article-form-item').hide();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').hide();
                            window.open("{!! u('Service/index') !!}");
                        }else if(type == 5){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').hide();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').hide();
                            $('#url-form-item').show();
                            $('#activityId-form-item').hide();
                        }else if(type == 6){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').show();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').hide();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').hide();
                            window.open("{!! u('Service/index') !!}");
                        }else if(type == 13){
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').show();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').hide();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').show();
                            window.open("{!! u('Activity/index',['type'=>'8']) !!}");
                        }else {
                            $('#sellerCate-form-item').hide();
                            $('#sellerGoods-form-item').hide();
                            $('#serviceGoods-form-item').hide();
                            $('#systemSellers-form-item').hide();
                            $('#article-form-item').hide();
                            $('#url-form-item').hide();
                            $('#activityId-form-item').hide();
                        }
                    });
                    $("select[name=type]").trigger('change');
                    $("#sellerGoods option[value='-1']").attr("disabled","disabled");
                });
            </script>
        </fitem>
        <script type="text/javascript">
            jQuery(function($){
                $("input[name='arg']").val("{{$data['arg']}}");
                $("#url").val("{{$data['arg']}}");
                $("#sellerGoods").val("{{$data['arg']}}");
                $("#serviceGoods").val("{{$data['arg']}}");
                $("#systemSellers").val("{{$data['arg']}}");
                $("#article").val("{{$data['arg']}}");
                $("#activityId").val("{{$data['arg']}}");
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
        <yz:fitem name="arg" type="hidden" val="$data['arg']"></yz:fitem>
        <yz:fitem name="sort" label="排序"></yz:fitem>
        <yz:fitem name="status" label="状态">
            <yz:radio name="status" options="0,1" texts="禁用,启用" checked="$data['status']"></yz:radio>
        </yz:fitem>
        <div id="flage2" class="">
            <div>
                <div style="background: rgb(204,204,204);" class="u-fitem clearfix"><span class="f-tt">顶部广告位</span></div>
                <yz:fitem name="image1" label="图片" type="image" tip="建议尺寸：全屏广告图宽度760px,100%宽度自适应"></yz:fitem>
                <yz:fitem name="type1" label="广告链接类型">
                    <yz:select name="type1" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type1']"></yz:select>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerCate1" label="选择商家分类">
                    <select id="sellerCate1" name="sellerCate1" style="min-width:200px;width:auto" class="sle ">
                        @foreach($sellerCate as $item)
                            <option value="{{$item['id']}}" @if($data['arg1'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                            @if($item['childs'])
                                @foreach($item['childs'] as $child)
                                    <option value="{{$child['id']}}" @if($data['arg1'] == $child['id'])selected="selected"@endif style="margin-left: 10px;">----{{$child['name']}}</option>
                                @endforeach
                            @endif
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerGoods1" label="商品编号参数">
                    <input type="text" name="sellerGoods1" id="sellerGoods1" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商品编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="serviceGoods1" label="服务编号参数">
                    <input type="text" name="serviceGoods1" id="serviceGoods1" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看服务编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="systemSellers1" label="商家编号参数">
                    <input type="text" name="systemSellers1" id="systemSellers1" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商家编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="activityId1" label="活动编号参数">
                    <input type="text" name="activityId1" id="activityId1" class="u-ipttext" value="">
                    <span class="ts ts1">请到活动页面查看活动编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="article1" label="选择文章">
                    <select id="article1" name="article1" style="min-width:200px;width:auto" class="sle ">
                        <option value="0" >请选择</option>
                        @foreach($article as $item)
                            <option value="{{$item['id']}}" @if($data['arg1'] == $item['id'])selected="selected"@endif>{{$item['title']}}</option>
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="url1" label="输入路径"></yz:fitem>
                <fitem type="script">
                    <script type="text/javascript">
                        jQuery(function($){
                            if("{{$data['type1']}}"==3){//商品编号参数
                                $("#sellerGoods1").val("{{$data['arg1']}}");
                            }else if("{{$data['type1']}}"==4){//商家编号参数
                                $("#systemSellers1").val("{{$data['arg1']}}");
                            }else if("{{$data['type1']}}"==5){//自定义URL
                                $("#url1").val("{{$data['arg1']}}");
                            }else if("{{$data['type1']}}"==6){//服务商品
                                $("#serviceGoods1").val("{{$data['arg1']}}");
                            }else if("{{$data['type1']}}"==13){//促销商品
                                $("#activityId1").val("{{$data['arg1']}}");
                            }

                            $("select[name=type1]").change(function() {
                                $("input[name='arg']").val("");
                                var type = $("select[name='type1'] option:selected").val();
                                if(type == 1){
                                    $('#sellerCate1-form-item').show();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                }else if(type == 7){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').show();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                }else if(type == 3){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').show();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 4){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').show();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 5){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                    $('#url1-form-item').show();
                                }else if(type == 6){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').show();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 13){
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").show();
                                    window.open("{!! u('Activity/index',['type'=>8]) !!}");
                                }else {
                                    $('#sellerCate1-form-item').hide();
                                    $('#sellerGoods1-form-item').hide();
                                    $('#serviceGoods1-form-item').hide();
                                    $('#systemSellers1-form-item').hide();
                                    $('#article1-form-item').hide();
                                    $('#url1-form-item').hide();
                                    $("#activityId1-form-item").hide();
                                }
                            });
                            $("select[name=type1]").trigger('change');
                            $("#sellerGoods1 option[value='-1']").attr("disabled","disabled");
                        });
                    </script>
                </fitem>
            </div>
            <div>
                <div style="background: rgb(204,204,204);" class="u-fitem clearfix"><span class="f-tt">第一广告位</span></div>
                <yz:fitem name="title2" label="第一广告标题"></yz:fitem>
                <yz:fitem name="instruction2" label="第一广告说明" ></yz:fitem>
                <yz:fitem name="instruction2Bg" label="第一广告说明字体颜色" tip="例：#ffffff">
                    <yz:Color name="instruction2Bg" val="{{$data['instruction2Bg']}}"></yz:Color>
                </yz:fitem>
                <yz:fitem name="image2" label="图片" type="image" tip="建议尺寸广告位图片60*60px"></yz:fitem>
                <yz:fitem name="type2" label="广告链接类型">
                    <yz:select name="type2" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type2']"></yz:select>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerCate2" label="选择商家分类">
                    <select id="sellerCate" name="sellerCate2" style="min-width:200px;width:auto" class="sle ">
                        @foreach($sellerCate as $item)
                            <option value="{{$item['id']}}" @if($data['arg2'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                            @if($item['childs'])
                                @foreach($item['childs'] as $child)
                                    <option value="{{$child['id']}}" @if($data['arg2'] == $child['id'])selected="selected"@endif style="margin-left: 10px;">----{{$child['name']}}</option>
                                @endforeach
                            @endif
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerGoods2" label="商品编号参数">
                    <input type="text" name="sellerGoods2" id="sellerGoods2" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商品编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="serviceGoods2" label="服务编号参数">
                    <input type="text" name="serviceGoods2" id="serviceGoods2" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看服务编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="systemSellers2" label="商家编号参数">
                    <input type="text" name="systemSellers2" id="systemSellers2" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商家编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="activityId2" label="活动编号参数">
                    <input type="text" name="activityId2" id="activityId2" class="u-ipttext" value="">
                    <span class="ts ts1">请到活动页面查看活动编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="article2" label="选择文章">
                    <select id="article2" name="article2" style="min-width:200px;width:auto" class="sle ">
                        <option value="0" >请选择</option>
                        @foreach($article as $item)
                            <option value="{{$item['id']}}" @if($data['arg2'] == $item['id'])selected="selected"@endif>{{$item['title']}}</option>
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="url2" label="输入路径"></yz:fitem>
                <fitem type="script">
                    <script type="text/javascript">
                        jQuery(function($){
                            if("{{$data['type2']}}"==3){//商品编号参数
                                $("#sellerGoods2").val("{{$data['arg2']}}");
                            }else if("{{$data['type2']}}"==4){//商家编号参数
                                $("#systemSellers2").val("{{$data['arg2']}}");
                            }else if("{{$data['type2']}}"==5){//自定义URL
                                $("#url2").val("{{$data['arg2']}}");
                            }else if("{{$data['type2']}}"==6){//服务商品
                                $("#serviceGoods2").val("{{$data['arg2']}}");
                            }else if("{{$data['type2']}}"==13){//促销商品
                                $("#activityId2").val("{{$data['arg2']}}");
                            }

                            $("select[name=type2]").change(function() {
                                $("input[name='arg']").val("");
                                var type = $("select[name='type2'] option:selected").val();
                                if(type == 1){
                                    $('#sellerCate2-form-item').show();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                }else if(type == 7){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').show();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                }else if(type == 3){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').show();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 4){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').show();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 5){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                    $('#url2-form-item').show();
                                }else if(type == 6){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').show();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 13){
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").show();
                                    window.open("{!! u('Activity/index',['type'=>8]) !!}");
                                }else {
                                    $('#sellerCate2-form-item').hide();
                                    $('#sellerGoods2-form-item').hide();
                                    $('#serviceGoods2-form-item').hide();
                                    $('#systemSellers2-form-item').hide();
                                    $('#article2-form-item').hide();
                                    $('#url2-form-item').hide();
                                    $("#activityId2-form-item").hide();
                                }
                            });
                            $("select[name=type2]").trigger('change');
                            $("#sellerGoods2 option[value='-1']").attr("disabled","disabled");
                        });
                    </script>
                </fitem>
            </div>
            <div>
                <div style="background: rgb(204,204,204);" class="u-fitem clearfix"><span class="f-tt">第二广告位</span></div>
                <yz:fitem name="title3" label="第二广告标题"></yz:fitem>
                <yz:fitem name="instruction3" label="第二广告说明"></yz:fitem>
                <yz:fitem name="instruction3Bg" label="第二广告说明字体颜色" tip="例：#ffffff">
                    <yz:Color name="instruction3Bg" val="{{$data['instruction3Bg']}}"></yz:Color>
                </yz:fitem>
                <yz:fitem name="image3" label="图片" type="image" tip="建议尺寸广告位图片60*60px"></yz:fitem>
                <yz:fitem name="type" label="广告链接类型">
                    <yz:select name="type3" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type3']"></yz:select>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerCate3" label="选择商家分类">
                    <select id="sellerCate" name="sellerCate3" style="min-width:200px;width:auto" class="sle ">
                        @foreach($sellerCate as $item)
                            <option value="{{$item['id']}}" @if($data['arg3'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                            @if($item['childs'])
                                @foreach($item['childs'] as $child)
                                    <option value="{{$child['id']}}" @if($data['arg3'] == $child['id'])selected="selected"@endif style="margin-left: 10px;">----{{$child['name']}}</option>
                                @endforeach
                            @endif
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerGoods3" label="商品编号参数">
                    <input type="text" name="sellerGoods3" id="sellerGoods3" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商品编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="serviceGoods3" label="服务编号参数">
                    <input type="text" name="serviceGoods3" id="serviceGoods3" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看服务编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="systemSellers3" label="商家编号参数">
                    <input type="text" name="systemSellers3" id="systemSellers3" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商家编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="activityId3" label="活动编号参数">
                    <input type="text" name="activityId3" id="activityId3" class="u-ipttext" value="">
                    <span class="ts ts1">请到活动页面查看活动编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="article3" label="选择文章">
                    <select id="article3" name="article3" style="min-width:200px;width:auto" class="sle ">
                        <option value="0" >请选择</option>
                        @foreach($article as $item)
                            <option value="{{$item['id']}}" @if($data['arg3'] == $item['id'])selected="selected"@endif>{{$item['title']}}</option>
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="url3" label="输入路径"></yz:fitem>
                <fitem type="script">
                    <script type="text/javascript">
                        jQuery(function($){
                            if("{{$data['type3']}}"==3){//商品编号参数
                                $("#sellerGoods3").val("{{$data['arg3']}}");
                            }else if("{{$data['type3']}}"==4){//商家编号参数
                                $("#systemSellers3").val("{{$data['arg3']}}");
                            }else if("{{$data['type3']}}"==5){//自定义URL
                                $("#url3").val("{{$data['arg3']}}");
                            }else if("{{$data['type3']}}"==6){//服务商品
                                $("#serviceGoods3").val("{{$data['arg3']}}");
                            }else if("{{$data['type3']}}"==13){//促销商品
                                $("#activityId3").val("{{$data['arg3']}}");
                            }

                            $("select[name=type3]").change(function() {
                                $("input[name='arg']").val("");
                                var type = $("select[name='type3'] option:selected").val();
                                if(type == 1){
                                    $('#sellerCate3-form-item').show();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                }else if(type == 7){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').show();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                }else if(type == 3){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').show();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 4){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').show();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 5){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                    $('#url3-form-item').show();
                                }else if(type == 6){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').show();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 13){
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").show();
                                    window.open("{!! u('Activity/index',['type'=>8]) !!}");
                                }else {
                                    $('#sellerCate3-form-item').hide();
                                    $('#sellerGoods3-form-item').hide();
                                    $('#serviceGoods3-form-item').hide();
                                    $('#systemSellers3-form-item').hide();
                                    $('#article3-form-item').hide();
                                    $('#url3-form-item').hide();
                                    $("#activityId3-form-item").hide();
                                }
                            });
                            $("select[name=type3]").trigger('change');
                            $("#sellerGoods3 option[value='-1']").attr("disabled","disabled");
                        });
                    </script>
                </fitem>
            </div>
            <div>
                <div style="background: rgb(204,204,204);" class="u-fitem clearfix"><span class="f-tt">第三广告位</span></div>
                <yz:fitem name="title4" label="第三广告标题"></yz:fitem>
                <yz:fitem name="instruction4" label="第三广告说明"></yz:fitem>
                <yz:fitem name="instruction4Bg" label="第三广告说明字体颜色" tip="例：#ffffff">
                    <yz:Color name="instruction4Bg" val="{{$data['instruction4Bg']}}"></yz:Color>
                </yz:fitem>
                <yz:fitem name="image4" label="图片" type="image" tip="建议尺寸广告位图片60*60px"></yz:fitem>
                <yz:fitem name="type4" label="广告链接类型">
                    <yz:select name="type4" css="type" options="$type" textfield="name" valuefield="key" selected="$data['type4']"></yz:select>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerCate4" label="选择商家分类">
                    <select id="sellerCate" name="sellerCate4" style="min-width:200px;width:auto" class="sle ">
                        @foreach($sellerCate as $item)
                            <option value="{{$item['id']}}" @if($data['arg4'] == $item['id'])selected="selected"@endif>{{$item['name']}}</option>
                            @if($item['childs'])
                                @foreach($item['childs'] as $child)
                                    <option value="{{$child['id']}}" @if($data['arg4'] == $child['id'])selected="selected"@endif style="margin-left: 10px;">----{{$child['name']}}</option>
                                @endforeach
                            @endif
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="sellerGoods4" label="商品编号参数">
                    <input type="text" name="sellerGoods4" id="sellerGoods4" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商品编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="serviceGoods4" label="服务编号参数">
                    <input type="text" name="serviceGoods4" id="serviceGoods4" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看服务编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="systemSellers4" label="商家编号参数">
                    <input type="text" name="systemSellers4" id="systemSellers4" class="u-ipttext" value="">
                    <span class="ts ts1">请到商家页面查看商家编号后填写</span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="activityId4" label="活动编号参数">
                    <input type="text" name="activityId4" id="activityId4" class="u-ipttext" value="">
                    <span class="ts ts1">请到活动页面查看活动编号后填写</span>
                </yz:fitem>
                <yz:fitem pstyle="display:none;"  name="article4" label="选择文章">
                    <select id="article4" name="article4" style="min-width:200px;width:auto" class="sle ">
                        <option value="0" >请选择</option>
                        @foreach($article as $item)
                            <option value="{{$item['id']}}" @if($data['arg4'] == $item['id'])selected="selected"@endif>{{$item['title']}}</option>
                        @endforeach
                    </select>
                    <span class="ts ts1"></span>
                </yz:fitem>
                <yz:fitem  pstyle="display:none;" name="url4" label="输入路径"></yz:fitem>
                <fitem type="script">
                    <script type="text/javascript">
                        jQuery(function($){

                            if("{{$data['type4']}}"==3){//商品编号参数
                                $("#sellerGoods4").val("{{$data['arg4']}}");
                            }else if("{{$data['type4']}}"==4){//商家编号参数
                                $("#systemSellers4").val("{{$data['arg4']}}");
                            }else if("{{$data['type4']}}"==5){//自定义URL
                                $("#url4").val("{{$data['arg4']}}");
                            }else if("{{$data['type4']}}"==6){//服务商品
                                $("#serviceGoods4").val("{{$data['arg4']}}");
                            }else if("{{$data['type4']}}"==13){//促销商品
                                $("#activityId4").val("{{$data['arg4']}}");
                            }


                            $("select[name=type4]").change(function() {
                                $("input[name='arg']").val("");
                                var type = $("select[name='type4'] option:selected").val();
                                if(type == 1){
                                    $('#sellerCate4-form-item').show();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                }else if(type == 7){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').show();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                }else if(type == 3){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').show();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 4){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').show();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 5){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').show();
                                    $('#activityId4-form-item').hide();
                                }else if(type == 6){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                    window.open("{!! u('Service/index') !!}");
                                }else if(type == 13){
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').show();
                                    window.open("{!! u('Activity/index',['type'=>8]) !!}");
                                }else {
                                    $('#sellerCate4-form-item').hide();
                                    $('#sellerGoods4-form-item').hide();
                                    $('#serviceGoods4-form-item').hide();
                                    $('#systemSellers4-form-item').hide();
                                    $('#article4-form-item').hide();
                                    $('#url4-form-item').hide();
                                    $('#activityId4-form-item').hide();
                                }
                            });
                            $("select[name=type4]").trigger('change');
                            $("#sellerGoods4 option[value='-1']").attr("disabled","disabled");
                        });
                    </script>
                </fitem>
            </div>
        </div>
        <div id="flage3">
            <div style="background: rgb(204,204,204);" class="u-fitem clearfix"><span class="f-tt" style="width: 200px;">展示位(建议尺寸 : <span style="color:red;">160*120px</span>)</span></div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img0" label="第一品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId0" label="链接到品牌页">
                    <yz:select name="brandId0" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId0']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img1" label="第二品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId1" label="链接到品牌页">
                    <yz:select name="brandId1" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId1']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img2" label="第三品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId2" label="链接到品牌页">
                    <yz:select name="brandId2" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId2']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img3" label="第四品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId3" label="广告链接类型">
                    <yz:select name="brandId3" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId3']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img4" label="第五品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId4" label="链接到品牌页">
                    <yz:select name="brandId4" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId4']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img5" label="第六品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId5" label="链接到品牌页">
                    <yz:select name="brandId5" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId5']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img6" label="第七品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId6" label="链接到品牌页">
                    <yz:select name="brandId6" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId6']"></yz:select>
                </yz:fitem>
            </div>
            <div style="display: flex;width: 100%;">
                <yz:fitem name="img7" label="第八品牌展示位图片" type="image"></yz:fitem>
                <yz:fitem name="brandId7" label="链接到品牌页">
                    <yz:select name="brandId7" css="type" options="$shopBrand" textfield="name" valuefield="id" selected="$data['brandId7']"></yz:select>
                </yz:fitem>
            </div>
        </div>
    </yz:form>
    @yizan_end
@stop

