<ul>
    @if($classifyList)
        @foreach($classifyList as $k => $v)
            <li ><input type="button" value="{{ $v['name'] }}" data-classify-id="{{ $v['id'] }}" class="button123 classify @if(isset($args['classifyId']) && ($args['classifyId'] == $v['id'])) a1 @endif" ></li>
        @endforeach
    @endif
</ul>