@extends('staff.default._layouts.base')
@section('title'){{$title}}@stop
@section('css')
    <style>
        .modal.show_img_x  {
            width:inherit;
            left: 38%;
        }


        .service-deal {
            z-index: 99999 !important;
        }

        .y-addimg{width: 100%;box-sizing: border-box;padding-left: .5rem;margin-bottom: .5rem;}
        .y-addimg li{width: 22%;box-sizing: border-box;float: left;text-align: center;margin-right: 3%;color: #54abee;position: relative;max-height: 6.2rem;}
        .y-addimg li label{width: 100%;height: 100%;display: block;border-radius: 5px;overflow: hidden;}
        .y-addimg li p{position: absolute;top: 0;left: 0;z-index: 10;width: 100%;text-align: center;background: #f1f1f1;}
        .y-addimg li img{width: 100%;vertical-align: top;}
        .y-addimg li .delete{position: absolute;top: -10px;right: -10px;}
        input,div {font-size: 14px !important;}

        .add_goods_specifications1,.add_goods_specifications2{
            background: #f7f7f7;
            border-top: 1px solid #eaeaea;
            border-bottom: 1px solid #eaeaea;
            line-height: 2rem;
            padding: 0 .85rem;
            margin-bottom: .75rem;
            margin-top: -.75rem
        }

        .add_goods_specifications1 i {
            color: #55d020;
            font-size: 1.2rem
        }

        .add_goods_specifications1 p {
            color: #ff2c4c;
            font-size: .8rem;
            padding-left: .85rem
        }
        .add_goods_specifications2 i {
            color: #55d020;
            font-size: 1.2rem
        }

        .add_goods_specifications2 p {
            color: #ff2c4c;
            font-size: .8rem;
            padding-left: .85rem
        }
    </style>
@stop
@section('show_top')
    <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left" href="#" onclick="JumpURL('{{ u('Seller/commodity',['systemTagListPid' => $args['systemTagListPid'],'systemTagListId' => $args['systemTagListId'],'type' => 1,'tradeId'=>$args['tradeId'] ]) }}','#seller_goods_view',2)" data-transition='slide-out'>
            <span class="icon iconfont">&#xe64c;</span>
        </a>
        <span class="button button-link button-nav f_r" onclick="$.goodssave({{ $args['tradeId']}},1) ">
            完成
        </span>
        <h1 class="title">{{$title}}</h1>
    </header>
@stop
@section('css')
@stop
@section('distance')id="service-add" @stop
@section('content')
    <!--<form action="javascript:;" id="img">
        <label id="imglabel" class="img-up-lb" for="upload_but"  style="display:inline-block;width:100%;height:10rem;position:absolute;z-index:10000;">
            <input type="file"  id="upload_but" accept="image/*" style="display:none;" />
        </label>
    </form>-->

    <form action="javascript:;" id="goods-form">
        <div id="preview">
            <div class="content-block-title m10">商品图片(第一张为封面，最多4张)</div>
            <ul class="y-addimg clearfix">

                <?php $img = $showData['imgs'] != "" ? $showData['imgs'] : $data['images']; ?>

                @if($data)
                    <?php
                    $img = array_filter($img);
                    $count = count($img);
                    if($count < 4){
                        $mustcount = 4 -$count;
                    }else{
                        $mustcount = 0;
                    }
                    ?>
                    @foreach($img as $k=>$v)
                        <li id="li_{{$k}}">
                            <label id="imglabel-{{$k}}" for="image-form-{{$k}}">
                                <img data-num="{{$k}}" class="image_upload" src="{{ formatImage($v,640,640) }}">
                            </label>
                            <i class="delete tc" data-id="{{$k}}"><i class="icon iconfont f20">&#xe605;</i></i>
                            <input type="text" name="imgs[]" id="upimage_{{$k}}" value="{{$v}}" style="display:none">
                        </li>
                    @endforeach
                    @if($mustcount > 0)
                        @for($i=0; $i<$mustcount; $i++)
                            <li id="li_{{$i+$count}}">
                                <label id="imglabel-{{$i+$count}}" for="image-form-{{$i+$count}}">
                                    <img data-num="{{$i+$count}}" class="image_upload"  src="{{ asset('wap/community/newclient/images/addpic.png') }}">
                                </label>
                                <i class="delete tc none" data-id="{{$i+$count}}"><i class="icon iconfont f20">&#xe605;</i></i>
                                <input type="text" name="imgs[]" id="upimage_{{$i+$count}}" style="display:none">
                            </li>
                        @endfor
                    @endif
                @else
                    @if($img != "")
                        <?php
                        $img = array_filter($img);
                        $count = count($img);
                        if($count < 4){
                            $mustcount = 4 -$count;
                        }else{
                            $mustcount = 0;
                        }
                        ?>
                        @foreach($img as $k=>$v)
                            <li id="li_{{$k}}">
                                <label id="imglabel-{{$k}}" for="image-form-{{$k}}">
                                    <img data-num="{{$k}}" class="image_upload" src="{{ formatImage($v,640,640) }}">
                                </label>
                                <i class="delete tc" data-id="{{$k}}"><i class="icon iconfont f20">&#xe605;</i></i>
                                <input type="text" name="imgs[]" id="upimage_{{$k}}" value="{{$v}}" style="display:none">
                                <input id="image-form-{{$k}}" type="file" accept="image/*" style="display:none" />
                            </li>
                        @endforeach
                        @if($mustcount > 0)
                            @for($i=0; $i<$mustcount; $i++)
                                <li id="li_{{$i+$count}}">
                                    <label id="imglabel-{{$i+$count}}" for="image-form-{{$i+$count}}">
                                        <img data-num="{{$i+$count}}" class="image_upload" src="{{ asset('wap/community/newclient/images/addpic.png') }}">
                                    </label>
                                    <i class="delete tc none" data-id="{{$i+$count}}"><i class="icon iconfont f20">&#xe605;</i></i>
                                    <input type="text" name="imgs[]" id="upimage_{{$i+$count}}" style="display:none">
                                </li>
                            @endfor
                        @endif
                    @else
                        @for($i=0; $i<=3; $i++)
                            <li id="li_{{$i}}">
                                <label id="imglabel-{{$i}}" for="image-form-{{$i}}">
                                    <img data-num="{{$i}}" class="image_upload" src="{{ asset('wap/community/newclient/images/addpic.png') }}">
                                </label>
                                <i class="delete tc none" data-id="{{$i}}"><i class="icon iconfont f20">&#xe605;</i></i>
                                <input type="text" name="imgs[]" id="upimage_{{$i}}" style="display:none">
                            </li>
                        @endfor
                    @endif
                @endif
            </ul>
        </div>
        <!--<div id="preview" @if($data)style="height: 200px;" @endif>
            @if($data)
                <img id="imghead" src="{{ formatImage($data['images'][0],640,640) }}" alt="" style="width: 100%;height: 10.5rem" >
            @else
                <img id="imghead" class="imghead"  style="width: 100%;height: 10.5rem">
            @endif
            @if($data)
                <div class="upload_again">@if($args['type'] == 1)点击上传商品图片@else点击上传服务图片@endif</div>
            @else
                <div class="upload_instructions">
                    <i class="icon iconfont right-ico">&#xe689;</i>
                    <p>点击上传图片</p>
                </div>
            @endif
        </div>-->
        <!--<input type="hidden" name="imgs[]" id="imgs" value="{{ $data['images'][0] }}"/>-->
        <input type="hidden" name="type" value="{{ $data['type'] or $args['type'] }}"/>
        <input type="hidden" value="{{ $data['cateId'] or $args['tradeId']}}" name="tradeId" />
        <input type="hidden" name="systemGoodsId" id="{{$data['id']}}" value="{{$data['id']}}">
        <div class="list-block">
            <ul>
                <li>
                    <div class="item-content">
                        <div class="item-inner">
                            <div class="item-title label">商品名称:</div>
                            <div class="item-input">
                                <input type="text" placeholder="必填" name="name" id="name" value="{{$showData['name'] or $data['name']}}">
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <!-- onclick="JumpURL('{!! u('Seller/getShopBrand') !!}')" -->
                    <a  onclick="$.showData1();">
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">品牌:</div>
                                <div class="item-input">
                                    <input type="text" class="f14" placeholder="请选择商品品牌" name="brand" id="brand" readonly="readonly" value="@if($args['brandName']) {{ $args['brandName'] }} @elseif ($data['shopBrand']['name']) {{ $data['shopBrand']['name'] }} @endif">
                                    <input type="hidden" name="brandId" value="@if($args['brandId']) {{ $args['brandId'] }} @else {{ $data['shopBrand']['id'] or 0 }}@endif">
                                </div>
                                <div><i class="icon iconfont">&#xe64b;</i></div>
                            </div>
                        </div>
                    </a>
                </li>
                <li>
                    <div class="item-content">
                        <div class="item-inner">
                            <div class="item-title label">商品编码:</div>
                            <div class="item-input">
                                <input type="text" class="f14" placeholder="请输入1-16位商品编码" name="goodsSn" id="goodsSn" maxlength="16" onKeyUp="value=value.replace(/[\W]/g,'')" value="{{$showData['goodsSn'] or $data['goodsSn']}}">
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="y-spbq" onclick="$.showSystemMsg()" >
            <span>商品标签:</span>
            <span class="fr">
                    <span id="systemTagList">{{$tag['pid']['name'] or '未选择'}}</span> - <span id="systemTag">{{$tag['name'] or '未选择'}}</span>
                    <input type="hidden" name="systemTagListPid" id="systemTagListPid" value="{{$data['systemTagListPid'] or 0}}">
                    <input type="hidden" name="systemTagListId" id="systemTagListId" value="{{$data['systemTagListId'] or 0}}">
                <i class="icon iconfont">&#xe64b;</i>
            </span>
        </div>
        <div id="yz_goods_extend" class="list-block add-b @if($data) @if($data['norms'])add-block @endif @endif show_norms">
            @if($data)
                @if($data['norms'])
                    @foreach( $data['norms'] as $k=> $v)
                        <div  id="del{{$v['id']}}" >
                            <div class="delete-but" onclick ="$.deletebut({{$v['id']}})">
                                <i class="icon iconfont right-ico">&#xe619;</i>
                            </div>
                            <ul class="goods-editer-b s-goods-editer-b">
                                <li>
                                    <div class="item-content">
                                        <div class="item-inner">
                                            <div class="item-title label">型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</div>
                                            <div class="item-input">
                                                <input type="hidden" placeholder="" name="norms[{{$k}}][id]" id="id" value="{{ $v['id'] }}">
                                                <input type="text" placeholder="尺寸，颜色，大小等" name="norms[{{$k}}][name]" id="norms" value="{{$v['name']}}">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-inner">
                                            <div class="item-title label">重量:</div>
                                            <div class="item-input">
                                                <input type="text" placeholder="请输入重量（公斤）"  name="norms[{{$k}}][weight]" id="weight">
                                            </div>
                                            <span class="unit">公斤</span>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-inner">
                                            <div class="item-title label">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:</div>
                                            <div class="item-input">
                                                <input type="text" placeholder="请输入金额（元）"  name="norms[{{$k}}][price]" id="price" value="{{$v['price']}}">
                                            </div>
                                            <span class="unit">元</span>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-inner">
                                            <div class="item-title label">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存:</div>
                                            <div class="item-input">
                                                <input type="text" name="norms[{{$k}}][stock]" placeholder="必须是数字"  id="stock" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" value="{{$v['stock']}}">
                                            </div>

                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    @endforeach
                @else
                    <ul class="goods-editer-b h-goods-editer-b">
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入金额（元）"  name="price" id="price" value="{{$showData['price'] or $data['price']}}">
                                    </div>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">重&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</div>
                                    <div class="item-input">
                                        <input type="text" class="f14" placeholder="请输入重量（公斤）" name="weight" id="weight" value="{{$showData['weight'] or $data['weight']}}">
                                    </div>
                                    <span class="unit">公斤</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="必须是数字"   value="{{$showData['stock'] or $data['stock']}}" name="stock" id="stock" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                @endif
            @else
                <ul class="goods-editer-b h-goods-editer-b">
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入金额（元）"  name="price" id="price" value="{{$showData['price'] or $data['price']}}">
                                </div>
                                <span class="unit">元</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">重&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</div>
                                <div class="item-input">
                                    <input type="text" class="f14" placeholder="请输入重量（公斤）" name="weight" id="weight" value="{{$showData['weight'] or $data['weight']}}" >
                                </div>
                                <span class="unit">公斤</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="必须是数字"  name="stock" id="stock"  value="{{$showData['stock'] or $data['stock']}}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            @endif
        </div>
        <div class="list-block add-block" id="yz_goods_processing_charges">
            @if($data['goodsProcessingCharges'])
                @foreach($data['goodsProcessingCharges'] as $k => $v)
                    <div id="del{{$k + 200}}" >
                        <div class="delete-but"   onclick="$.deletebut1({{$k + 200}})" style="margin-top:-30px;">
                            <i class="icon iconfont right-ico">&#xe619;</i>
                        </div>
                        <ul class="goods-editer-b" id="del{{$k + 200}}">
                            <input type="hidden" placeholder="" name="goodsProcessingCharges[{{$k + 200}}][id]" value="{{ $v['id'] }}">
                            <li>
                                <div class="item-content">
                                    <div class="item-inner">
                                        <div class="item-title label">加工形式:</div>
                                        <div class="item-input">
                                            <input type="text" placeholder="请输入加工形式" name="goodsProcessingCharges[{{$k + 200}}][name]" id="norms" value="{{ $v['name'] }}">
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="item-content">
                                    <div class="item-inner">
                                        <div class="item-title label">加工费用:</div>
                                        <div class="item-input">
                                            <input type="text" placeholder="请输入金额（元）"  name="goodsProcessingCharges[{{$k + 200}}][price]" id="price" value="{{ $v['price'] }}">
                                        </div>
                                        <span class="unit">元</span>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                @endforeach
            @endif
        </div>
        <div class="add_goods_specifications1 w_b">
            <i class="icon iconfont">&#xe618;</i>
            <p class="w_b_f_1">添加加工规格</p>
        </div>
        <div class="add_goods_specifications2 w_b">
            <i class="icon iconfont">&#xe618;</i>
            <p class="w_b_f_1">添加商品规格</p>
        </div>
        <div class="list-block">
            <ul>
                <li class="align-top">
                    <div class="item-content">
                        <div class="item-inner">
                            <div class="item-title label y-spadd">
                                <p>描述:</p>
                                <div style="   width:100%;			height:400px;">
                                    <script id="editor" name="brief" type="text/plain">{!!$showData['brief'] or $data['brief']!!}</script>
                                </div>
                                <script type="text/javascript">
                                    //实例化编辑器
                                    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
                                    var ue = UE.getEditor('editor',{
                                        toolbars:[['Source', 'Undo', 'Redo']]
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </form>
    <div class="blank0825"></div>
    <div class="all-add"></div>
@stop
@section("page_js")
    <script type="text/tpl" id="show_norms1">
                 <div id="del{idshow}" >
                    <div class="delete-but"   onclick="$.deletebut1({idshow})" style="margin-top:-30px;">
                        <i class="icon iconfont right-ico">&#xe619;</i>
                    </div>
                    <ul class="goods-editer-b" id="del{idshow}">
                        <input type="hidden" placeholder="" name="goodsProcessingCharges[{idshow}][id]">
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">加工形式:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入加工形式" name="goodsProcessingCharges[{idshow}][name]" id="norms">
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">加工费用:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入金额（元）"  name="goodsProcessingCharges[{idshow}][price]" id="price">
                                    </div>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </script>
    <script type="text/tpl" id="show_norms2">
                 <div id="del{idshow}">
                    <div class="delete-but"   onclick="$.deletebut2({idshow})" style="margin-top:42px;">
                        <i class="icon iconfont right-ico">&#xe619;</i>
                    </div>
                    <ul class="goods-editer-b s-goods-editer-b" id="del{idshow}">
                        <input type="hidden" placeholder="" name="norms[{idshow}][id]">
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">型号:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="尺寸，颜色，大小等" name="norms[{idshow}][name]" id="norms">
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">原价:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入金额（元）"  name="norms[{idshow}][price]" id="price">
                                    </div>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                        </li>
                        <!--<li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">折扣价:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入金额（元）"  name="norms[{idshow}][sale_price]" id="sale_price">
                                    </div>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                        </li>-->
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">重量:</div>
                                    <div class="item-input">
                                        <input type="text" placeholder="请输入重量（公斤）"  name="norms[{idshow}][weight]" id="weight">
                                    </div>
                                    <span class="unit">公斤</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="item-content">
                                <div class="item-inner">
                                    <div class="item-title label">库存:</div>
                                    <div class="item-input">
                                        <input type="text" name="norms[{idshow}][stock]" placeholder="必须是数字"  id="stock" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </script>
    <script type="text/tpl" id="hide_norms2">
                <ul class="goods-editer-b h-goods-editer-b">
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入金额（元）"  name="price" id="price">
                                </div>
                                <span class="unit">元</span>
                            </div>
                        </div>
                    </li>
                    <!-- <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">促销价&nbsp;&nbsp;&nbsp;:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入金额（元）"  name="sale_price" id="sale_price">
                                </div>
                                <span class="unit">元</span>
                            </div>
                        </div>
                    </li> -->
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">重&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入重量（公斤）"  name="weight" id="weight">
                                </div>
                                <span class="unit">公斤</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title label">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存:</div>
                                <div class="item-input">
                                    <input type="text" placeholder="必须是数字"  name="stock" id="stock" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </script>
    <script type="text/javascript">
        $(".add_goods_specifications2").unbind('click');
        $(".add_goods_specifications2").bind('click',function(){
            $("#yz_goods_extend").append($(" #show_norms2").html().replace(/\{idshow\}/g,idshow));
            $(".page-current .add-b").addClass("add-block");
            $(".page-current .add_goods_specifications2").css({"margin-top":"0.75rem"});
            if($(".page-current .s-goods-editer-b").length != 0){
                if($(".page-current .h-goods-editer-b").length != 0){
                    $(".page-current .h-goods-editer-b").remove();
                }
            }
            idshow ++;
        });
        $(".add_goods_specifications1").unbind('click');
        $('.add_goods_specifications1').bind('click',function () {
            $("#yz_goods_processing_charges").append($(" #show_norms1").html().replace(/\{idshow\}/g,idshow));
//                    $(".page-current .add-b").addClass("add-block");
            $(".page-current .add_goods_specifications1").css({"margin-top":"0.75rem"});
            /*if($(".page-current .s-goods-editer-b").length != 0){
             if($(".page-current .h-goods-editer-b").length != 0){
             $(".page-current .h-goods-editer-b").remove();
             }
             }*/
            idshow ++;
        });
        $.deletebut2 = function(delid){
            $(".page-current #del"+delid).remove();
            if($(".page-current .s-goods-editer-b").length == 0){
                $("#yz_goods_extend").removeClass("add-block").append($("#hide_norms2").html());
            }
        }
        $.deletebut1 = function(delid){
            $(".page-current #del"+delid).remove();
        }
    </script>
    <script type="text/javascript">
        var ue = UE.getEditor('editor',{
            toolbars:[['Undo', 'Redo']]
        });
        $(document).on('click','.image_upload', function () {
            var thisObj = $(this);
            $(this).fanweImage({
                width:320,
                height:320,
                callback:function(url, target) {
                    thisObj.get(0).src = url;
                    $("#upimage_"+thisObj.data('num')).val(url);
                    $("#imglabel-"+thisObj.data('num')).siblings(".delete").removeClass("none");
                }
            });
        });
        $.showData = function(){
            var query = $("#{{$id_action.$ajaxurl_page}} #goods-form").serialize();
            $.ajax({
                url: "{{u('Seller/showDataTwo')}}",
                dataType: "json",
                data:query,
                type: "POST",
                success: function(ajaxobj){
                    JumpURL("{!! u('Seller/getTagLists',['nav_back_url'=>$nav_back_url]) !!}",'{{$css}}',2);
                }
            });
        }

        $.showData1 = function(){
            var query = $("#{{$id_action.$ajaxurl_page}} #goods-form").serialize();

            $.ajax({
                url: "{{u('Seller/showDataTwo')}}",
                dataType: "json",
                data:query,
                type: "POST",
                success: function(ajaxobj){
                    JumpURL("{!! u('Seller/getShopBrand',['nav_back_url'=>$nav_back_url]) !!}",'{{$css}}',2);
                }
            });
        }
    </script>
@stop
@section($js)

    <script type="text/javascript">
        function CutCallBack(base64Img){
            if(base64Img.length <= 0){
                $.alert("获取图片失败！");
            }else{

                $("#upload_but").fanweImage({
                    width:640,
                    height:640,
                    callback:function(result) {
                        var div = document.getElementById('preview');
                        var upload_but=document.getElementById('upload_but');
                        var img = document.getElementById('imghead');
                        div.innerHTML ='<img id="imghead" src="'+result+'" style="width:100%"><div class=upload_again>点击上传商品图片</div>';
                        div.style.height='200px';
                        upload_but.style.height='200px';

                        var imgs=document.getElementById('imgs');
                        imgs.value = result;
                    }
                });

            }
        }
        if(window.App){
            $("#imglabel").removeAttr("for").bind('click',function(){
                App.CutPhoto('{"w":'+ 600 +',"h":'+600+'}');
            });
        }else{
            $(document).on('change', "#upload_but", function(){
                $.showIndicator();
                $(this).fanweImage({
                    width:640,
                    height:640,
                    callback:function(result) {
                        var div = document.getElementById('preview');
                        var upload_but=document.getElementById('upload_but');
                        var img = document.getElementById('imghead');
                        div.innerHTML ='<img id="imghead" src="'+result+'" style="width:100%"><div class=upload_again>点击上传商品图片</div>';
                        div.style.height='200px';
                        upload_but.style.height='200px';

                        var imgs=document.getElementById('imgs');
                        imgs.value = result;
                    }
                })

            });
        }
        $.showSystemMsg = function (){
            $.toast("平台商品禁止修改标签");
        }
    </script>
@stop
@section('show_nav')@stop