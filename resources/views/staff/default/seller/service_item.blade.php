
@if($args['type'] == 2)
    @foreach($goods as $v)
        @if($v['type'] == 2)
            <li class="fine-bor w_b del_data{{ $v['id'] }}" data-id="{{ $v['id'] }}">
                <input name="goodsId" value="{{ $v['id'] }}" type="checkbox" @if($args['goodsEdieIsCK'] == 1)checked @endif class="mt" style="@if($args['goodsEdieType'] == 1)display: inline-block; @endif"/>
                <div class="img_box" style="@if($args['goodsEdieType'] == 1)display: none; @endif" style="text-align: center;">
                    <img src="{{ $v['image'] }}" style="max-width: 70px;max-height: 50px;"/>
				</div>
                <div class="text" style="width:50%;">
                    <p style="word-break:keep-all; white-space:nowrap; overflow: hidden; text-overflow:ellipsis; width: 100%;">{{$v['name']}}</p>
                    <span>￥{{$v['price']}}</span>
                </div>
                <div class="w_b_f_1"></div>
                <div class="sales @if($args['goodsEdieType'] == 1)y-liwai  @endif">销量：{{$v['saleCount']}}</div>
                @if($v['cate']['autoType'] == 0)<a href="#" onclick="JumpURL('{{u('Seller/editnew',['type'=>2,'tradeId'=>$id,'id'=>$v['id']])}}','#seller_editnew_view',1)" style="@if($args['goodsEdieType'] == 1)display: inline; @endif" class="icon iconfont  big">&#xe61f;</a>@endif
            </li>
        @endif
    @endforeach
@else
    @foreach($goods as $v)
        @if($v['type'] == 1)
            <li class="fine-bor w_b del_data{{ $v['id'] }}" data-id="{{ $v['id'] }}">
                <input name="goodsId" value="{{ $v['id'] }}"  @if($args['goodsEdieIsCK'] == 1)checked @endif type="checkbox" class="mt" style="@if($args['goodsEdieType'] == 1)display: inline-block; @endif"/>
                <div class="img_box" style="@if($args['goodsEdieType'] == 1)display: none; @endif text-align: center;"><img src="{{ $v['image'] }}" style="max-width: 70px;max-height: 50px;"/></div>
                <div class="text" style="width:50%;">
                    <p style="word-break:keep-all; white-space:nowrap; overflow: hidden; text-overflow:ellipsis; width: 100%;">{{$v['name']}}</p>
                    <span>￥{{$v['price']}}</span>
                </div>
                <div class="w_b_f_1"></div>
                <div class="sales @if($args['goodsEdieType'] == 1)y-liwai @endif">销量：{{$v['saleCount']}}</div>
                @if($v['cate']['autoType'] == 0)<a href="#" onclick="JumpURL('{{u('Seller/editnew',['type'=>1,'tradeId'=>$id,'id'=>$v['id']])}}','#seller_editnew_view',1)" style="@if($args['goodsEdieType'] == 1)display: inline; @endif" class="icon iconfont  big">&#xe61f;</a>@endif
            </li>
        @endif
    @endforeach
@endif