@extends('admin._layouts.base')
@section('css')
    <style type="text/css">
        .add_content{ width: 80px; height: 30px; cursor: pointer}
        .y-fenlei tr td{padding: 5px;}
        .y-fenlei ,.y-fenlei tr th,.y-fenlei tr td{border: 1px #ccc solid;text-align: center;}
        .y-fenlei{clear: both;width: 450px;margin-left:105px;}

        .form-tip{background-color: #F9F9F9;padding: 10px 0px;margin-bottom: 10px;}

        .sle{float: left;margin-right: 10px;}
        .y-yhqsl{width:70px;line-height: 30px;border: 1px solid #ddd;margin-right: 10px;text-align: center;}

        .ioio{border: 1px solid #000;padding-left: 5px; max-width: 650px; margin-top: 2px;}
        .cur{cursor: pointer;margin-left: 15px;}

    </style>
@stop
@section('right_content')
    @yizan_begin
    <script src="{{ asset('js/layer/layer.js') }}"></script>

    <yz:form id="yz_form" action="save_seckill_activity">

        <yz:fitem name="name" label="活动名称"></yz:fitem>
        <yz:fitem name="startTime" label="开始时间" type="datetime"></yz:fitem>
        <yz:fitem name="endTime" label="结束时间" type="datetime"></yz:fitem>
        <div id="bgimage-form-item" class="u-fitem clearfix " style="margin-left:40px;background:rgb(228,228,228);width: 60%;">
            <span class="f-tt" style="margin-left: -43px;">
		                 活动商品
		            </span>
        </div>
        <yz:fitem name="shopName" label="商品名称"></yz:fitem>
        <yz:fitem label="商品图片">
            <yz:imageList name="images." images="$data['images']"></yz:imageList>
            <div><small class='cred pl10 gray'>建议尺寸：750px*750px，支持JPG/PNG格式</small></div>
        </yz:fitem>
        <!--<div id="image-form-item" class="u-fitem clearfix ">
		            <span class="f-tt">
		                 商品图片:
		            </span>
            <div class="f-boxr">
                <ul class="m-tpyllst clearfix">
                    <li id="image-box" class="">
                        <a id="img-preview-image" class="m-tpyllst-img" href="javascript:;" target="_self">
                            @if(!empty($data['shopImage']))
                                <img src="{{$data['shopImage']}}" alt="">
                            @else
                                <img src="" alt="" style="display:none;">
                            @endif
                        </a>
                        <a class="m-tpyllst-btn img-update-btn" href="javascript:;" data-rel="image">
                            <i class="fa fa-plus"></i> 上传图片
                        </a>
                        @if(!empty($data['image']))
                            <input type="hidden" data-tip-rel="#image-box" name="image" id="image" value="{{$data['shopImage']}}">
                        @else
                            <input type="hidden" data-tip-rel="#image-box" name="image" id="image" value="">
                        @endif
                    </li>

                </ul>
            </div>
        </div> -->
        <yz:fitem name="salePrice" label="秒杀价格"></yz:fitem>
        <yz:fitem name="price" label="商品原价"></yz:fitem>
        <yz:fitem name="stock" label="商品库存"></yz:fitem>
        <yz:fitem name="buyLimit" label="每人限购"></yz:fitem>
        <yz:fitem name="brief" label="商品描述">
            <yz:Editor name="brief" value="{{ $data['brief'] }}"></yz:Editor>
        </yz:fitem>
        <div id="bgimage-form-item" class="u-fitem clearfix " style="margin-left:40px;background:rgb(228,228,228);width: 60%;">
            <span class="f-tt" style="margin-left: -43px;">
		                 活动商家
		            </span>
        </div>
        <yz:fitem label="活动商家">
            <yz:radio name="useSeller" options="0,1" texts="所有商家,指定商家" default="0" checked="$data['useSeller']"></yz:radio>
            <input type="button" value="+添加商家" class="p-addbtn" id="useSellerBtn" @if($data['useSeller'] != 1) style="display:none" @endif>
            <div id="useSellerList" @if($data['useSeller'] != 1) style="display:none" @endif>
                @if(count($sellerLists) > 0)
                    <ul class="p-sellerlist">
                        @foreach($sellerLists as $key => $value)
                            <li>
                                商家名称：<input type="text" value="{{$sellerLists[$key]['name']}}" class="u-ipttext addseller" data-sellerId='{{$key}}' disabled="true">
                                商品量: <input type="text" value="{{$sellerLists[$key]['totalStock']}}" name="stocks[{{$key}}]" class="u-ipttext addseller" data-sellerId='{{$key}}'>
                                <i class="fa fa-times mt8" aria-hidden="true"></i>
                                <input type="hidden" value="{{$key}}" name="ids[]">
                            </li>
                        @endforeach
                    </ul>
                @endif
            </div>
        </yz:fitem>
        <div id="bgimage-form-item" class="u-fitem clearfix " style="margin-left:40px;background:rgb(228,228,228);width: 60%;">
            <span class="f-tt" style="margin-left: -43px;">
		                 活动状态
		            </span>
        </div>
        <yz:fitem label="状态">
            <php> $data['status'] = isset($data['status']) ? $data['status'] : 1; </php>
            <yz:radio name="status" options="1,0" texts="启用,禁用" checked="$data['status']"></yz:radio>
        </yz:fitem>
    </yz:form>

    <div id="share3" style="display: none"><img src="{{ asset('images/share3.png') }}"></div>
    <div id="share2" style="display: none"><img src="{{ asset('images/share2.png') }}"></div>
    @yizan_end
@stop
@section('js')
    <script type="text/javascript">
        $(function(){
            if(parseInt("{{$data['useSeller']}}") > 0){
                $("#stock-form-item").hide();
            }else{
                $("#stock-form-item").show();
            }
            $("input[name='useSeller']").change(function(){
                $.useSeller($(this).val());
            });

            //所有商家,指定商家
            $.useSeller = function(useSeller){
                if(useSeller == 0)
                {
                    $("#stock-form-item").show();
                    $("#useSellerList,#useSellerBtn").hide();
                }
                else
                {
                    $("#stock-form-item").hide();
                    $("#useSellerList,#useSellerBtn").show();
                }
            }

            //添加指定商家时，保存现有数据
            $("input.p-addbtn").click(function(){
                var saveData = new Object();
                var sellerIds = [];
                var images = [];

                $.each($("#useSellerList ul li"), function(k, v){
                    sellerIds[k] = $(this).find('input.addseller').attr('data-sellerId');
                });

                $.each($("#image-list-1 li"),function(k,v){
                    var href = $(this).find('a.image-item').attr('href');
                    if(href != undefined){
                        images[k] = href;
                    }
                })

                saveData.form = $("#yz_form").serializeArray();
                saveData.sellerIds = sellerIds;
                saveData.images = images;
                saveData.brief = $("iframe").contents().find("body").html();
                $.post("{{ u('Activity/save_kill_data') }}", saveData, function(res){
                    window.location.href = "{{ u('Activity/addSeller', ['type' => 7]) }}";
                });
            });

            //删除指定商家
            $(".p-sellerlist li i.fa").click(function(){
                var s = $(this);
                var id = s.siblings("input.addseller").attr('data-sellerId');

                //异步请求
                $.post("{{ u('Activity/deleteSellerIds') }}", {'id':id,'type':7}, function(res){
                    //动画移除
                    if(res == 1){
                        s.parents("li").fadeOut(700,function(){
                            $(this).remove();
                        });
                    }
                });

            });

            //作废
            $("button.zfbtn").click(function(){
                var status = "{{$data['timeStatus']}}";
                var id = "{{$data['id']}}";

                if(status == 1)
                {
                    //进行中，结束
                    var statusStr = "活动正在进行中，您确定要作废当前活动？";
                }
                else
                {
                    //未开始，已结束，删除
                    var statusStr = "您确定要删除活动？";
                }

                if(confirm(statusStr))
                {
                    $.post("{{ u('Activity/cancellation') }}", {'id':id},function(res){
                        $.ShowAlert(res.msg);

                        if(res.code == 0)
                        {
                            setTimeout(function(){
                                if(status == 1)
                                {
                                    window.location.reload();
                                }
                                else
                                {
                                    window.location.href = "{{ u('Activity/index') }}";
                                }
                            },2000);

                        }
                    })
                }
            });

        })
    </script>
@stop
@section('js')
    <script type="text/javascript">
        $(document).ready(function() {
            $('.show').click(function(){
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: '690px',
                    skin: 'layui-layer-nobg',
                    shadeClose: true,
                    shade:0.8,
                    content: $('#share3')
                });
            })

            $('.show2').click(function(){
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: '600px',
                    skin: 'layui-layer-nobg',
                    shadeClose: true,
                    shade:0.8,
                    content: $('#share2')
                });
            })

            $(document).on('keyup afterpaste', '.my', function(event) {
                var value = parseInt(this.value);
                if (isNaN(value)) {
                    $(this).val('');
                    return;
                }
                $(this).val(value);
            });

            $.getPromotion = function() {
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                if(startTime == "" || endTime == "" ){
                    return false;
                }
                var i = 0;
                $('.count').each(function(){
                    i++;
                })

                $(".promotion-sle").html("<option value=''>正在加载中...</option>");
                $.post("{{ u('Activity/getpromotion') }}",{startTime:startTime,endTime2:endTime},function(result){
                    if(result.code == 0){
                        var html = '<option selected="" value="">选择优惠券</option>';
                        $(result.data.list).each(function(o){
                            html += '<option value="'+this.id+'">'+this.name+'</option>';
                        });
                        $('.promotion-sle').html(html);
                    }else{
                        $.ShowAlert("数据有错误！");
                        return false;
                    }
                },'json');
            }

            $("#startTime").change(function(){
                $.getPromotion();
            })

            $("#endTime").change(function(){
                $.getPromotion();
            })
        })
    </script>
@stop