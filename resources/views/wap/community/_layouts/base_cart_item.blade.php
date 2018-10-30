<div class="bar bar-footer y-shopbtm">
    <div class="x-cart pr mr10 y-cart">
        <div>
            <i class="icon iconfont c-white">&#xe673;</i>
            <span class="badge pa c-bgfff c-red" id="cartTotalAmount">{{ $cart['totalAmount'] }}</span>
        </div>
    </div>

    <div class="y-shopmoney c-white f18 y-maxw48">￥<span id="cartTotalPrice">{{number_format($cart['totalPrice'], 2) }}</span></div>
    <div class="y-zbdxqymenuok fr">
        <a href="#" class="c-bgff9000 c-white f16 y-addshoppingcart">加入购物车</a>
        @if($data['type'] == 1)
            @if ($cart['totalPrice'] < $seller['serviceFee'])
                <a class="x-menuok c-gray97 c-white f13 fr choose_complet" href="javascript:$.href('{{u('GoodsCart/index',['id'=>Input::get('id'),'type'=>Input::get('type'),'t'=>rand()])}}')">还差￥{{number_format($seller['serviceFee'] - $cart['totalPrice'], 2) }}</a>
            @else
                <a class="x-menuok c-bg c-white f16 fr choose_complet" href="javascript:$.href('{{u('GoodsCart/index',['id'=>Input::get('id'),'type'=>Input::get('type'),'t'=>rand()])}}')">
                    选好了
                </a>
            @endif
        @else
            <a class="x-menuok c-bg c-white f16 fr choose_complete" href="#" data-id="{{$data['id']}}">选好了</a>
        @endif
    </div>
</div>
<div class="f-bgtk size-frame none showAlaertCartDsy">
    <div class="x-closebg">
    </div>
    <div class="y-shoppingbox">
        <div class="y-shoppingtop f14 c-gray5"><span>购物车</span><span class="fr y-delall"><i class="icon iconfont vat mr5">&#xe630;</i>删除全部</span></div>
        <div class="list-block media-list m0 y-shoppinglist f12" id="dsyShowUl">
            <ul id="ul_li_ul">
                @foreach($cart['goods'] as $dsyK => $dsyV)
                    <li class="item-content dsyId-{{(int)$dsyV['normsId']}}" id="dsyId-{{$dsyV['goodsId']}}-{{(int)$dsyV['normsId']}}-{{(int)$dsyV['processid']}}">
                        <div class="item-inner">
                            <div class="item-title-row">
                                <div class="item-title">{{$dsyV['name']}}<p style="font-size: 10px;margin-top: -3px;">规格：{{$dsyV['normsName'] or '无'}} , 加工：{{$dsyV['processingName'] or '无'}}</p></div>
                                <div class="item-after">
                                    <span class="c-red">
                                        ￥<span  id="cartTotalPrice_DsyPrice_{{$dsyV['goodsId']}}" class="cartTotalPrice_DsyPrice_{{$dsyV['normsId']}}">
                                            @if( $dsyV['sale'] == 10 )
                                                <!--$dsyV['num'] *-->
                                                {{number_format( ($dsyV['price'] + $dayV['processingPrice']), 2)}}
                                            @else
                                                <!--$dsyV['num'] *-->
                                                {{number_format( $dsyV['price'] * ($dsyV['sale']/10) + $dayV['processingPrice'], 2)}}
                                            @endif
                                        </span>
                                    </span>
                                    <div class="x-num fr ml5">
                                        <i class="icon iconfont c-gray udb_subtract fl">&#xe622;</i>
                                        <span class="val tc pl0 fl cartTotalPrice_DsyNum_{{$dsyV['normsId']}}-{{(int)$dsyV['normsId']}}-{{(int)$dsyV['processid']}}" data-newold="true" data-goodsid="{{$dsyV['goodsId']}}" data-normsid="{{ $dsyV['normsId'] }}" data-price="{{ $dsyV['price'] }}" data-saleprice="{{ ($dsyV['sale'] * $dsyV['price'] / 10)  }}" data-servicetime="{{$dsyV['serviceTime'] or 0}}" id="cartTotalPrice_DsyNum_{{$dsyV['goodsId']}}" data-processid="{{$dsyV['processid'] or 0}}">{{$dsyV['num']}}</span>
                                        <i class="icon iconfont c-red udb_add fl">&#xe61f;</i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                @endforeach
            </ul>
        </div>
    </div>
</div>
<script type="text/tpl" id="dsyHtml">
    <li class="item-content dsyId-NORMSID" id="dsyId-GOODSId">
        <div class="item-inner">
            <div class="item-title-row">
                <div class="item-title">NAME</div>
                <div class="item-after">
                    <span class="c-red">￥<span  id="cartTotalPrice_DsyPrice_GOODSId" class="cartTotalPrice_DsyPrice_NORMSID">MONERY</span></span>
                    <div class="x-num fr ml5">
                        <i class="icon iconfont c-gray udb_subtract fl">&#xe622;</i>
                        <span class="val tc pl0 fl cartTotalPrice_DsyNum_NORMSID" data-newold="true" id="cartTotalPrice_DsyNum_GOODSId"  data-goodsid="GOODSIDS" data-normsid="NORMSIDS" data-price="DSYPRICE" data-saleprice="SALEPRICE" data-servicetime="SERVICRTIME">MUN</span>
                        <i class="icon iconfont c-red udb_add fl">&#xe61f;</i>
                    </div>
                </div>
            </div>
        </div>
    </li>
</script>
<script>

    $(document).on("click",".x-cart",function(){
        var badgeval = $(this).find(".badge").text();
        if(!$(this).hasClass("active") && badgeval > 0){
            $(this).addClass("active");
            $(".page-current .showAlaertCartDsy").removeClass("none");
        }else{
            $(this).removeClass("active");
            $(".page-current .showAlaertCartDsy").addClass("none");
        }
        $(".y-shoppinglist").css("max-height",$(".y-shoppinglist li").height()*7);
    })
    $(document).on("click",".y-delall",function(){
        $.confirm("确认清空购物车吗？", function(){
            //加载提示
            $.showPreloader("正在清空购物车<br/>请稍候...");
            $.post("{{u('Goods/cartDelete')}}", { sellerId: {{ $data['sellerId']}} ,type: {{ $data['type']}} }, function(){
                //$.href("{!! $url !!}");
                $(".page-current .size-frame").addClass("none");
                $(".page-current #DsySale").html("0.00");
                $(".page-current #cartTotalAmount").html(0);
                $(".page-current #cartTotalPrice").html("0.00");
                $(".page-current .subtract").addClass("none");
                $(".page-current .val").addClass("none").html(0);
                $(".y-ggpsize2 span").attr("data-info",0);
                $(".show_item_norms_item li").attr("data-info",0);

                $(".page-current #dsyShowUl li").remove();
                var serviceFee = "{{ $seller['serviceFee'] }}";
                $("#goodsval{{$data['id']}}").val(0).addClass("none");
                var totalPrice = 0;
                @if("{{$data::['type']}}" == 1)
                if (totalPrice < serviceFee) {
                    var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                    $(".choose_complet").removeClass("c-bg").removeClass("f16").addClass("c-gray97").addClass("f13").html("还差￥" + differFee.toFixed(2));
                } else {
                    $(".choose_complet").removeClass("c-gray97").addClass("c-bg").addClass("f16").removeClass("f14").html("选好了");
                }
                $("#normsval_span").html(0).addClass("none");
                $(".show_item_norms_item_udb .subtract_norms_cz").addClass("none");

                @endif
                $.hidePreloader();
            });
        });
    })
    $(".x-closebg").click(function(){
        $(".x-cart").removeClass("active");
        $(".f-bgtk").addClass("none");
    });
    // 计算合计
    function CalculationTotal(goodsid, normsId, num, price,newGoods,newold)
    {

        //console.log(goodsid + " - "+normsId + " - "+ num + " - "+ price + " - "+ newGoods + " - "+ newold)
        var newGoodss = [];
        $.each(newGoods.data.list,function(ks,vs){
            $.each(vs.goods,function(k,v){
                if(v.goodsId == goodsid){
                    newGoodss['name'] = v.name;
                    newGoodss['mun'] = v.num;
                    newGoodss['price'] = v.price;
                    newGoodss['goodsId'] = v.goodsId;
                    newGoodss['sale'] = v.sale;
                    newGoodss['servicetime'] = v.serviceTime;
                    newGoodss['normsId'] = v.normsId;
                    return false;
                }
            });
        });
        if(num < 1) {
            if(normsId > 0 ){
                $(".page-current li.dsyId-"+normsId).remove();
            }else{
                $(".page-current li#dsyId-"+goodsid).remove();
            }
        }
        else{
            if(normsId > 0 ){
                var has = $(".page-current li.dsyId-"+normsId);
            }else{
                var has = $(".page-current li#dsyId-"+goodsid);
            }
            //修改
            if(has.html()){
                var money = price*num;
                var moneys = 0;
                if(money <= 0 ){
                    moneys  = "0.00";
                }else{
                    moneys = money.toFixed(2);
                }
                if(normsId > 0 ){
                    $(".page-current li#dsyId-"+goodsid+" .cartTotalPrice_DsyPrice_"+normsId).html(moneys);
                    $(".page-current li#dsyId-"+goodsid+" .cartTotalPrice_DsyNum_"+normsId).html(num);
                }else{
                    $(".page-current #cartTotalPrice_DsyPrice_"+goodsid).html(moneys);
                    $(".page-current #cartTotalPrice_DsyNum_"+goodsid).html(num);
                }
            }
            else{
                var money =  0;;
                // var newDsyM = 0;
                if(newGoodss['sale'] == 10){
                    // newDsyM = '';
                    money = newGoodss['price'] * newGoodss['mun'];
                    ''
                }else{
                    money = newGoodss['price'] * newGoodss['mun'] * (newGoodss['sale']/10);
                    // newDsyM = '<del class="c-gray f12 ml5">￥'+ newGoodss['price'].toFixed(2)+'</del>';
                }
                var moneys = 0;
                if(money == 0 ){
                    moneys  = "0.00";
                }else{
                    moneys = money.toFixed(2)
                }
                var html = $("#dsyHtml").html()
                        .replace('GOODSId',goodsid)
                        .replace('GOODSId',goodsid)
                        .replace('GOODSId',goodsid)
                        .replace('GOODSId',goodsid)
                        .replace('GOODSIDS',goodsid)
                        .replace('NORMSID',normsId ? normsId : 0)
                        .replace('NORMSID',normsId ? normsId : 0)
                        .replace('NORMSID',normsId ? normsId : 0)
                        .replace('NORMSIDS',normsId ? normsId : 0)
                        .replace('SALEPRICE',newGoodss['price'] * (newGoodss['sale']/10))
                        .replace('DSYPRICE',newGoodss['price'])
                        .replace('SERVICRTIME',newGoodss['servicetime'] ? newGoodss['servicetime'] : 0 )
                        .replace('NAME',newGoodss['name'])
                        .replace('MONERY',moneys)
                        .replace('MUN',newGoodss['mun']);
                // .replace('DELMONEY',newDsyM);
                $("#dsyShowUl ul").prepend(html);
            }
        }
        $("#cartTotalAmount").html(newGoods.data['totalAmount']);
        $("#cartTotalPrice").html(newGoods.data['totalPrice'].toFixed(2));
        $("#goodsval").val(newGoodss['mun']);
        $("#normsval_span").html(newGoodss['mun']);
        if($("#goodsval").val() <= 0){
            $(".subtract,#goodsval").addClass("none");
        }
        if(newGoods.data['totalAmount'] == 0){
            $(".size-frame").addClass("none");
        }
        @if("{{$data::['type']}}" == 1)
        var serviceFee = "{{ $seller['serviceFee'] }}";
        if (newGoods.data['totalPrice'] < serviceFee) {
            var differFee = parseFloat(serviceFee) - parseFloat(newGoods.data['totalPrice']);
            $(".choose_complet").removeClass("c-bg").addClass("c-gray97").html("还差￥" + differFee.toFixed(2));
        } else {
            $(".choose_complet").removeClass("c-gray97").addClass("f16").html("选好了");
        }
        @endif

    }
</script>