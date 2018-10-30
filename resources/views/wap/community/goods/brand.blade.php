<ul id="brandListIdArr">
	<li class="showall"><span>展开</span>&nbsp;<img src="../images/jtzk.png" style="width:.65rem;height:16px;"/></li>
	<li class="cutout none"><span>收起</span>&nbsp;<img src="../images/jtsq.png" style="width:.65rem;height:16px;"/></li>
    @if($brandList)
        @foreach($brandList as $k => $v)
            <li><input type="button" value="{{ $v['name'] }}" data-brand-id="{{ $v['id'] }}" class="button123 brand @if(isset($option['brandId']) && ($option['brandId'] == $v['id'])) a1 teshu @endif "></li>
        @endforeach
    @endif
</ul>