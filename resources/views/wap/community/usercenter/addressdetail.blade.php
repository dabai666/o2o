@extends('wap.community._layouts.base')

@section('css')
<style>
    .y-bjshaddr.list-block .item-media{width: 3.5rem;}
</style>
@stop

@section('show_top')
 <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left" href="@if(!empty($nav_back_url))javascript:$.href('{!! $nav_back_url !!}@if(!$is_not)cartIds={{Input::get('cartIds')}}@endif') @else javascript:$.back(); @endif" data-transition='slide-out'>
        <span class="icon iconfont">&#xe600;</span>返回
    </a>
    <a href="javascript:addr_save()" class="button button-link button-nav pull-right open-popup" data-popup=".popup-about">
        <span class="icon iconfont c-gray f24">&#xe610;</span>
    </a>
    <h1 class="title f16">我的{{ $title }}</h1>
</header>
@stop

@section('content')
    <div class="content" id=''>
            <div class="list-block mt10 f14 y-bjshaddr">
                <ul>
                    <li class="item-content">
                        <div class="item-media">
                            <span>定位城市：</span>
                        </div>
                        <div class="item-inner">
                            <div class="item-title @if(empty($data['id'])) cityurl @endif">
                                <input type="text" name="city"  id="city" placeholder="@if($data['city']['name']){{ $data['city']['name'] }} @else 点击选择城市 @endif" readonly="" />
                            </div>
                            @if(empty($data['id'])) <div class="item-after f12 c-black cityurl">更换城市</div> @endif
                        </div>
                    </li>
                    <li class="item-content @if((int)Input::get('gps') != 1) none @endif" id="area-li">
                        <div class="item-media">
                            <span>定位区县：</span>
                        </div>
                        <div class="item-inner">
                            <div class="item-title">
                                <select name="area" id="area">
                                    <option value="0">请选择</option>
                                    @foreach($city as $val)
                                        <option value="{{ $val['id']}}" @if($data['areaId'] == $val['id']) selected @endif>{{$val['name']}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </li>
                    <li class="item-content">
                        <div class="item-media">
                            <span>地&nbsp;&nbsp;&nbsp;&nbsp;址：</span>
                        </div>
                        <input type="hidden" name="detailAddress" id="address" value="{{ $data['detailAddress'] }}"/>
                        <div class="item-inner ml10">
                            <div class="item-title mapurl y-max-w75">
                                <input type="text" class="pl0" id="address2" placeholder="@if($data['detailAddress']){{ $data['detailAddress'] }} @else 点击选择地址 @endif" readonly="">
                            </div>
                        </div>
                        <div class="item-after f12 c-black" id="nowaddress" style="color:#fff !important;background:red;padding:0 2px;">立即定位</div>
                    </li>
                    <li class="item-content">
                        <div class="item-media">
                            <span></span>
                        </div>
                        <div class="item-inner">
                            <div class="item-title">
                                <input type="text" name="doorplate" id="doorplate" placeholder="输入楼号门牌号等详细信息" maxlength="20"  value="{{ $data['doorplate'] }}"/>
                            </div>
                        </div>
                    </li>
                    <li class="item-content">
                        <div class="item-media">
                            <span>收货人：</span>
                        </div>
                        <div class="item-inner">
                            <div class="item-title">
                                <input type="text" name="name"  id="name" placeholder="请输入收货人姓名" value="{{ $data['name'] }}" maxlength="8"/>
                            </div>
                        </div>
                    </li>
                    <li class="item-content">
                        <div class="item-media">
                            <span>电&nbsp;&nbsp;&nbsp;&nbsp;话：</span>
                        </div>
                        <div class="item-inner">
                            <div class="item-title">
                                <input type="text" name="mobile"  id="mobile" placeholder="请输入收货人电话" value="{{ $data['mobile'] }}" maxlength="11"/>
                            </div>
                        </div>
                    </li>
                    @if($data['id'] > 0)
                        <!-- 编辑 -->
                        @if(!empty($data['mapPoint']) && !is_array($data['mapPoint']))
                            <input type="hidden" id="map_point" value="{{$data['mapPoint']}}"/>
                        @else
                            <input type="hidden" id="map_point" value="{{$data['mapPointStr']}}"/>
                        @endif
                    @else
                        <!-- 新增 -->
                        <input type="hidden" id="map_point" value="{{$data['mapPoint']}}"/>
                    @endif
                    <input type="hidden" id="id" value="{{ $data['id'] }}" />
                    <input type="hidden" id="city_id" value="{{ $data['cityId'] }}" />
                </ul>
            </div>
        </div>
@stop

@section($js)
    @include('wap.community._layouts.gps')
    <script type="text/javascript">
    var cartIds = "{{ Input::get('cartIds') }}";

    var mapurl = "{!! urldecode(u('UserCenter/addressmap',['SetNoCity'=>Input::get('SetNoCity'),'address'=>$defaultAddress['address'],'mapPointStr'=>$defaultAddress['mapPointStr'],'cityId'=>$defaultAddress['cityId']])) !!}";

    var id = "{{ Input::get('id') }}";
    var plateId = "{{ Input::get('plateId') }}";
    var postId = "{{ Input::get('postId') }}";
    var cityurl  = "{!! urldecode(u('Index/cityservice',['type'=>1,'SetNoCity'=>Input::get('SetNoCity')])) !!}&cartIds="+cartIds;
    var change = "{{ Input::get('change') }}";
    var arg = "{{ $arg }}";

    $(function($){
        $(document).on("touchend",".cityurl",function(){
            $.router.load(cityurl, true);
        })

        $("#nowaddress").click(function(){
            $.showPreloader('定位中请稍候...');
            $.gpsPosition(function(gpsLatLng, city, address, mapPointStr, area){
                $.hidePreloader();
                var data = {
                    "address":address,
                    "mapPointStr":mapPointStr,
                    "city":city,
                    "area":area
                };
                $.post("{{ u('UserCenter/saveMap') }}",data,function(res){
                    if(res.code == 1){
                        $.toast("抱歉，当前城市未开通服务，请选择其他城市吧");
                    }else{
                        $("#address").val(address);
                        $("#address2").val(address);
                        $("#city").val(city);
                        $("#map_point").val(mapPointStr);
                        $("#city_id").val(res.data.id);

                        areaSelect = "";
                        areas = res.data.areas;
                        if(areas.length > 0){
                            for(i = 0; i < areas.length; i++){
                                if(res.data.area.id == areas[i].id){
                                    areaSelect += "<option selected value='"  + areas[i].id + "'>" + areas[i].name + "</option>";
                                } else {
                                    areaSelect += "<option value='"  + areas[i].id + "'>" + areas[i].name + "</option>";
                                }

                            }
                            $("#area").append(areaSelect);
                            $("#area-li").removeClass("none");
                        }
                    }
                },"json");
            })
        });

        $(".mapurl").unbind("touchend");
        $(document).on("touchend",".mapurl",function(){
            if (cartIds != '') {
                mapurl = "{!! u('UserCenter/addressmap',['SetNoCity'=>Input::get('SetNoCity')]) !!}&cartIds=" + cartIds;
            }
            if (plateId > 0) {
                mapurl = "{!! u('UserCenter/addressmap',['SetNoCity'=>Input::get('SetNoCity')]) !!}&plateId=" + plateId + "&postId=" + postId;
            }
            if(id > 0) {
                mapurl = "{!! u('UserCenter/addressmap',['SetNoCity'=>Input::get('SetNoCity')]) !!}&id=" + id;
            }
            if(change > 0) {
                mapurl = "{!! u('UserCenter/addressmap',['SetNoCity'=>Input::get('SetNoCity')]) !!}&change=" + change;
            }


            var data = getData();
            $.post("{{ u('UserCenter/saveAddrData') }}",data,function(res){
                $.href(mapurl);
            },"json");
            
        })

        $(document).on("touchend", ".y-mraddrmain", function(){
            $(this).find(".y-fxk .iconfont").toggle();
            if($(this).hasClass("on")){
                $(this).removeClass("on");
            }else{
                $(this).addClass("on");
            }
        });

    })

    function getData(){
        var obj = new Object();
        obj.id = $.trim($("#id").val());
        obj.name = $.trim($("#name").val())
        obj.mobile = $.trim($("#mobile").val());
        obj.detailAddress = $.trim($("#address").val());
        obj.mapPoint = $.trim($("#map_point").val());
        obj.doorplate = $.trim($("#doorplate").val());
        obj.cityId = $.trim($("#city_id").val());
        obj.areaId = $.trim($("#area").val());
        obj.SetNoCity = "{{ Input::get('SetNoCity') }}";
        return obj;
    }

    function addr_save() {
        $.showPreloader('请稍候...');
        var data = getData();
        $.post("{{ u('UserCenter/saveaddress') }}",data,function(res){
            $.hidePreloader();
            if(res.code == 0){
                if(arg > 0) {
                    var return_url = "{!! u('Order/order') !!}?cartIds=" + arg+'&addressId='+res.data.id;
                }else if(cartIds != '') {
                    var return_url = "{!! u('GoodsCart/index',['cartIds'=>Input::get('cartIds'),'addressId' => ADDID]) !!}".replace("ADDID", res.data.id);
                } else if (plateId > 0) {
                    var return_url = "{!! u('Forum/addbbs',['plateId'=>Input::get('plateId'),'postId'=>Input::get('postId'),'addressId' => ADDID]) !!}".replace("ADDID", res.data.id);
                }else if(change > 0) {
                    var return_url = "{!! u('UserCenter/address',['SetNoCity'=>Input::get('SetNoCity')]) !!}?change=" + change;
                }else{
                    var return_url = "{!! u('UserCenter/address',['SetNoCity'=>Input::get('SetNoCity')]) !!}";
                } 
                $.alert(res.msg,function(){
                    $.router.load(return_url, true);
                });
            }else{
                $.alert(res.msg);
            }
        },"json");
    }
</script>
@stop
