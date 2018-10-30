
<?php
$cartgoods = [];
foreach($cart["data"]["goods"] as $good)
{
    if($good["normsId"]){
        $cartgoods[$good["goodsId"]][$good["normsId"]]  = ["num"=>$good["num"], "price"=>$good["price"]];
    }else{
        $cartgoods[$good["goodsId"]]  = ["num"=>$good["num"], "price"=>$good["price"]];
    }

    //$cartgoods[$good["goodsId"]][$good["normsId"]] = $good["num"];
}
$leftsort = 0;
$i = 0;
?>
@foreach($cate1 as $ckey => $item)
    @if(count($item['goods']) > 0)
        <div id="tab_{{$ckey}}" data-tabid = "{{$ckey}}" class="y-tab @if($item['id'] == Input::get('cateId')) active @else @if(Input::get('cateId') == "" && $leftsort == 0) active @endif  @endif">
            <div class="list-block media-list x-sortlst f14 nobor pr "><!--y-pull pull-to-refresh-content-->
                <ul>
                    @foreach($item['goods'] as $k=>$v)
                        <?php
                        //存在规格和折扣 获取规格最低价 根据折扣结算出新的特价
                        if(count($v['norms']) > 0 && !empty($v['activity']))
                        {
                            $f = true;
                            foreach ($v['norms'] as $key => $value) {
                                $salePrice = $value['price'] * $v['activity']['sale'] / 10;

                                $v['norms'][$key]['salePrice'] = $salePrice;

                                if($f)
                                {
                                    $v['activity']['minNormsPrice'] = $salePrice;
                                    $v['price'] = $value['price'];
                                    $f = false;
                                }
                                elseif(!$f && $salePrice <= $v['activity']['minNormsPrice'])
                                {
                                    $v['activity']['minNormsPrice'] = $salePrice; //最低折扣价
                                    $v['price'] = $value['price']; //最低原价
                                }

                            }
                        }

                        ?>
                        <li class="item-content">
                            <div class="item-inner pl0">
                                <div class="item-title">
                                    <a onclick="$.href('{{u('Goods/detail',['goodsId'=>$v['id'],'type'=>$v['type']])}}')" href="#" style="display: block;position: absolute;width: 70%;height: 3rem;"></a>
                                    <div>
                                        <div class="goodspic fl mr5">
                                            <img  src="@if($v['image']) {{ $v['image'] }} @else {{ asset('wap/community/client/images/wykdimg.png') }} @endif">
                                        </div>
                                        <span class="goodstit">{{$v['name']}}</span>
                                        @if($v['model'] && $v['model'] !== null)
                                            <span class="goodsmodel" style="font-size: .6rem;color: #ccc;display: block;margin-bottom: -0.5rem;">{{$v['model']}}</span>
                                        @endif
                                    </div>
                                    <div class="mt5">
                                        <span class="c-red f15">
                                            @if(empty($v['activity']))
                                                @if($v['salePrice'] > 0)
                                                    <span id="goodsddd_{{ $v['id'] }}">
                                                        {{ number_format($v['salePrice'], 2) }}
                                                    </span>
                                                    <span style="color: #999;font-size: .6rem;">@if($v['goodsUnit']) /{{ $v['goodsUnit'] }} @else /件 @endif</span>
                                                    <s style="color: #999;font-size: .6rem;">￥@if($v['norms']) {{ number_format($v['norms'][0]['price'],2) }}@else {{ number_format($v['price'],2) }} @endif</s>
                                                @else
                                                    <span id="goodsddd_{{ $v['id'] }}">
                                                        ￥@if($v['norms']) {{ number_format($v['norms'][0]['price'],2) }}@else {{ number_format($v['price'],2) }} @endif
                                                    </span>
                                                    <span style="color: #999;font-size: .6rem;">@if($v['goodsUnit']) /{{ $v['goodsUnit'] }} @else /件 @endif</span>
                                                @endif
                                            @else
                                                @if(empty($v['activity']['minNormsPrice']))
                                                    ￥{{number_format($v['activity']['salePrice'], 2)}} <!-- 折扣价 -->
                                                @else
                                                    ￥{{number_format($v['activity']['minNormsPrice'], 2)}} <!-- 规格最低价 -->
                                                @endif
                                                <del class="f12 c-gray ml5">￥{{number_format($v['price'], 2)}}</del>
                                            @endif
                                        </span>

                                        @if(count($v['norms']) < 1 && (count($v['goodsProcessingCharges']) < 1))
                                            <div class="x-num fr  goodsId_show{{$v['id']}}">
                                                <i class="icon iconfont c-gray subtract fl <?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>">&#xe622;</i>
                                                <span class="val tc pl0 fl <?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>" data-goodsid="{{$v['id']}}" data-normsid="0" data-price="{{ round($v['price'], 2) }}" data-saleprice="{{ round($v['activity']['salePrice'], 2) }}"><?php if(!$cartgoods[$v['id']][0]['num'] && !$cartgoods[$v['id']]['num']) echo "0"; else echo $cartgoods[$v['id']][0]['num'] ? $cartgoods[$v['id']][0]['num'] : $cartgoods[$v['id']]['num']; ?></span>
                                                <i class="icon iconfont c-red add fl" style="border: 1px solid #f00b0d;">&#xe61f;</i>
                                            </div>
                                        @else
                                            <div class="fr c-red f12 y-xgg totalPrice" style="border-color: red;" data-ids="{{$v['id']}}" data-name="{{$v['name']}}">选规格</div>
                                        @endif


                                        @if(!empty($v['activity']))
                                            <div class="y-specialprice f12"><a href="" class="f12">{{$v['activity']['sale']}}折特价</a></div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </li>
                        @if((count($v['norms']) > 0) || (count($v['goodsProcessingCharges']) >0))
                                <!-- 有子菜单 -->
                        <?php $t = 0; ?>
                        <div class="show_item_norms_{{$v['id']}} none">
                            <div class="y-xzggtc tl">
                                @if($v['norms'])
                                <p class="f14">选择规格</p>
                                <ul class="y-ggpsize clearfix">
                                    @foreach($v['norms'] as $nk => $n)
                                        <li class="@if($nk == 0) active @endif show_item_id_{{ $n['id']}}" data-ns="{{$cartgoods[$v['id']][$n['id']]['num']  or 0 }}" data-salePrice="{{round($n['salePrice'], 2)}}" data-prs="{{$n['price']}}" onclick='$.showItemNorms({{$v['id']}},"{{ $n['id'] }}","{{round($n['price'], 2)}}", "@if($n['salePrice'] > 0) {{round($n['salePrice'], 2)}} @else {{round($n['price'], 2)}} @endif")'>
                                            <a href="#">{{$n['name']}}</a>
                                        </li>
                                    @endforeach
                                </ul>
                                @endif
                                @if(count($v['goodsProcessingCharges']) > 0)
                                <p class="f14">加工方式</p>
                                <ul class="y-ggpsize clearfix process">
                                    @foreach($v['goodsProcessingCharges'] as $kkkk => $vvvv)
                                        <li class="process goodsId_show{{$v['id']}}" data-process-id="{{ $vvvv['id'] }}" data-process-price="{{ $vvvv['price'] }}" data-goods-id="{{ $v['id'] }}" data-id="{{ $v['id'] }}">
                                            <a href="#">{{$vvvv['name']}}</a>
                                        </li>
                                    @endforeach
                                </ul>
                                @endif
                            </div>
                            <div class="y-gmnum  pb10 clearfix">
                                @if(empty($v['activity']))
                                    <span class="f14 c-red">
                                                            ￥<span class="money_toal" id="money_toal_{{$v['id']}}">@if($v['norms'][0]['salePrice']){{ number_format($v['norms'][0]['salePrice'], 2) }}@else{{ number_format($v['norms'][0]['price'],2) }}@endif</span>
                                                        </span>
                                @else
                                    <span class="f14 c-red">
                                                            ￥<span class="money_toal" id="money_toal_{{$v['id']}}">{{ number_format($v['norms'][0]['salePrice'], 2) }}</span>
                                                        </span>
                                    <del class="c-gray f12 ml5">￥<span class="delPrice">{{ number_format($v['norms'][0]['price'], 2) }}</span></del>
                                @endif
                                <span class="f14 msg_show msg_show{{$v['id']}} none" style="color: red;font-size: 0.2rem !important;">抱歉：商品库存不足</span>
                                <div class="y-num fr goodsId_show{{$v['id']}} " >
                                    <i class="icon  iconfont c-gray subtract fl <?php if(!$cartgoods[$v['id']][$v['norms'][0]]['num'] && !$cartgoods[$v['id']]['num']) echo "none"; ?>">&#xe621;</i>
                                    <span id="goodsId_process_show_{{ $v['id'] }}" class="show_item_id_mnum val tc pl0 fl <?php if(!$cartgoods[$v['id']][$v['norms'][0]] && !$cartgoods[$v['id']]['num']) echo "none"; ?>" data-newold="false"  data-goodsid="{{$v['id']}}" data-normsid="{{$v['norms'][0]['id']}}" data-processid="" data-price="{{ round($v['norms'][0]['price'], 2) }}" data-saleprice="{{ round($v['norms'][0]['salePrice'], 2) }}"><?php if(!$cartgoods[$v['id']][$v['norms'][0]] && !$cartgoods[$v['id']]['num']) echo "0"; else echo $cartgoods[$v['id']][$v['norms'][0]['id']]['num'] ? $cartgoods[$v['id']][$v['norms'][0]['id']]['num'] : $cartgoods[$v['id']]['num']; ?></span>
                                    <i class="icon iconfont c-red add fl">&#xe61e;</i>
                                </div>
                                @if(!empty($v['activity']))
                                    <div class="y-specialprice f12 ml0"><a href="">{{$v['activity']['sale']}}折特价</a></div>
                                @endif
                            </div>
                        </div>
                        @endif
                    @endforeach
                </ul>
            </div>
        </div>
        <?php $leftsort++; ?>
    @endif
@endforeach