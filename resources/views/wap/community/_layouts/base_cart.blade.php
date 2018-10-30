<div class="bar bar-footer y-shopbtm">
    <div class="x-cart pr mr10 y-cart">
        <div>
            <i class="icon iconfont c-white">&#xe673;</i>
            <span class="badge pa c-bgfff c-red" id="cartTotalAmount">{{ $cart['totalAmount'] }}</span>
        </div>
    </div>
    <div class="y-shopmoney">
        <span class="c-white f18 y-maxw40">￥<span id="cartTotalPrice">{{number_format($cart['totalPrice'], 2) }}</span></span>
        <span class="f12 pl5 ml5 y-reduc">已减<span id="DsySale">{{number_format($cart['sale'], 2) }}</span>元</span>
    </div>
    @if ($cart['totalPrice'] < $seller['serviceFee'])
        <a class="x-menuok c-gray97 c-white f13 fr choose_complet" id="cartShow1" href="javascript:$.href('{{u('GoodsCart/index',['id'=>Input::get('id'),'type'=>Input::get('type'),'t'=>rand()])}}')">还差￥{{number_format($seller['serviceFee'] - $cart['totalPrice'], 2) }}</a>
    @else
        <a class="x-menuok c-bg c-white f16 fr choose_complet" id="cartShow2" href="javascript:$.href('{{u('GoodsCart/index',['id'=>Input::get('id'),'type'=>Input::get('type'),'t'=>rand()])}}')">选好了</a>
    @endif
</div>
<div class="f-bgtk size-frame none showAlaertCartDsy">
    <div class="x-closebg">
    </div>
    <div class="y-shoppingbox">
        <div class="y-shoppingtop f14 c-gray5"><span>购物车</span><span class="fr y-delall"><i class="icon iconfont vat mr5">&#xe630;</i>删除全部</span></div>
        <div class="list-block media-list m0 y-shoppinglist f12" id="dsyShowUl">
            <ul id="ul_li_ul">
                @foreach($cart['data']['goods'] as $dsyK => $dsyV)
                    <li class="item-content dsyId-{{$dsyV['normsId']}}" id="dsyId-{{$dsyV['goodsId']}}-{{(int)$dsyV['normsId']}}-{{(int)$dsyV['processid']}}">
                        <div class="item-inner">
                            <div class="item-title-row">
                                <!--<p style="font-size: 10px;margin-top: -3px;">(加工:{{$dsyV['processingName']}} 价格:￥{{$dsyV['processingPrice']}})</p>-->
                                <div class="item-title">{{$dsyV['name']}}<p style="font-size: 10px;margin-top: -3px;">规格：{{$dsyV['normsName'] or '无'}} , 加工：{{$dsyV['processingName'] or '无'}}</p></div>
                                <div class="item-after">
                                    <span class="c-red fl">
                                        ￥<span  id="cartTotalPrice_DsyPrice_{{$dsyV['goodsId']}}" class="cartTotalPrice_DsyPrice_{{$dsyV['normsId']}}">
                                            @if( $dsyV['sale'] == 10 )
                                                    <!--$dsyV['num'] * -->
                                                {{$dsyV['processingPrice'] + $dsyV['price']}}
                                            @else
                                                <!--$dsyV['num'] * -->
                                                {{($dsyV['processingPrice'] + ($dsyV['price'] * ($dsyV['sale']/10))) }}
                                            @endif
                                        </span>
                                    </span>
                                    <div class="x-num fr ml5">
                                        <i class="icon iconfont c-gray subtract1 fl">&#xe622;</i>
                                        <span class="val tc pl0 fl cartTotalPrice_DsyNum_{{$dsyV['normsId']}}-{{(int)$dsyV['normsId']}}-{{(int)$dsyV['processid']}}" data-newold="true" data-goodsid="{{$dsyV['goodsId']}}" data-normsid="{{ $dsyV['normsId'] }}" data-price="{{ $dsyV['price'] + $dsyV['processingPrice']}}" data-saleprice="{{ ($dsyV['sale'] * ($dsyV['price'] + $dsyV['processingPrice']) / 10)  }}" data-servicetime="{{$dsyV['serviceTime'] or 0}}" id="cartTotalPrice_DsyNum_{{$dsyV['goodsId']}}" data-processid="{{$dsyV['processid'] or 0}}">{{$dsyV['num']}}</span>
                                        <i class="icon iconfont c-red fl add1">&#xe61f;</i>
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
                        <i class="icon iconfont c-gray subtract fl">&#xe622;</i>
                        <span class="val tc pl0 fl cartTotalPrice_DsyNum_NORMSID" data-newold="true" id="cartTotalPrice_DsyNum_GOODSId"  data-goodsid="GOODSIDS" data-normsid="NORMSIDS" data-price="DSYPRICE" data-saleprice="SALEPRICE" data-servicetime="SERVICRTIME">MUN</span>
                        <i class="icon iconfont c-red add fl">&#xe61f;</i>
                    </div>
                </div>
            </div>
        </div>
    </li>
</script>
<script>

    $(".x-cart").click(function(){
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
    $(".y-delall").click(function(){
        $.confirm("确认清空购物车吗？", function(){
            //加载提示
            $.showPreloader("正在清空购物车<br/>请稍候...");
            $.post("{{u('Goods/cartDelete')}}", { sellerId: {{ $option['id']}} ,type: {{ $option['type']}} }, function(){
                //$.href("{!! $url !!}");
                $(".page-current .size-frame").addClass("none");
                $(".page-current #DsySale").html("0.00");
                $(".page-current #cartTotalAmount").html(0);
                $(".page-current #cartTotalPrice").html("0.00");
                $(".page-current .subtract").addClass("none");
                $(".page-current .val").addClass("none").html(0);
                if($(".page-current .y-ggpsize li").length > 1){
                    $(".page-current .y-ggpsize li").data("ns",0);
                }
                $(".page-current #dsyShowUl li").remove();
                var serviceFee = "{{ $seller['serviceFee'] }}";
                var totalPrice = 0;
                if (totalPrice < serviceFee) {
                    var differFee = parseFloat(serviceFee) - parseFloat(totalPrice);
                    $(".choose_complet").removeClass("c-bg").removeClass("f16").addClass("c-gray97").addClass("f13").html("还差￥" + differFee.toFixed(2));
                } else {
                    $(".choose_complet").removeClass("c-gray97").addClass("c-bg").addClass("f16").removeClass("f14").html("选好了");
                }
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

        if (typeof(cartgoods[goodsid]) == "undefined")
        {
            cartgoods[goodsid] = new Object();
        }
        if (normsId == "0" || normsId == 0 || normsId == null){
            normsId = "null";
        }
        cartgoods[goodsid][normsId] = { num: num, price: price };

        var totalAmount = 0;

        var totalPrice = 0.0;

        for(var goods in cartgoods)
        {
            delete cartgoods[goodsid][0]; //cz
            for (var item in cartgoods[goods])
            {
                totalAmount += parseInt(cartgoods[goods][item].num);

                totalPrice += cartgoods[goods][item].num * cartgoods[goods][item].price;
            }
        }
        if(newold == true || newold =="true"){
            if(normsId != "null" ){
                $(".page-current .show_item_norms_"+goodsid+" .show_item_id_"+normsId).data("ns",num);
            }else{
                $(".page-current .goodsId_show"+goodsid+" span").html(num);
            }
            if(num == 0) {
                $(".page-current .goodsId_show"+goodsid+" .subtract").addClass("none");
                $(".page-current .goodsId_show"+goodsid+" span").addClass("none");

            }else{
                $(".page-current .goodsId_show"+goodsid+" .subtract").removeClass("none");
                $(".page-current .goodsId_show"+goodsid+" span").removeClass("none");
            }
        }
        if(num < 1) {
            if(normsId != "null" ){
                $(".page-current li.dsyId-"+normsId).remove();
            }else{
                $(".page-current li#dsyId-"+goodsid).remove();
            }
        }
        else{
            if(normsId != "null" ){
                var has = $(".page-current li.dsyId-"+normsId);
            }else{
                var has = $(".page-current li#dsyId-"+goodsid);
            }
            //修改
            if(has.html()){
                var money = price*num;

                var moneys = 0;
                if(money == 0 ){
                    moneys  = "0.00";
                }else{
                    moneys = money.toFixed(2)
                }

                if(normsId != "null" ){
                    $(".page-current li#dsyId-"+goodsid+" .cartTotalPrice_DsyPrice_"+normsId).html(moneys);
                    $(".page-current li#dsyId-"+goodsid+" .cartTotalPrice_DsyNum_"+normsId).html(num);
                }else{
                    $(".page-current #cartTotalPrice_DsyPrice_"+goodsid).html(moneys);
                    $(".page-current #cartTotalPrice_DsyNum_"+goodsid).html(num);
                }
            }
            //追加
            else{
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
        $(".page-current #DsySale").html(newGoods.data['sale'].toFixed(2));
        $(".page-current #cartTotalAmount").html(newGoods.data['totalAmount']);
        $(".page-current #cartTotalPrice").html(newGoods.data['totalPrice'].toFixed(2));

        if(newGoods.data['totalAmount'] == 0){
            $(".size-frame").addClass("none");
        }

        if(totalAmount == 0){
            $(".size-frame").addClass("none");
        }
        var serviceFee = "{{ $seller['serviceFee'] }}";
        if (newGoods.data['totalPrice'] < serviceFee) {
            var differFee = parseFloat(serviceFee) - parseFloat(newGoods.data['totalPrice']);
            $(".choose_complet").removeClass("c-bg").removeClass("f16").addClass("c-gray97").addClass("f13").html("还差￥" + differFee.toFixed(2));
        } else {
            $(".choose_complet").removeClass("c-gray97").addClass("c-bg").addClass("f16").removeClass("f14").html("选好了");
        }
    }
</script>