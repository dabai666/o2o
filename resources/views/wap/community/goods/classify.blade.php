<ul>
	<li class="showall"><span>展开</span>&nbsp;<img src="../images/jtzk.png" style="width:.65rem;height:16px;"/></li>
	<li class="cutout none"><span>收起</span>&nbsp;<img src="../images/jtsq.png" style="width:.65rem;height:16px;"/></li>
    @if($classifyList)
        @foreach($classifyList as $k => $v)
            <li ><input type="button" value="{{ $v['name'] }}" data-classify-id="{{ $v['id'] }}" class="button123 classify @if(isset($option['classifyId']) && ($option['classifyId'] == $v['id'])) a1 @endif" ></li>
        @endforeach
    @endif
</ul>